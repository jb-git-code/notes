import express from "express";
import dotenv from "dotenv";
import errorHandler from "./middlewares/errorHandler.js";
import connectDB from "./config/db.js";
import notesRouter from "./routes/notes.routes.js";
import authRoutes from "./routes/auth.routes.js"

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
        <title>Notes Backend</title>
        <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Crect x='15' y='10' width='55' height='80' rx='6' fill='%23fef3c7' stroke='%23334155' stroke-width='4'/%3E%3Cline x1='25' y1='30' x2='60' y2='30' stroke='%2394a3b8' stroke-width='4' stroke-linecap='round'/%3E%3Cline x1='25' y1='45' x2='60' y2='45' stroke='%2394a3b8' stroke-width='4' stroke-linecap='round'/%3E%3Cline x1='25' y1='60' x2='45' y2='60' stroke='%2394a3b8' stroke-width='4' stroke-linecap='round'/%3E%3Cg transform='rotate(45 70 55)'%3E%3Crect x='65' y='15' width='10' height='55' rx='2' fill='%23fbbf24' stroke='%23334155' stroke-width='3'/%3E%3Cpolygon points='65,15 75,15 70,2' fill='%23f8fafc' stroke='%23334155' stroke-width='3' stroke-linejoin='round'/%3E%3Cpolygon points='68,5 72,5 70,-2' fill='%232d3748'/%3E%3C/g%3E%3C/svg%3E">
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
            <h1><span class="status-dot"></span>Notes Backend</h1>
            <p>Server is live and ready to accept requests.</p>
        </div>
    </body>
    </html>
    `);
});

app.use("/notes", notesRouter);

app.use("/auth", authRoutes);

app.use(errorHandler);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on ${PORT}`);
});