import { getAllUsers,getUserById,login,createUser,updateUser,rotateRefreshToken } from "../services/User.service";
import { revokeAllForUser } from "../repositories/RefreshToken.repository";
import {Request,Response,NextFunction} from "express";
import ValidationError from "../domain/errors/validation-error";
import UnauthorizedError from "../domain/errors/unauthorized-error";
import { findUserById } from "../repositories/User.repository";
import bcrypt from "bcrypt"
import crypto from "crypto"
import * as jwt from "jsonwebtoken"

const Login = async (req:Request,res:Response,next:NextFunction) => {
    try{

        const {user , accessToken, refreshToken } = await login(req.body)

        res.cookie("access-Token", accessToken,{
            maxAge: 24 * 60 * 60 * 1000, 
            httpOnly: true,
            sameSite: "lax",
        });

        res.cookie("refresh-Token", refreshToken,{
            maxAge: 7 * 24 * 60 * 60 * 1000, 
            httpOnly: true,
            sameSite: "lax",
        });

        res.status(200).json(user)


    }catch(error){
        next(error)

    }
}

const Refresh = async (req:Request, res:Response, next:NextFunction) => {

   

    try{

        const oldRefreshToken = req.cookies["refresh-Token"];
        if(!oldRefreshToken){
            throw new UnauthorizedError("No refresh token provided");
        }

        const {newRefreshToken, user_id} = await rotateRefreshToken(oldRefreshToken)

        const user = await findUserById(user_id);

        console.log("user",user);

        const accessToken = jwt.sign(
                { user_id: user.user_id, name: user.name},
                process.env.JWT_SECRET as string,
                { expiresIn: "10m"}
            );

        res.cookie("access-Token", accessToken, {
            maxAge: 2 * 60 * 1000,
            httpOnly: true,
            sameSite: "lax",
        });

        res.cookie("refresh-Token", newRefreshToken,{
            maxAge: 7 * 24 * 60 * 60 * 1000,
            httpOnly: true,
            sameSite: "lax",
        });
        res.status(200).json({message: "Token refreshed successfully"})

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

        return new ValidationError("please enter a valid input ")


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
        return new ValidationError("please enter a valid input")

        const user = await updateUser(user_id,req.body)
        res.status(200).json(user)

    }catch(error){
        next(error)
    }
}

const Logout = async(req:Request, res: Response, next: NextFunction) => {

    try{

         const user_id = req.user?.user_id;

        if (user_id) {
            await revokeAllForUser(user_id);
        }

        res.clearCookie("access-Token")
        res.clearCookie("refresh-Token")
        res.status(200).json({message: "User logged out successfully"})

    }catch(error){
        next(error);
    }

}

const getuser = async(req:Request, res: Response) => {
res.status(200).json({user: req.user})
}

export {Login,registerUser,getallUsers,getuserbyId,updateUserbyId,Logout,getuser,Refresh}