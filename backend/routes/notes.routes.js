import express from "express";

import {
    getAllNotes,
    getNoteById,
    createNote,
    deleteNote,
    updateNote
} from "../controllers/notes.controller.js";
import { protect } from "../middlewares/auth.middleware.js";

const router = express.Router();

router.use(protect);

router.get("/",getAllNotes);

router.get("/:id", getNoteById);

router.post("/", createNote);

router.delete("/:id", deleteNote);

router.put("/:id", updateNote);

export default router;