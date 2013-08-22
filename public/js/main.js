
	
	/*FB.login(function(response) {
		if (response.authResponse) {				
			
		}
	});
	/*
	$("#login").click(function(event){		
		GetFBInfo();
	});
	*/	
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
			FB.login(function(response) {
				if (response.authResponse) {
					FB.api('/me', function(response) {
							$('#player1 .profilepic').html('<img src="http://graph.facebook.com/'+response.id+'/picture">');
							$('#player1 .profilename').html(response.name);
						});
					FB.api('/me?fields=friends', function(response) {
							alert(response.friends.data[0].id);
						});
				}
				else
				{
					alert('user cancelled login');
				}
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
			  link: 'www.fundooz.in',
			});
	   }		   