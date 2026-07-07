import {prisma} from '../db/prisma'

const findAllUsers = () => {
    return prisma.users.findMany();
};

const findUserById = (user_id: number) => {
    return prisma.users.findUnique({
        where: {user_id}
    })
};

const findUserByName = (name:string) => {

    return prisma.users.findFirst({where: {name}})
};

const create = (data: {name?: string; password?: string}) => {
    return prisma.users.create({data})
};

const update = (user_id: number , data:Partial<{name: string; password: string}>) => {
    return prisma.users.update({where: {user_id},data})

};



export {
    findAllUsers,
    findUserById,
    findUserByName,
    create,
    update,
    
};


