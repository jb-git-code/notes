export const getAllNotes = (req, res) => {
    res.json([
        {
            id: 1,
            title: "Shopping",
            content: "Buy Milk"
        },
        {
            id: 2,
            title: "Flutter",
            content: "Learn Express"
        }
    ]);
};

export const getNoteById = (req, res) => {
    res.json({
        id: req.params.id,
        message: "Single Note"
    });
};

export const createNote = (req, res) => {
    res.status(201).json({
        message: "Note Created Successfully",
        note: req.body
    });
};

export const deleteNote = (req, res) => {
    res.json({
        message: `Deleted note ${req.params.id}`
    });
};


export const updateNote = (req, res) => {
    res.json({
        message: `Updated note ${req.params.id}`
    });
};