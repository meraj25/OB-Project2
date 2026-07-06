import express from 'express';
import {} from './db/prisma'
import UserRouter from './routes/User.route';
import cookieParser from 'cookie-parser';


const app = express();
app.use(express.json());
app.use(express.urlencoded({
    extended:true
}))

app.use(cookieParser());

app.use('/api/users', UserRouter)

const PORT = 5000;

app.listen(PORT, () => {
    console.log(`server is running on ${PORT}`);
})
