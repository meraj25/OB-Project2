import { 
    findAllTasks ,
    findByAssignee,
    findById,
    findByStatus,
    findByCreator,
    create,
    updateById,
    deleteById } from "../repositories/Task.repository";

const structured_task = (task:any) => ({
    ...task,
    creator: task.users,
    assignee: task.task_assignees?.map((ta:any) => ta.users) ?? [],
    users: undefined,
    task_assignees: undefined
});

const getAllTasks = async () => {
    const tasks = await findAllTasks();
    return tasks.map(structured_task);
};

const getTaskById = async (task_id: number) => {
    const task = await findById(task_id);
    if(!task){
        throw{ status:404, message: "Task not found!"}
    }
    return structured_task(task)
};

const createTask = async (data:{title: string , description: string, created_by: number}) => {

    if(!data.title){
        throw{ status:400, message: "Title is required!"}
    }
    if(!data.description){
        throw{ status:400, message: "Description is required!"}
    }
    if(!data.created_by){
        throw{ status:400, message: "Creator's Id is required!"}
    }

    const task = await create(data)
    return task;

}

const getTaskByAssignee = async(assigneeId: number) => {

    const task = await findByAssignee(assigneeId);
    if(task.length === 0){
        throw{ status:404, message: "No tasks found!"}
    }

    return structured_task(task);
}

const getTaskByStatus = async(status: string) => {
    const task = await findByStatus(status);
    if(task.length === 0){
        throw{ status:404, message: "No tasks found!"}
    }
    return structured_task(task);
}

const getTaskByCreator = async(created_by: number) => {
    const task = await findByCreator(created_by)
    if(task.length === 0){
        throw{ status:404, message: "No tasks found!"}
    }

    return structured_task(task);

}


const updateTask = async (task_id: number, data: Partial<{ title: string, description: string, status: string }>) => {

    try{
         return await updateById(task_id,data);
    }catch(error){
        throw { status: 404, message: "Task not found" };
    }
}

const deleteTask = async (task_id: number) => {
   try{
    return await deleteById(task_id)
   }catch(error){
        throw { status: 404, message: "Task not found" };
   }
}

export {
    getAllTasks,
    getTaskByAssignee,
    getTaskByCreator,
    getTaskById,
    getTaskByStatus,
    createTask,
    updateTask,
    deleteTask}
