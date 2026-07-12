import { updateTask, deleteTask } from "../services/Task.service";        
import { findById, updateById, deleteById } from "../repositories/Task.repository"; 
import ForbiddenError from "../domain/errors/forbidden-error";
import NotFoundError from "../domain/errors/not-found-error"; 

jest.mock("../repositories/Task.repository", () => ({
  findById: jest.fn(),
  updateById: jest.fn(),
  deleteById: jest.fn(),
}));

describe("updateTask", () => {
  const creatorId = 1;
  const userId = 2;
  const existingTask = { id: 10, title: "web development", created_by: creatorId };

  it("throws NotFoundError when the task does not exist", async () => {
    (findById as jest.Mock).mockResolvedValue(null);

    await expect(
      updateTask(10, { title: "title" }, creatorId)
    ).rejects.toThrow(NotFoundError);
  });

  it("blocks a user from updating someone else's task ", async () => {
    (findById as jest.Mock).mockResolvedValue(existingTask);

    await expect(
      updateTask(10, { title: "title 2" }, userId)
    ).rejects.toThrow(ForbiddenError); 

    expect(updateById).not.toHaveBeenCalled();
  });

  it("allows the creator to update their own task", async () => {
    (findById as jest.Mock).mockResolvedValue(existingTask);
    (updateById as jest.Mock).mockResolvedValue({ ...existingTask, title: "full stack" });

    const result = await updateTask(10, { title: "full stack" }, creatorId);

    expect(result.title).toBe("full stack");
    expect(updateById).toHaveBeenCalledTimes(1);
  });
});

describe("deleteTask", () => {
  const creatorId = 1;
  const userId = 2;
  const existingTask = { id: 10, title: "bug fixing", created_by: creatorId };

  it("throws NotFoundError when the task does not exist", async () => {
    (findById as jest.Mock).mockResolvedValue(null);

    await expect(deleteTask(10, creatorId)).rejects.toThrow(NotFoundError);
  });

  it("blocks a user from deleting someone else's task", async () => {
    (findById as jest.Mock).mockResolvedValue(existingTask);

    await expect(
      deleteTask(10, userId)
    ).rejects.toThrow(ForbiddenError); 
    expect(deleteById).not.toHaveBeenCalled();
  });

  it("allows the owner to delete their own task", async () => {
    (findById as jest.Mock).mockResolvedValue(existingTask);
    (deleteById as jest.Mock).mockResolvedValue(undefined);

    await deleteTask(10, creatorId);

    expect(deleteById).toHaveBeenCalledTimes(1);
    expect(deleteById).toHaveBeenCalledWith(10);
  });
});