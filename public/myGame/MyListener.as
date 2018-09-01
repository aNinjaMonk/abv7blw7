package  myGame{
	import com.shephertz.appwarp.WarpClient;
	import com.shephertz.appwarp.listener.ConnectionRequestListener;	
	import com.shephertz.appwarp.listener.LobbyRequestListener;
	import com.shephertz.appwarp.listener.RoomRequestListener;
	import com.shephertz.appwarp.types.ResultCode;
	import com.shephertz.appwarp.listener.ZoneRequestListener;
	import com.shephertz.appwarp.messages.Room;
	import com.shephertz.appwarp.messages.LiveRoom;
	import com.shephertz.appwarp.messages.LiveResult;
	import com.shephertz.appwarp.messages.LiveUser;
	import com.shephertz.appwarp.messages.MatchedRooms;
	import com.shephertz.appwarp.messages.Lobby;
	import com.shephertz.appwarp.messages.LiveLobby;
	import com.shephertz.appwarp.listener.TurnBasedRoomListener;
	import flash.display.MovieClip;
	import com.shephertz.appwarp.listener.UpdateRequestListener;
	import com.shephertz.appwarp.listener.NotificationListener;
	import com.shephertz.appwarp.listener.ChatRequestListener;
	import com.shephertz.appwarp.messages.Chat;
	import flash.utils.ByteArray;
	import com.shephertz.appwarp.messages.Move;
	
	public class MyListener implements ConnectionRequestListener,
	TurnBasedRoomListener,ZoneRequestListener,RoomRequestListener
	,LobbyRequestListener,UpdateRequestListener,NotificationListener
	,ChatRequestListener{
		
		public function onConnectDone(res:int):void{}
		public function onDisConnectDone(res:int):void{}
		public function onSendMoveDone(result:int):void{}
		public function onMoveCompleted(move:Move):void{}
	    public function onDeleteRoomDone(event:Room):void{}
	    public function onGetAllRoomsDone(event:LiveResult):void{}
		public function onGetMatchedRoomsDone(event:MatchedRooms):void{}	
	    public function onCreateRoomDone(event:Room):void{}
	    public function onGetOnlineUsersDone(event:LiveResult):void{}
	    public function onGetLiveUserInfoDone(event:LiveUser):void{}
	    public function onSetCustomUserDataDone(event:LiveUser):void{}
		public function onSetCustomUserInfoDone(event:LiveUser):void{}
	    public function onSubscribeRoomDone(event:Room):void{}	  
		public function onUnsubscribeRoomDone(event:Room):void{}	  
		public function onJoinRoomDone(event:Room):void{}
		public function onLeaveRoomDone(event:Room):void{}
		public function onGetLiveRoomInfoDone(event:LiveRoom):void{}
		public function onSetCustomRoomDataDone(event:LiveRoom):void{}
		public function onUpdatePropertiesDone(event:LiveRoom):void{}
		public function onLockPropertiesDone(result:int):void{}
		public function onUnlockPropertiesDone(result:int):void{}
		public function onRoomCreated(event:Room):void{}
		public function onRoomDestroyed(event:Room):void{}
		public function onUserLeftRoom(event:Room,username:String):void{}
		public function onUserJoinedRoom(event:Room,username:String):void{}
		public function onUserLeftLobby(event:Lobby,username:String):void{}
		public function onUserJoinedLobby(event:Lobby,username:String):void{}
		public function onChatReceived(event:Chat):void{}
		public function onSendChatDone(result:int):void{}
		public function onSendPrivateChatDone(result:int):void{}
		public function onPrivateChatReceived(sender:String, chat:String):void{}
		public function onUpdatePeersReceived(update:ByteArray):void{}
		public function onUserChangeRoomProperties(room:Room, user:String,properties:Object, lockTable:Object):void{}
		public function onSendUpdateDone(result:int):void{}
		public function onJoinLobbyDone(event:Lobby):void{}
		public function onLeaveLobbyDone(event:Lobby):void{}
		public function onSubscribeLobbyDone(event:Lobby):void{}
		public function onUnsubscribeLobbyDone(event:Lobby):void{}
		public function onGetLiveLobbyInfoDone(event:LiveLobby):void{}
	}
}
