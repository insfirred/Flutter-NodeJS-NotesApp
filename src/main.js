const express = require('express');
const app = express();
const mongoose = require('mongoose');
const NoteModel = require('./models/note');
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

const mongoDbPath = 'mongodb+srv://Kalash:8755811850@cluster0.sx3iyvi.mongodb.net/?retryWrites=true&w=majority';
mongoose.connect(mongoDbPath).then(function(){

    app.get("/", function(req,res){
        res.json({message: "HomePage"})
    });

    app.get("/notes/list/:userId",async function(req,res){
        var notes = await NoteModel.find({userId: req.params.userId});
        res.json(notes);
    })

    var router = require('./routes/postRoutes');
    app.use("/notes/", router)
});

const PORT = process.env.PORT || 5000
app.listen(PORT, function(){
    console.log('Server started @ ' + PORT);
});