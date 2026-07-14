import { 
    findAllTasks ,
    findByAssignee,
    findById,
    findByStatus,
    findByCreator,
    create,
    updateById,
    deleteById,
    findPaginated } from "../repositories/Task.repository";

import {CreateTaskDTO , UpdateTaskDTO} from "../domain/dto/CreateTaskDTO";
import NotFoundError from "../domain/errors/not-found-error";
import UnauthorizedError from "../domain/errors/unauthorized-error";
import ValidationError from "../domain/errors/validation-error";
import ForbiddenError from "../domain/errors/forbidden-error";



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

const getTasks = async (query:{status?:string,assignee?:number,creator?: number , page?:string,limit?:string}) => {

    const page = Math.max(1,Number(query.page) || 1);
    const limit = Math.min(100,Math.max(1,Number(query.limit || 10)));

    const assignee = query.assignee ? Number(query.assignee) : undefined;
    if (query.assignee && isNaN(assignee as number)) {
    throw { status: 400, message: "assignee must be a valid number" };
    } 

    const creator = query.creator ? Number(query.creator) : undefined;
    if (query.creator && isNaN(creator as number)) {
        throw { status: 400, message: "creator must be a valid number" };
    }

    const validStatus = ["To Do","In Progress","Done"]
    if(query.status && !validStatus.includes(query.status)){
        throw { status: 400, message: "Invalid status value" };
    }

    const {tasks, totalCount} = await findPaginated({status:query.status,assignee,creator,page,limit}) ;

    return {
        data:tasks.map(structured_task),
        pagination:{
            page,
            limit,
            totalCount,
            totalPages: Math.ceil(totalCount/limit),

        },
    };

};

const getTaskById = async (task_id: number) => {
    const task = await findById(task_id);
    if(!task){
        throw new NotFoundError("task now found!");
    }
    return structured_task(task)
};

const createTask = async (data:{title: string , description: string,status:string, created_by: number,assigneeIds?:number[]}) => {

    if(!data.title){
        throw new ValidationError("Required field!")
    }
    if(!data.description){
        throw new ValidationError("Required field!")
    }
    if(!data.created_by){
        throw new ValidationError("Required field!")
    }
    if(!data.status){
        throw new ValidationError("Required field!")
    }

    const parsed = CreateTaskDTO.safeParse(data)
    if(!parsed.success){
        throw new ValidationError("validation error")
    }

    const task = await create(parsed.data)
    return task;

}

const getTaskByAssignee = async(assigneeId: number) => {

    const task = await findByAssignee(assigneeId);
    if(task.length === 0){
        throw new NotFoundError("Not found!");
    }

    return structured_task(task);
}

const getTaskByStatus = async(status: string) => {
    const task = await findByStatus(status);
    if(task.length === 0){
        throw new NotFoundError("Not found!");
    }
    return structured_task(task);
}

const getTaskByCreator = async(created_by: number) => {
    const task = await findByCreator(created_by)
    if(task.length === 0){
        throw new NotFoundError("Not found!");
    }

    return structured_task(task);

}


const updateTask = async (task_id: number, data: Partial<{ title: string, description: string, status: string }>,user_id:number) => {

    try{

        const parsed = UpdateTaskDTO.safeParse(data);

        if(!parsed.success){
             throw new ValidationError("Bad request")
        }

        const task = await findById(task_id);

        if(!task){
            throw new NotFoundError("Not found!");
        }

        if(task.created_by !== user_id){

            throw new ForbiddenError("Only the creator can update this task")
        }

        if(task.created_by === user_id){

            return await updateById(task_id,data);
        }

    }catch(error){
        throw error;
    }
}

const deleteTask = async (task_id: number,user_id:number) => {
   try{

    const task = await findById(task_id)

    if(!task){
        throw new NotFoundError("No tasks found!");
    }

    if(task.created_by !== user_id){
        throw new ForbiddenError("Only the creator can update this task")
    }

    if(task.created_by === user_id){

            return await deleteById(task_id)
    }


    }catch(error){
        throw error;
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
    deleteTask,
    getTasks}
