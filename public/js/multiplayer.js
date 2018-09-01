
	  WarpClient.initialize("6cc2b31bcfd29859415eb9ea3d3f912a05d314b498a91c4f925e098643f12c08", "4e3c9a999f56fab4eaa90e02ff27909db85796dd40b7910db6efd0af42535d5a");
	  WarpClient.addConnectionRequestListener(new MyConnectionRequestListener());
      WarpClient.addLobbyRequestListener(new MyLobbyRequestListener());
      //WarpClient.addZoneRequestListener(new MyZoneRequestListener());
      /* WarpClient.addRoomRequestListener(new MyRoomRequestListener());
      WarpClient.addChatRequestListener(new MyChatRequestListener());
      WarpClient.addUpdateRequestListener(new MyUpdateRequestListener());
      WarpClient.addNotificationListener(new MyNotificationListener());
	*/
	  WarpClient.connect();
	  //WarpClient.joinZone("abhijeet");
	  /*WarpClient.joinRoom(1);
	  WarpClient.subscribeRoom(1);
	  //alert(WarpClient.getOnlineUsers());
	  
	  var msg = {
		action: 'move',
		pos_x: 120,
		pos_y: 120
	  };
	  //WarpClient.sendChat(JSON.stringify(msg));
	  */
      function MyConnectionRequestListener() {
              this.onConnectDone = function(result){
					alert('Yo!! ho!!');
              };
	
              this.onDisconnectDone = function(result){
              };
      }

      function MyLobbyRequestListener(){
              this.onJoinLobbyDone = function(event){
				
              }
              this.onLeaveLobbyDone = function(event){					
              };
              this.onSubscribeLobbyDone = function(event){
              };
              this.onUnsubscribeLobbyDone = function(event){
              };
              this.onGetLiveLobbyInfoDone = function(event){
              };
      }
/*
      function MyZoneRequestListener() {
              this.onCreateRoomDone = function(event){
					alert('çreated a room');
              };
              this.onDeleteRoomDone = function(event){
              };
              this.onGetAllRoomsDone = function(event){
              };
              this.onGetOnlineUsersDone = function(event){
              };
              this.onGetLiveUserInfoDone = function(event){
              };
              this.onSetCustomUserInfoDone = function(event){
              };	
      }

      function MyRoomRequestListener() {
              this.onSubscribeRoomDone = function(event){
              };
              this.onUnsubscribeRoomDone = function(event){
              };
              this.onJoinRoomDone = function(event){
              };
              this.onLeaveRoomDone = function(event){
              };
              this.onGetLiveRoomInfoDone = function(event){	
              };
              this.onSetCustomRoomDataDone = function(event){
              };	
      }

      function MyChatRequestListener() {
              this.onSendChatDone = function(result){
              };	
      }

      function MyUpdateRequestListener() {
              this.onSendUpdateDone = function(result){
              };
      }

      function MyNotificationListener() {
              this.onRoomCreated = function(roomdata){
              };
              this.onRoomDestroyed = function(roomdata){
              };
              this.onUserLeftRoom = function(roomdata, user){
              };
              this.onUserJoinedRoom = function(roomdata, user){
              };
              this.onUserLeftLobby = function(lobbydata, user){
              };
              this.onUserJoinedLobby = function(lobbydata, user){
              };
              this.onChatReceived = function(chatevent){
              };
              this.onUpdatePeersReceived = function(updateevent){
              };	
      }
	  */