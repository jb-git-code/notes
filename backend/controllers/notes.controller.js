import Note from "../models/note.model.js";
import mongoose from "mongoose";
import asyncHandler from "../utils/asyncHandler.js";


export const getAllNotes = asyncHandler(async(req ,res)=>{
    const notes = await Note.find();
    res.status(200).json(notes);
});


export const createNote = asyncHandler(async (req , res)=>{
    const { title, content } = req.body;

        if (!title || !content) {
            return res.status(400).json({
                message: "Title and content are required",
            });
        }

        const newNote = await Note.create({

            title,

            content,

        });

        res.status(201).json({

            message: "Note created successfully",

            note: newNote,

        });
});


export const getNoteById = asyncHandler( async (req, res) => {


    const { id } = req.params;


        if (!mongoose.Types.ObjectId.isValid(id)) {

            return res.status(400).json({

                message: "Invalid Note ID",

            });

        }

        const note = await Note.findById(id);

        if (!note) {

            return res.status(404).json({

                message: "Note not found",

            });

        }

        res.status(200).json(note);

});

export const deleteNote = asyncHandler( async (req, res) => {
    const { id } = req.params;

        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({
                message: "Invalid Note ID",
            });
        }

        const deletedNote = await Note.findByIdAndDelete(id);

        if (!deletedNote) {
            return res.status(404).json({
                message: "Note not found",
            });
        }

        return res.status(200).json({
            message: "Note deleted successfully",
        });
});


export const updateNote = asyncHandler ( async(req, res) => {
     const { id } = req.params;
        const { title, content } = req.body;

        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({
                message: "Invalid Note ID",
            });
        }

        const updatedNote = await Note.findByIdAndUpdate(
            id,
            {
                title,
                content,
            },
            {
                new: true,
                runValidators: true,
            }
        );

        if (!updatedNote) {
            return res.status(404).json({
                message: "Note not found",
            });
        }

        return res.status(200).json({
            message: "Note updated successfully",
            note: updatedNote,
        });
});