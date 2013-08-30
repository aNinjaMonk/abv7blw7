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