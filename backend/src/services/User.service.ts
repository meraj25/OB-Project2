import { findAllUsers,findUserById,findUsersByName,create,update } from "../repositories/User.repository";
import bcrypt from "bcrypt"
import * as jwt from "jsonwebtoken"
import NotFoundError from "../domain/errors/not-found-error";
import ValidationError from "../domain/errors/validation-error";


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

    let valid_name = null;
    
    for(const user of users){
        if(!user.name) continue

        if(user.name == data.name){
            throw{ status: 409 , message: " User name is already taken, try a new one!"};
        }else{

            valid_name = data.name;
            break;
        }
         
    }
    const hashedPassword = await bcrypt.hash(data.password, 10);
    const user = await create({name:valid_name, password:hashedPassword})

    const {password, ...safeUser} = user;
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

    const {password, ...safeUser} = matchingUser;
    return{user:safeUser,accessToken}


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



export {getAllUsers,getUserById,login,createUser,updateUser}  