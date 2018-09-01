var async   = require('async');
var express = require('express');
var util    = require('util');
var fs      = require('fs');
var ejs 	= require('ejs');
ejs.open = '<%';
ejs.close = '%>';

// create an express webserver
var app = express.createServer(
  express.logger(),
  express.static(__dirname + '/public'),
  express.bodyParser(),
  express.cookieParser(),
  express.session({ secret: process.env.SESSION_SECRET || 'secret123' })
);

app.configure(function(){
	app.set('title','Above 7 Below 7');
});

/*
var io = require('socket.io').listen(app);
io.sockets.on("connection",function(socket){
	//socket.emit('news',{hello:'world'});
	socket.on('message',function(data){
		console.log(data.my);
	});
});
*/
//var rooms = {};

/*
//Chat Module

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
*/
/*
fs.stat('public/abhi1.txt',function(err,stats){
	console.log("stats:" + JSON.stringify(stats));
});
*/

// listen to the PORT given to us in the environment
var port = process.env.PORT || 3000;

app.listen(port, function() {
  console.log("Listening on " + port);
});

function Output(req,res)
{
	fs.readFile('public/abhi.txt',function(err,data){
		if(err) throw err;
		var title = "Above 7 Below 7";
		var coin = 1000;
		res.render('index.ejs',{
			layout:    false,
			req:       req,
			app:       app,
			title:     title,
			myData:    data,
			coins: 	   coin
		});
	});
	
	
}
app.get('/',Output );
app.post('/', Output);

app.post('/server',function(req,res){
	res.send('server says hi!!');
});
app.get('/howtoplay',function(req,res){
	res.send('This contains information about how to play!!');
});
app.get('/leaderboard',function(req,res){
	res.send('leaderboard');
});
app.get('/shop',function(req,res){
	res.send('shop');
});
/*
app.use(function(err,req,res,next){
	console.log(err.stack);
	res.send(500,'Something broke');
});*/