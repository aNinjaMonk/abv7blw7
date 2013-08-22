	
	var flashvars = {};
    var params = {
            menu: "false",
            scale: "default",
            allowFullscreen: "true",
            allowScriptAccess: "always"
         };
	swfobject.embedSWF("game.swf", "myContent", "100%", "600", "10.0.0", "expressInstall.swf",flashvars,params);
	/*
	$("#login").click(function(event){		
		GetFBInfo();
	});
	*/
	