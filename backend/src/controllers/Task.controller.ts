import { 
    getAllTasks,
    getTaskByAssignee,
    getTaskByCreator,
    getTaskById,
    getTaskByStatus,
    createTask,
    updateTask,
    deleteTask,
    getTasks } from "../services/Task.service";
import { Request,Response,NextFunction } from "express";        
import ValidationError from "../domain/errors/validation-error";
import NotFoundError from "../domain/errors/not-found-error";





const GetAllTasks = async (req:Request, res:Response,next:NextFunction) => {

    try{
    const tasks = await getAllTasks();
    res.status(200).json(tasks)
    }catch(error){
        next(error)

    }

};

const GetTasks = async (req:Request,res:Response,next:NextFunction) => {

    try{

        const results = await getTasks(req.query)
        res.status(200).json(results)

    }catch(error){
     next(error)
    }
}

const GetTaskById = async (req:Request,res:Response,next:NextFunction) => {

    try{

        const task_id = Number(req.params.id)
        if(!task_id){
            return new ValidationError("Required field")
        }
        if(isNaN(task_id)){
            return new ValidationError("Please enter a valid task_id")
        }

        const tasks = await getTaskById(task_id);

        res.status(200).json(tasks)

    }catch(error){
        next(error)
    }
}

const CreateTask = async(req:Request, res:Response,next:NextFunction) => {

    try{
        const data = req.body
        const task = await createTask(data)
        res.status(201).json(task)

    }catch(error){
    next(error)
    }

}

const GetTasksByAssignee = async (req:Request,res:Response,next:NextFunction)  => {

    try{
        const assignee_id = Number(req.params.assigneeId)
        if(!assignee_id){
            return new ValidationError("Required field")
        }
        if(isNaN(assignee_id)){
            return new ValidationError("Invalid input")
        }
        const tasks = await getTaskByAssignee(assignee_id)

        res.status(200).json(tasks)

    }catch(error){
        next(error)
    }

}

const GetTaskByCreator = async (req:Request,res:Response,next:NextFunction) => {

    try{

        const creator_id = Number(req.params.creatorId)
        if(!creator_id){
            return new ValidationError("Required field")
        }
        if(isNaN(creator_id)){
            return new ValidationError("Invalid field")
        }
        const tasks = await getTaskByCreator(creator_id)

        res.status(200).json(tasks)


    }catch(error){

        next(error)
    }
}

const GetTasksByStatus = async (req:Request,res:Response,next:NextFunction) => {

    try{

        const status = String(req.params.status)

        if(!status){
            return new ValidationError("Required field")
        }

        const tasks = await getTaskByStatus(status)

        res.status(200).json(tasks);

    }catch(error){
        next(error)
    }

}

const UpdateTask = async(req:Request,res:Response,next:NextFunction) => {

    try{

        const user_id = req.user.user_id;

        const task_id = Number(req.params.id)
        if(isNaN(task_id)){
            return new ValidationError("Invalid field");
        }
        const data = req.body
        await updateTask(task_id,data,user_id)
        res.status(201).json("task updated successfully")


    }catch(error){
        next(error)
    }

}

const DeleteTask = async(req:Request,res:Response,next:NextFunction) => {

    try{
        const user_id = req.user.user_id;

        const task_id = Number(req.params.id)
        if(isNaN(task_id)){
            return new ValidationError("Invalid filed");
        }

        await deleteTask(task_id,user_id);
        res.status(201).json("Task deleted successfully")

    }catch(error){

        next(error)
    }
}

export {
    GetAllTasks,
    GetTaskByCreator,
    GetTaskById,
    GetTasksByAssignee,
    GetTasksByStatus,
    CreateTask,
    UpdateTask,
    DeleteTask,
    GetTasks}