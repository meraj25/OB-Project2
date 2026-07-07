import { findAllUsers,findUserById,findUserByName,create,update } from "../repositories/User.repository";
import bcrypt from "bcrypt"
import * as jwt from "jsonwebtoken"

const getAllUsers = async () => {

    const users = await findAllUsers();
    return users.map(({ password, ...safeUser}) => safeUser)
};

const getUserById = async (user_id: number) => {

    const user = await findUserById(user_id)

    if(!user){
        throw{ status:404 , message: " User not found!"}
    }

    const {password, ...safeUser} = user;
    return safeUser; 
}

const createUser = async (data:{name?: string, password?:string}) => {

    if(!data.password){
        throw{ status:404 , message: " Password is required!"};
    }

    const hashedPassword = await bcrypt.hash(data.password, 10);
    const user = await create({name:data.name, password:hashedPassword})

    const {password, ...safeUser} = user;
    return safeUser; 
    
}

const login = async (data:{name:string, password:string}) => {
    if(!data.name || !data.password){
        throw { status: 400, message: "Name and password are required" };
    }

    const user = await findUserByName(data.name)
    if(!user || !user.password){
        throw { status: 401, message: "Invalid credentials" };
    }
    const isMatch = await bcrypt.compare(data.password , user.password)
    if (!isMatch) {
    throw { status: 401, message: "Invalid credentials" };
    }
   
    const accessToken = jwt.sign({user_id:user.user_id, name:user.name}, process.env.JWT_SECRET as string);
    

    const {password, ...safeUser} = user;
    return {user:safeUser, accessToken };

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
        throw {status: 404, message:"User not found!"}
    }

};



export {getAllUsers,getUserById,login,createUser,updateUser}  