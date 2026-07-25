import express from "express";
import dotenv from "dotenv";
import errorHandler from "./middlewares/errorHandler.js";
import connectDB from "./config/db.js";
import notesRouter from "./routes/notes.routes.js";

dotenv.config();

connectDB();

const app = express();

app.use(express.json());

app.get('/', (req, res) => {
    res.status(200).send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Backend Status</title>
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: linear-gradient(135deg, #0f172a, #1e293b);
                color: #f1f5f9;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .card {
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 16px;
                padding: 40px 50px;
                text-align: center;
                backdrop-filter: blur(10px);
                box-shadow: 0 8px 32px rgba(0,0,0,0.4);
            }
            .status-dot {
                width: 12px;
                height: 12px;
                background: #22c55e;
                border-radius: 50%;
                display: inline-block;
                margin-right: 8px;
                box-shadow: 0 0 10px #22c55e;
                animation: pulse 1.5s infinite;
            }
            @keyframes pulse {
                0% { opacity: 1; }
                50% { opacity: 0.4; }
                100% { opacity: 1; }
            }
            h1 {
                font-size: 1.8rem;
                margin-bottom: 10px;
            }
            p {
                color: #94a3b8;
                font-size: 0.95rem;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <h1><span class="status-dot"></span>Backend is running</h1>
            <p>Server is live and ready to accept requests.</p>
        </div>
    </body>
    </html>
    `);
});

app.use("/notes", notesRouter);

app.use(errorHandler);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on ${PORT}`);
});