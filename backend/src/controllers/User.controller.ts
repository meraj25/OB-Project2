import { getAllUsers,getUserById,login,createUser,updateUser } from "../services/User.service";
import {Request,Response,NextFunction, response} from "express"

const Login = async (req:Request,res:Response,next:NextFunction) => {
    try{

        const {user , accessToken} = await login(req.body)

        res.cookie("access-Token", accessToken,{
            maxAge: 24 * 60 * 60 * 1000, 
            httpOnly: true,
            sameSite: "lax",
        });

        res.status(200).json(user)


    }catch(error){
        next(error)

    }
}

const getallUsers = async (req:Request, res:Response, next:NextFunction) => {

    try{

        const users = await getAllUsers();
        res.status(200).json(users)

    }catch(error){
        next(error)

    }
}

const getuserbyId = async (req:Request, res:Response, next:NextFunction) => {

    try{
        const user_id = Number(req.params.id)
        if(isNaN(user_id))
        return res.status(400).json({ error: "Invalid user id" });

        const user = await getUserById(user_id)
        res.status(200).json(user)


    }catch(error){
        next(error)
    }

}

const registerUser = async (req:Request, res:Response, next:NextFunction) => {

    try{
        const newUser = await createUser(req.body);
        res.status(201).json(newUser)

    }catch(error){
        next(error)
    }
}

const updateUserbyId = async(req:Request, res:Response, next:NextFunction) => {

    try{

        const user_id = Number(req.params.id);
        if(isNaN(user_id))
        return res.status(400).json({ error: "Invalid user id" });

        const user = await updateUser(user_id,req.body)
        res.status(200).json(user)

    }catch(error){
        next(error)
    }
}

const Logout = async(req:Request, res: Response, next: NextFunction) => {

    try{

        res.clearCookie("access-Token")
        res.status(200).json({message: "User logged out successfully"})

    }catch(error){
        next(error);
    }

}

const getuser = async(req:Request, res: Response) => {
res.status(200).json({user: req.user})
}

export {Login,registerUser,getallUsers,getuserbyId,updateUserbyId,Logout,getuser}