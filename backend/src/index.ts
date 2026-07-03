import express from 'express';
import {} from './db/prisma'


const app = express();
app.use(express.json());
app.use(express.urlencoded({
    extended:true
}))

const PORT = 8000;

app.listen(PORT, () => {
    console.log(`server is running on ${PORT}`);
})
