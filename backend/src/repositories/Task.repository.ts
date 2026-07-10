import { Prisma } from '../generated/prisma/client';
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

const findPaginated = async (filters:{
    status?:string,
    assignee?:number,
    page:number,
    limit:number}) => {

        const {status,assignee,page,limit} = filters;

        const where: Prisma.tasksWhereInput = {
            ...(status && {status}),
            ...(assignee && {task_assignees:{some:{assignees:assignee}}})
        }

        const[tasks,totalCount] = await Promise.all([

            prisma.tasks.findMany({
                where,
                include:{
                    users:true,
                    task_assignees:{
                     include:{ users:true},
                     },
                 },

                 skip: (page - 1) * limit,
                 take:limit,
                 orderBy:{task_id:"desc"}
            }),

            prisma.tasks.count({where}),
        ]);

        return {tasks, totalCount}


}

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

const create = (data:{ title: string , description: string, created_by: number, assigneeIds?:number[]}) => {

    const {assigneeIds, ...taskData} = data

    return prisma.tasks.create({

        data: {...taskData,
            task_assignees: assigneeIds?.length?
            { 
                create: assigneeIds.map((assignees) => ({assignees}))
                
            } : undefined,
    },

    include: {
      users: true,
      task_assignees: { include: { users: true } },
    },


    });
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
    deleteById,
    findPaginated}