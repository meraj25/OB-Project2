import { prisma } from '../db/prisma'

const findAllTasks = () => {
    return prisma.tasks.findMany({
        include:{
            users:true,
            task_assignees:{
                include:{ users:true},
            },
        },
    });

};

const findById = (task_id:number) =>{
    return prisma.tasks.findUnique({
        where: { task_id },
        include:{
            users:true,
            task_assignees: { include:{users: true}}
        }
    })
};

const findByAssignee = (assigneeId:number) => {
    return prisma.tasks.findMany({
        where: {
            task_assignees: {
                some:{assignees:assigneeId},
            },
        },

        include: {
            users:true,
            task_assignees: { include: {users: true}},
        },
    });

};

const findByStatus = (status: string) => {
    return prisma.tasks.findMany({
        where:{status},
        include:{
            users:true,
            task_assignees: {include: {users:true}},
        },
    });

};

const findByCreator = (creatorId: number) => {
    return prisma.tasks.findMany({
        where: {created_by:creatorId},
        include:{
            users:true,
            task_assignees:{include:{users:true}}
        },


    });
};

const create = (data:{ title: string , description: string, created_by: number}) => {
    return prisma.tasks.create({data});
};

const updateById = (task_id: number, data: Partial<{ title: string; description: string; status: string}>) => {
  return prisma.tasks.update({
    where: { task_id },
    data,
  });
};

const deleteById = (task_id: number) => {
  return prisma.tasks.delete({
    where: { task_id },
  });
};

export {
    findAllTasks,
    findById,
    findByAssignee,
    findByStatus,
    create,
    findByCreator,
    updateById,
    deleteById}