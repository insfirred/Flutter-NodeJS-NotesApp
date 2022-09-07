const express = require('express');
const router = express.Router();

const NoteModel = require('../models/note');

router.post("/list", async function(req,res){
    var notesList = await NoteModel.find({userId: req.body.userId});
    res.json(notesList);
});

router.post("/add", async function(req,res){
    
    await NoteModel.deleteOne({id: req.body.id})

    const newNote = new NoteModel({
        id: req.body.id,
        userId: req.body.userId,
        title: req.body.title,
        content: req.body.content
    });

    await newNote.save();

    res.json({message: 'New Note Added' + `userId ${req.body.id}`})
});

router.post("/delete", async function(req,res){
    await NoteModel.deleteOne({id: req.body.id});

    res.json({message: 'Note Deleted' + `userId ${req.body.id}`})
});

module.exports = router;