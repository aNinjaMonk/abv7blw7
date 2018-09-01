	var k,c,ctx,mySprite,spriteRotation=0;
		
	$(function(){
		/*$("#tabs").tabs();		
		$("#page2").css("display","");
		$("#page3").css("display","none");
		$("#page1").css("display","none");
		
		$("#btn_play").click(function(event){
			$("#page1").css("display","none");
			$("#page2").css("display","");			
		});
		$("#btn_start").click(function(event){			
			$("#page2").css("display","none");
			$("#page3").css("display","");
			//no flash to be used later.
			*/
			var flashvars = {};
			var params = {
				menu: "false",
				scale: "default",
				allowFullscreen: "true",
				allowScriptAccess: "always"
			};
			swfobject.embedSWF("game.swf", "myContent", "100%", "100%", "10.0.0", "expressInstall.swf",flashvars,params);			
		//});
	});
	  
	/*
	var requestAnimFrame = (function(){
		return window.requestAnimationFrame       ||
			window.webkitRequestAnimationFrame ||
			window.mozRequestAnimationFrame    ||
			window.oRequestAnimationFrame      ||
			window.msRequestAnimationFrame     ||
			function(callback){
				window.setTimeout(callback, 1000 / 60);
			};
	})();
	
	setInterval(update,1000);
	
	function init()
	{
	
	}
	function draw()
	{
		
	}
	function update()
	{
		CheckInput();		
	}
	
	
	var lastTime;
	function main()
	{	
		var now = Date.now();
		var dt = (now - lastTime) / 1000.0;
		update(dt);
		render();
		lastTime = now;
		requestAnimFrame(main);
	}
	
	function initGame()
	{
		mySprite = loadSprite('../img/coin.png');
	}
	function updateScene(delta)
	{
		spriteRotation += (Math.PI/180.0) * 45 * delta;
	}
	function renderScene(delta)
	{
		ctx.clearRect(0,0,canvas.width,canvas.height);
		
		drawSprite(mySprite,100,100,0,1);
		drawSprite(mySprite,200,100,0,2);
		drawSprite(mySprite,300,100,spriteRotation,2);
	}
	function loadSprite(img)
	{
		var image = new Image();
		image.src = img;
		return image;
	}
	function drawSprite(img,x,y,rot,scale)
	{
		var w = img.width;
		var h = img.height;
		
		ctx.save();
		ctx.translate(x,y);
		ctx.rotate(rot);
		ctx.scale(scale,scale);
		ctx.drawImage(img,0,0,w,h,-w/2,-h/2,w,h);
		ctx.restore();
	}
	function DrawBoard()
	{
		c = document.getElementById("myCanvas");	
		ctx=c.getContext("2d");
		ctx.fillStyle= "#FFFFFF";
		ctx.fillRect(0,0,600,600);
	}
	function DrawPlayer(x,y)
	{
		ctx.fillStyle= "#000000";
		ctx.fillRect(x,y,10,10);
	}
	function CheckInput()
	{
		k.down('up', function() {
		
		  DrawPlayer(x,y);
		});
		k.down('down', function() {
		  console.log('down arrow key pressed');
		});
		k.down('right', function() {
		  console.log('right arrow key pressed');
		});
		k.down('left', function() {
		  console.log('left arrow key pressed');
		});
	}
	*/
	// Fb Functions
	function LoginStatus(){
		FB.getLoginStatus(function(response) {
		  if (response.status === 'connected') {
			
			// the user is logged in and has authenticated your
			// app, and response.authResponse supplies
			// the user's ID, a valid access token, a signed
			// request, and the time the access token 
			// and signed request each expire
			var uid = response.authResponse.userID;
			var accessToken = response.authResponse.accessToken;
			GetFBInfo();
			
		  } else if (response.status === 'not_authorized') {
			// the user is logged in to Facebook, 
			// but has not authenticated your app
			FB.login(function(response) {
				if (response.authResponse) {
					LoginStatus();
				}
			});
		  } else {
			FB.login(function(response) {
				if (response.authResponse) {
					LoginStatus();
				}
			});
		  }
		});
	}
	function GetFBInfo()
	   {
			FB.api('/me', function(response) {
							$('#player1 .profilepic').html('<img src="http://graph.facebook.com/'+response.id+'/picture">');
							$('#player1 .profilename').html(response.name);
			});
	   }
	   function PublishToWall()
	   {
			FB.ui(
			  {
				method: 'feed',
				name: 'A Dialog',
				link: 'http://www.fundooz.in',
				picture: 'http://placehold.it/300x300',
				caption: 'A cool Testing',
				description: 'Hello this is me testing it out.'
			  },
			  function(response) {
				if (response && response.post_id) {
				  alert('Post was published.');
				} else {
				  alert('Post was not published.');
				}
			  }
			);
	   }
	   function AddFriend()
	   {
			FB.ui({
			  method: 'friends',
			  id: 'ankit.jain'
			}, function(response){
				if(response && response.post_id)					
					alert('friend request sent');
				else
					alert('Dialog cancelled!');
			});
	   }
	   function SendMessage()
	   {
			FB.ui({
			  method: 'send',
			  link: 'www.fundooz.in'
			});
	   }
	   
	   /*var socket = io.connect("http://localhost:3000");
	   socket.on('news',function(data){
			//alert(data.hello);			
			//socket.emit('message',{my:'abhijeet goel'});
	   });*/
	   
	   //chat
	   /*var socket = io.connect('http://localhost:3000');
	   socket.on('connect',function(){
			socket.emit('adduser',prompt("What's your name?"));
	   });
	   socket.on('updatechat',function(username,data){
			$("#conversation").append('<b>'+username + ':</b>' + data + '<br>');
	   });
	   socket.on('updaterooms',function(rooms,current_room){
			$('#rooms').empty();
			$.each(rooms,function(key,value){
				if(value == current_room)
				{
					$('#rooms').append('<div>'+value+'</div>');
				}
				else
				{
					$('#rooms').append('<div><a href="#" onclick="switchRoom(\''+value+'\')">' + value + '</a></div>');
				}
			});
	   });
	   function switchRoom(room){
			socket.emit('switchRoom',room);
	   }   
	   
	   socket.on('updateusers',function(data){
			$('#users').empty();
			$.each(data,function(key,value){
				$('#users').append('<div>' + key + '</div>');
			});
	   });
	   $(function(){
			$('#datasend').click(function(){
				var message = $('#data').val();
				$('#data').val('');
				socket.emit('sendchat',message);
			});
			$('#data').keypress(function(e){
				if(e.which == 13){
					$(this).blur();
					$('#datasend').focus().click();
				}
			});
	   });*/