import Note from "../models/note.model.js";
import mongoose from "mongoose";

export const getAllNotes = async (req, res) => {
    try {

        const notes = await Note.find();

        res.status(200).json(notes);

    } catch (error) {

        res.status(500).json({
            message: error.message
        });

    }
};

export const createNote = async (req, res) => {

    try {

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

    } catch (error) {

        res.status(500).json({

            message: error.message,

        });

    }

};

export const getNoteById = async (req, res) => {


    try {

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

    } catch (error) {

        res.status(500).json({

            message: error.message,

        });

    }

};

export const deleteNote = async (req, res) => {
    try {

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

    } catch (error) {
        return res.status(500).json({
            message: error.message,
        });
    }
};


export const updateNote = async (req, res) => {
    try {

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

    } catch (error) {
        return res.status(500).json({
            message: error.message,
        });
    }
};