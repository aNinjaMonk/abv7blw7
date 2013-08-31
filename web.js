var async   = require('async');
var express = require('express');
var util    = require('util');

// create an express webserver
var app = express.createServer(
  express.logger(),
  express.static(__dirname + '/public'),
  express.bodyParser(),
  express.cookieParser(),  
  express.session({ secret: process.env.SESSION_SECRET || 'secret123' })
  
);

//Chat Module
var io = require('socket.io').listen(app);

var usernames = {};
var rooms = ['room1','room2','room3'];
io.sockets.on('connection',function(socket){
	socket.on('sendchat',function(data){
		io.sockets.in(socket.room).emit('updatechat',socket.username,data);
	});
	socket.on('adduser',function(username){
		socket.username = username;
		socket.room = 'room1';
		usernames[username] = username;
		socket.join('room1');
		socket.emit('updatechat','SERVER','you have connected to room1');
		socket.broadcast.to('room1').emit('updatechat','SERVER',username + 'has connected to this room');
		socket.emit('updaterooms',rooms,'room1');
	});
	socket.on('switchRoom',function(newroom){
		socket.leave(socket.room);
		socket.join(newroom);
		socket.emit('updatechat','SERVER','you have connected to ' + newroom);
		socket.broadcast.to(socket.room).emit('updatechat','SERVER',socket.username + 'has left the room');
		socket.room = newroom;
		socket.broadcast.to(newroom).emit('updatechat','SERVER',socket.username + 'has joined the room');
		socket.emit('updaterooms',rooms,newroom);
	});
	socket.on('disconnect',function(){
		delete usernames[socket.username];
		io.sockets.emit('updateusers',usernames);
		socket.broadcast.emit('updatechat','SERVER',socket.username + 'has disconnected');
		socket.leave(socket.room);
	});
});


// listen to the PORT given to us in the environment
var port = process.env.PORT || 3000;

app.listen(port, function() {
  console.log("Listening on " + port);
});
function Output(req,res)
{
	res.render('index.ejs', {
        layout:    false,
        req:       req,
        app:       app
      });
}
app.get('/',Output );
app.post('/', Output);