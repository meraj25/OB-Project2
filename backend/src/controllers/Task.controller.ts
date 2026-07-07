import { 
    getAllTasks,
    getTaskByAssignee,
    getTaskByCreator,
    getTaskById,
    getTaskByStatus,
    createTask,
    updateTask,
    deleteTask } from "../services/Task.service";
import { Request,Response,NextFunction } from "express";

const GetAllTasks = async (req:Request, res:Response,next:NextFunction) => {

    try{
    const tasks = await getAllTasks();
    res.status(200).json(tasks)
    }catch(error){
        next(error)

    }

};

const GetTaskById = async (req:Request,res:Response,next:NextFunction) => {

    try{

        const task_id = Number(req.params.id)
        if(!task_id){
            return res.status(400).json({error:"invalid task id"})
        }
        if(isNaN(task_id)){
            return res.status(400).json({error:"please enter a valid task id "})
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
            return res.status(400).json({error:"invalid assignee id"})
        }
        if(isNaN(assignee_id)){
            return res.status(400).json({error:"please enter a valid assignee id "})
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
            return res.status(400).json({error:"invalid creator id"})
        }
        if(isNaN(creator_id)){
            return res.status(400).json({error:"please enter a valid creator id "})
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
            return res.status(400).json({error:"invalid status"})
        }

        const tasks = await getTaskByStatus(status)

        res.status(200).json(tasks);

    }catch(error){
        next(error)
    }

}

const UpdateTask = async(req:Request,res:Response,next:NextFunction) => {

    try{

        const task_id = Number(req.params.id)
        if(isNaN(task_id)){
            return res.status(400).json({error:"please enter a valid task id "})
        }
        const data = req.body
        await updateTask(task_id,data)
        res.status(201).json("task updated successfully")


    }catch(error){
        next(error)
    }

}

const DeleteTask = async(req:Request,res:Response,next:NextFunction) => {

    try{

        const task_id = Number(req.params.id)
        if(isNaN(task_id)){
            return res.status(400).json({error:"please enter a valid task id "})
        }

        await deleteTask(task_id);
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
    DeleteTask}