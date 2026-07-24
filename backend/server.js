import express from "express";

const app = express();

app.use(express.json());

const PORT = 3000;


app.get("/", (req, res) => {
    res.send("Notes Backend is Running 🚀");
});

app.get("/about", (req, res) => {

    res.send("This is my Notes API.");

});

app.get("/contact", (req, res) => {

    res.send("Contact API");

});


app.post("/notes", (req, res) => {

    console.log(req.body);

    res.json({
       

    "message": "Note Created Successfully",

    "note": {

        "title": "Shopping",

        "content": "Buy Milk"

        }
    });

});


app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});