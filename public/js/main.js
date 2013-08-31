	function LoginStatus(){
		FB.getLoginStatus(function(response) {
		  if (response.status === 'connected') {
			var flashvars = {};
			var params = {
				menu: "false",
				scale: "default",
				allowFullscreen: "true",
				allowScriptAccess: "always"
			};
			swfobject.embedSWF("game.swf", "myContent", "100%", "600", "10.0.0", "expressInstall.swf",flashvars,params);
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
			  id: 'pankaj.karajagi'
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
	   document.domain = "facebook.com";
	   var socket = io.connect('http://localhost:3000');
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
	   });