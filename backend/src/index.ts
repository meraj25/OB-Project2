import express from 'express';
import cors from "cors"
import {} from './db/prisma'
import UserRouter from './routes/User.route';
import TaskRouter from './routes/Task.route';
import cookieParser from 'cookie-parser';
import globalErrorHandlingMiddleware from './middleware/global-error-handling-middleware';

const app = express();

app.use(cors({origin:"http://localhost:5173",  credentials: true}));

app.use(express.json());
app.use(express.urlencoded({
    extended:true
}))

app.use(cookieParser());

app.use('/api/users', UserRouter)
app.use('/api/tasks',TaskRouter)

app.use(globalErrorHandlingMiddleware);

const PORT = 8000;

app.listen(PORT, () => {
    console.log(`server is running on ${PORT}`);
})

export default app;