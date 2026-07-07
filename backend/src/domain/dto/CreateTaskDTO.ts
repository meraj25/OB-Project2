import {z} from "zod"

const CreateTaskDTO = z.object({

    title: z.string().min(1,{message:"Title is required"}).max(75,{message:"Title cannot exceed 75 characters"}),
    description:z.string().min(1,{message:"Description is required"}),
    created_by:z.number().int().positive("cannot be a negative value"),
    status: z.enum(["To Do", "In Progress", "Done"]).optional(),

})

export default CreateTaskDTO;

