import jwt from "jsonwebtoken";
import asyncHandler from "../utils/asyncHandler.js";
import User from "../models/user.model.js";
import { getAllNotes } from "../controllers/notes.controller.js";

export const protect = asyncHandler(async (req, res, next) => {
    const authHeader = req.headers.authorization;
    console.log(authHeader);

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return res.status(401).json({
            success: false,
            message: "Not authorized. No token provided.",
        });
    }

    return res.status(200).json({
        success:true,
        message:'Auth Middleware established',
        data:{}
    });

});