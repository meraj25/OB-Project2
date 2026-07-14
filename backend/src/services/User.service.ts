import { findAllUsers,findUserById,findUsersByName,create,update } from "../repositories/User.repository";
import {createToken,findByHash,revoke,revokeAllForUser} from "../repositories/RefreshToken.repository"
import bcrypt from "bcrypt"
import crypto from "crypto"
import * as jwt from "jsonwebtoken"
import NotFoundError from "../domain/errors/not-found-error";
import ValidationError from "../domain/errors/validation-error";
import UnauthorizedError from "../domain/errors/unauthorized-error";
import { raw } from "express";


const getAllUsers = async () => {

    const users = await findAllUsers();
    return users.map(({ password, ...safeUser}) => safeUser)
};

const getUserById = async (user_id: number) => {

    const user = await findUserById(user_id)

    if(!user){
        throw new ValidationError("Not found!");
    }

    const {password, ...safeUser} = user;
    return safeUser; 
}

const createUser = async (data:{name?: string, password?:string}) => {

    if(!data.password){
        throw new ValidationError("Required credentials");
    }

    const users = await findUsersByName(data.name);

    const nameTaken = users.some(user => user.name === data.name);
    if (nameTaken) {
        throw { status: 409, message: "User name is already taken, try a new one!" };
    }

    const hashedPassword = await bcrypt.hash(data.password, 10);
    const user = await create({ name: data.name, password: hashedPassword });

    const { password, ...safeUser } = user;
    return safeUser;
    
}

const login = async (data:{name:string, password:string}) => {
    if(!data.name || !data.password){
        throw new ValidationError("Require credentials")
    }

    const users = await findUsersByName(data.name)
    if(users.length ===0){
        throw new NotFoundError("Not found error!")
    }

    let matchingUser = null;

    for(const user of users){
        if(!user.password) continue;

        const ismatch = await bcrypt.compare(data.password , user.password)
        if(ismatch){
            matchingUser = user;
            break;
        }
    }

    if (!matchingUser) {
    throw new ValidationError ("Invalid credentials")
    }

    const accessToken = jwt.sign(
        { user_id: matchingUser.user_id, name: matchingUser.name},
        process.env.JWT_SECRET as string)

    const refreshToken = await issueRefreshToken(matchingUser.user_id)

    const {password, ...safeUser} = matchingUser;
    return{user:safeUser,accessToken,refreshToken};


}

const updateUser = async (user_id: number , data: Partial<{name: string , password:string}>) => {

    if(data.password){
        data.password = await bcrypt.hash(data.password,10)
    }

    try{
        const user = await update(user_id,data);
        const { password, ...safeUser} = user;
        return safeUser;

    }catch(error){
        throw new NotFoundError("Not found")
    }

};

const issueRefreshToken = async (user_id:number) => {

    const rawToken = crypto.randomBytes(32).toString('hex');
    const tokenHash = crypto.createHash('sha256').update(rawToken).digest('hex')
    const expiresAt = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);

    await createToken(user_id,tokenHash,expiresAt);
    return rawToken;

}

const rotateRefreshToken = async (rawToken:string) => {

    const tokenHash = crypto.createHash('sha256').update(rawToken).digest('hex')
    const existing = await findByHash(tokenHash);

    if(!existing || existing.revoked || existing.expires_at < new Date()){
        throw new UnauthorizedError('Invalid or expired refresh token');
    }

    await revoke(existing.token_id);
    return issueRefreshToken(existing.user_id);

}



export {getAllUsers,getUserById,login,createUser,updateUser,issueRefreshToken,rotateRefreshToken}  