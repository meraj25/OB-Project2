import {prisma} from '../db/prisma'

const findAllUsers = () => {
    return prisma.users.findMany();
};

const findUserById = (user_id: number) => {
    return prisma.users.findUnique({
        where: {user_id}
    })
};

const createUser = (data: {name?: string; password?: string}) => {
    return prisma.users.create({data})
};

const updateUserById = (user_id: number , data:Partial<{name: string; password: string}>) => {
    return prisma.users.update({where: {user_id},data})

};

const deleteUserById = (user_id: number) => {
    return prisma.users.delete({
        where: {user_id}
    })

};

export {
    findAllUsers,
    findUserById,
    createUser,
    updateUserById,
    deleteUserById
};


