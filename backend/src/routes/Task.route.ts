import express from "express"
import { 
    GetAllTasks,
    GetTaskByCreator,
    GetTaskById,
    GetTasksByAssignee,
    GetTasksByStatus,
    CreateTask,
    UpdateTask,
    DeleteTask,
    GetTasks
    } from "../controllers/Task.controller"
import { validateToken } from "../middleware/JWT";


   const TaskRouter = express.Router();

   TaskRouter
     .route("/")
     .get(validateToken,GetTasks)
     .post(validateToken,CreateTask)

   TaskRouter
     .route("/status/:status")
     .get(validateToken,GetTasksByStatus)

    TaskRouter
     .route("/assignees/:assigneeId")
     .get(validateToken,GetTasksByAssignee)

    TaskRouter
     .route("/created_by/:creatorId")
     .get(validateToken,GetTaskByCreator)


     TaskRouter
     .route("/:id")
     .get(validateToken,GetTaskById)
     .patch(validateToken,UpdateTask)
     .delete(DeleteTask)

    

    
export default TaskRouter;
