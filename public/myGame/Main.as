package myGame{	
	import flash.display.Sprite;
	import flash.display.MovieClip;	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.KeyboardEvent;
	
	public class Main extends Sprite{
		import com.shephertz.appwarp.WarpClient;
		import com.shephertz.appwarp.types.ConnectionState;
		import com.shephertz.appwarp.listener.ConnectionRequestListener;		
		
		public function Main() {			
			
			WarpClient.initialize(apiKey,secretKey);
			appwarp = WarpClient.getInstance();
			appwarp.setConnectionRequestListener(new MyListener());
			appwarp.setRoomRequestListener(new MyListener());
			appwarp.setChatRequestListener(new MyListener());
			appwarp.setLobbyRequestListener(new MyListener());
			appwarp.setNotificationListener(new MyListener());
			appwarp.setTurnBasedRoomRequestListener(new MyListener());
			appwarp.setZoneRequestListener(new MyListener());
			appwarp.setUpdateRequestListener(new MyListener());
			
			AddUI();
			//addEventListener(KeyboardEvent.
			
			//appwarp.sendMove(
			//appwarp.createTurnRoom("myroom","abhijet",2,null,60);
			//appwarp.getOnlineUsers();
			
			/*appwarp.setZoneRequestListener(listener);
			appwarp.setRoomRequestListener(listener);
			appwarp.setLobbyRequestListener(listener);*/
		}
		public function movePlayer(e:KeyboardEvent):void
		{
			//swit
		}
		public function AddUI():void
		{
			btn_connect.addEventListener(MouseEvent.CLICK,connect_click);
			myText = new TextField();
			myText.x = 100;
			myText.y = 100;
			myText.text = "hello";
			addChild(myText);
		}
		public function connect_click(e:MouseEvent):void
		{
			appwarp.connect(nam);
			//btn_connect.removeEventListener(MouseEvent.CLICK,connect_click);
			//btn_connect.addEventListener(MouseEvent.CLICK,getInfo);
			//appwarp.createTurnRoom("myroom","abhijet",2,null,60);
			//appwarp.getOnlineUsers();
			//trace('çonnected');
		}
		private function getInfo(e:MouseEvent):void
		{
			if(appwarp.getConnectionState() == ConnectionState.connected)
			{
				appwarp.getAllRooms();
				appwarp.getOnlineUsers();
			}
		}
	}
	
}

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
import flash.text.TextField;
	
var appwarp:WarpClient;
var roomID:String = "1346005659";
var apiKey:String = "7acd21bccfb9aafd84be740c1775039c8bf5b4f622596551cd514d66bafbb5bf"
var secretKey:String = "7a3d20dfeed05eda6a1487d10cf09bbb5846654ceb56c617883d6fd70d16901e";
var nam = "abhijeet" + Math.round(Math.random()*10);
var myText:TextField;

class MyListener implements ConnectionRequestListener,
	TurnBasedRoomListener,ZoneRequestListener,RoomRequestListener
	,LobbyRequestListener,UpdateRequestListener,NotificationListener
	,ChatRequestListener{
		
		public function onConnectDone(res:int):void{
			if(res == ResultCode.success)
			{
				//appwarp.getAllRooms();
				appwarp.joinRoom(roomID);
				//appwarp.createTurnRoom("room1","abhijeet",6,null,60);
				//appwarp.getAllRooms();
				
				//Check if a turn room exists.
								
				//appwarp.createTurnRoom("room",nam,6,null,60);
				//appwarp.getAllRooms();
			}
		}
		public function onDisConnectDone(res:int):void{}
		public function onSendMoveDone(result:int):void{}
		public function onMoveCompleted(move:Move):void{}
	    public function onDeleteRoomDone(event:Room):void{}
	    public function onGetAllRoomsDone(event:LiveResult):void{
			
			trace(event.list);
			
			//event.list
			//appwarp.createTurnRoom("room","admin",6,null,60);
		}
		public function onGetMatchedRoomsDone(event:MatchedRooms):void{}	
	    public function onCreateRoomDone(event:Room):void{}
	    public function onGetOnlineUsersDone(event:LiveResult):void{}
	    public function onGetLiveUserInfoDone(event:LiveUser):void{}
	    public function onSetCustomUserDataDone(event:LiveUser):void{}
		public function onSetCustomUserInfoDone(event:LiveUser):void{}
	    public function onSubscribeRoomDone(event:Room):void{}	  
		public function onUnsubscribeRoomDone(event:Room):void{}	  
		public function onJoinRoomDone(event:Room):void{			
			if(event.result == ResultCode.resource_not_found)
			{
				appwarp.createTurnRoom("room","admin",6,null,60);
			}
			else if(event.result == ResultCode.success)
			{				
				appwarp.getOnlineUsers();
				//appwarp.getLiveRoomInfo(roomID);
				//myText.text = event.name;
			}
		}
		public function onLeaveRoomDone(event:Room):void{}
		public function onGetLiveRoomInfoDone(event:LiveRoom):void
		{
			trace(event.users);
		}
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