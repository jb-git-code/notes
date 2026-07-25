import express from "express";
import dotenv from "dotenv";
import errorHandler from "./middlewares/errorHandler.js";
import connectDB from "./config/db.js";
import notesRouter from "./routes/notes.routes.js";

dotenv.config();

connectDB();

const app = express();

app.use(express.json());

app.get('/' ,(req,res)=>{
    res.status(200).json({message:'Welcome to the server , User notes route'});
});

app.use("/notes", notesRouter);

app.use(errorHandler);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on ${PORT}`);
});