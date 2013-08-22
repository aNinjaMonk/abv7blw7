package  {	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.display.Shape;
	import flash.events.MouseEvent;	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.utils.*;
	import flash.text.TextField;
	import flash.text.TextFormat;	
	import flash.events.Event;	
	
	public class Main extends Sprite{
		/*var blockdim:Number = 30;
		var basewidth:Number = 300;
		var baseheight:Number = stage.stageHeight;
		var baseoffsety:Number = 0;
		var baseoffsetx:Number = 100;
		var fieldArray:Array;
		var fieldSprite:Sprite;
		
		var player:Shape;
		var target:Shape;
		var playerLeft:Boolean = true;
		var tetrominoes:Array = new Array();
		var colors:Array=new Array();
		var tetromino:Sprite;
		var currentTetromino:uint;
		var nextTetromino:uint;
		var currentRotation:uint;
		var tRow:Number;
		var tCol:Number;
		var timeCount:Timer=new Timer(500);
		var gameOver:Boolean;
		var timer:Timer;
		var startTime:uint;
		var gameTime:uint = 200;
		var gameover:GameOver;
		var clock:TextField = new TextField();		
		var m_world:b2World;
		var m_iterations:int = 10;
		var m_timeStep:Number = 1.0/30.0;*/
		
		public function Main() {
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			//btnfullScreen.addEventListener(MouseEvent.CLICK,goFullScreen);
			/*stage.addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			PlayerWorld();*/
			//InitGame();
		}
		private function InitGame()
		{
			/*gameOver = false;
			generateField();
			initTetriminoes();
			//nextTetromino=Math.floor(Math.random()*7);
			generateTetromino();
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKDown);
			
			if(stage.contains(clock)){}
			else addChild(clock);
			
			ShowTimer(gameTime);
			
			Player();			
			startTime = getTimer();
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,showClock);
			timer.start();*/
			//PlayerWorld();
		}/*
		private function PlayerWorld():void
		{
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(5,5);
			worldAABB.upperBound.Set(6,6);
			
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			var doSleep:Boolean = true;
			
			m_world = new b2World(worldAABB, gravity, doSleep);
			
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			
			addChild(dbgSprite);
			dbgDraw.m_sprite = dbgSprite;
			dbgDraw.m_drawScale = 30.0;
			dbgDraw.m_fillAlpha = 0.0;
			dbgDraw.m_lineThickness = 1.0;
			dbgDraw.m_drawFlags = 0xFFFFFFFF;
			m_world.SetDebugDraw(dbgDraw);
						
			// Vars used to create bodies
			var body:b2Body;
			var bodyDef:b2BodyDef;
			var boxDef:b2PolygonDef;
			
			// Add ground body
			bodyDef = new b2BodyDef();
			bodyDef.position.Set(10, 12);
			//bodyDef.angle = 0.1;
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(30, 3);
			boxDef.friction = 0.3;
			boxDef.density = 0; // static bodies require zero density
			
			bodyDef.userData = new PhysGround();			
			bodyDef.userData.width = 30 * 2 * 30; 
			bodyDef.userData.height = 30 * 2 * 3; 
			addChild(bodyDef.userData);
			
			body = m_world.CreateBody(bodyDef);
			body.CreateShape(boxDef);
			body.SetMassFromShapes();
			
			bodyDef = new b2BodyDef();
			bodyDef.position.x = Math.random() * 15 + 5;
			bodyDef.position.y = Math.random() * 10;
			
			var rX:Number = Math.random() + 0.5;
			var rY:Number = Math.random() + 0.5;
			
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(rX, rY);
			boxDef.density = 1.0;
			boxDef.friction = 0.5;
			boxDef.restitution = 0.2;
			bodyDef.userData = new PhysBox();
			bodyDef.userData.width = rX * 2 * 30; 
			bodyDef.userData.height = rY * 2 * 30; 
			body = m_world.CreateBody(bodyDef);
			body.CreateShape(boxDef);
			body.SetMassFromShapes();
			
			addChild(bodyDef.userData);
		}
		private function Update(e:Event):void{
			world.Step(m_timeStep, m_iterations);
			
			// Go through body list and update sprite positions/rotations
			for (var bb:b2Body = m_world.m_bodyList; bb; bb = bb.m_next){
				if (bb.m_userData is Sprite){
					bb.m_userData.x = bb.GetPosition().x * 30;
					bb.m_userData.y = bb.GetPosition().y * 30;
					bb.m_userData.rotation = bb.GetAngle() * (180/Math.PI);
				}
			}
		}
		private function ShowTimer(val:uint)
		{
			clock.text = val + " sec";
			clock.x = 710;
			clock.y = 200;
			clock.selectable = false;
			var myFormat:TextFormat = new TextFormat();
			myFormat.color = 0x000000;
			myFormat.size = 24;
			clock.setTextFormat(myFormat);
		}
		private function showClock(e:TimerEvent):void
		{
			var curTime:uint = getTimer();
			if((curTime - startTime)/1000 <= gameTime)
				ShowTimer(Math.ceil((gameTime - (curTime - startTime)/1000)));
			else			
				showGameOver();
		}
		private function showGameOver():void
		{
			ShowTimer(0);
			gameOver = true;				
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,showClock);
			
			gameover = new GameOver();
			addChild(gameover);
			gameover.x = 222;
			gameover.y = 206;
			gameover.getChildByName("btnReplay").addEventListener(MouseEvent.CLICK,Restart);
		}
		private function Restart(e:MouseEvent):void
		{			
			InitGame();
			removeChild(gameover);
		}
		private function goFullScreen(e:MouseEvent):void
		{
			btnfullScreen.removeEventListener(MouseEvent.CLICK,goFullScreen);
			btnfullScreen.addEventListener(MouseEvent.CLICK,goNormalScreen);
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		private function goNormalScreen(e:MouseEvent):void
		{			
			stage.displayState = StageDisplayState.NORMAL;
			btnfullScreen.removeEventListener(MouseEvent.CLICK,goNormalScreen);
			btnfullScreen.addEventListener(MouseEvent.CLICK,goFullScreen);
		}
		
		private function generateField():void {
		  var colors:Array=new Array("0x444444","0x555555");
		  fieldArray = new Array();
		  var fieldSprite:Sprite=new Sprite();
		  addChild(fieldSprite);
		  fieldSprite.graphics.lineStyle(0,0x000000);
		  for (var i:uint=0; i<20; i++) {
			fieldArray[i]=new Array();
			for (var j:uint=0; j<20; j++) {
			  fieldArray[i][j]=0;
			  fieldSprite.graphics.beginFill(colors[(j%2+i%2)%2]);
			  fieldSprite.graphics.drawRect(baseoffsetx + blockdim*j,baseoffsety + blockdim*i,blockdim,blockdim);
			  fieldSprite.graphics.endFill();
			}
		  }
		}
		private function initTetriminoes():void
		{
			// I
			tetrominoes[0]=[[[0,0,0,0],[1,1,1,1],[0,0,0,0],[0,0,0,0]],
		  [[0,1,0,0],[0,1,0,0],[0,1,0,0],[0,1,0,0]]];
		  colors[0]=0x00FFFF;
		  
		  // T
		  tetrominoes[1]=[[[0,0,0,0],[1,1,1,0],[0,1,0,0],[0,0,0,0]],
		   [[0,1,0,0],[1,1,0,0],[0,1,0,0],[0,0,0,0]],
		   [[0,1,0,0],[1,1,1,0],[0,0,0,0],[0,0,0,0]],
		   [[0,1,0,0],[0,1,1,0],[0,1,0,0],[0,0,0,0]]];
		  colors[1]=0xFFFFFF;
		  // L
		  tetrominoes[2]=[[[0,0,0,0],[1,1,1,0],[1,0,0,0],[0,0,0,0]],
		   [[1,1,0,0],[0,1,0,0],[0,1,0,0],[0,0,0,0]],
		   [[0,0,1,0],[1,1,1,0],[0,0,0,0],[0,0,0,0]],
		   [[0,1,0,0],[0,1,0,0],[0,1,1,0],[0,0,0,0]]];
		  colors[2]=0xFFA500;
		  // J
		  tetrominoes[3]=[[[1,0,0,0],[1,1,1,0],[0,0,0,0],[0,0,0,0]],
		   [[0,1,1,0],[0,1,0,0],[0,1,0,0],[0,0,0,0]],
		   [[0,0,0,0],[1,1,1,0],[0,0,1,0],[0,0,0,0]],
		   [[0,1,0,0],[0,1,0,0],[1,1,0,0],[0,0,0,0]]];
		  colors[3]=0x0000FF;
		  // Z
		  tetrominoes[4]=[[[0,0,0,0],[1,1,0,0],[0,1,1,0],[0,0,0,0]],
		   [[0,0,1,0],[0,1,1,0],[0,1,0,0],[0,0,0,0]]];
		  colors[4]=0xFF0000;
		  // S
		  tetrominoes[5]=[[[0,0,0,0],[0,1,1,0],[1,1,0,0],[0,0,0,0]],
		   [[0,1,0,0],[0,1,1,0],[0,0,1,0],[0,0,0,0]]];
		  colors[5]=0x00FF00;
		  // O
		  tetrominoes[6]=[[[0,1,1,0],[0,1,1,0],[0,0,0,0],[0,0,0,0]]];
		  colors[6]=0xFFFF00;
		}
		
		private function onKDown(e:KeyboardEvent):void {
			if (! gameOver) {
			  switch (e.keyCode) {
				case 37 :
				  if (canFit(tRow,tCol-1,currentRotation)) {
					tCol--;
					placeTetromino();
				  }
				  break;	 
				case 38 :
				  var ct:uint=currentRotation;
				  var rot:uint=(ct+1)%tetrominoes[currentTetromino].length;
				  if (canFit(tRow,tCol,rot)) {
					currentRotation=rot;
					removeChild(tetromino);
					drawTetromino();
					placeTetromino();
				  }
				  break;
				case 39 :
				  if (canFit(tRow,tCol+1,currentRotation)) {
					tCol++;
					placeTetromino();
				  }
				  break;
				case 40 :
				  if (canFit(tRow+1,tCol,currentRotation)) {
					tRow++;
					placeTetromino();
				  } else {
					landTetromino();
					generateTetromino();
				  }
				  break;
				case 87:
					
					player.y -= blockdim;
					if(playerLeft)
						player.x -= blockdim;
					else
						player.x += blockdim;
				  break;
				  
				case 65:
					//'left key'			
					/*if(player.x > 0 && player.x < basewidth - blockdim)
					{	}			*//*
					player.x -= blockdim;
					playerLeft = true;
				break;
				case 68:
					//'right key'
					player.x += blockdim;
					playerLeft = false;
				break;
				case 83:
					//('down key');
					player.y += blockdim;
					if(playerLeft)
						player.x -= blockdim;
					else
						player.x += blockdim;
				break;					
			  }
			}
		}
		private function landTetromino():void {
		  var ct:uint=currentTetromino;
		  var landed:Sprite;
		  for (var i:int=0; i<tetrominoes[ct][currentRotation].length; i++) 
			{
			for (var j:int=0; j<tetrominoes[ct][currentRotation][i].length; j++) 
				{
				if (tetrominoes[ct][currentRotation][i][j]==1) {
					landed = new Sprite();
					addChild(landed);
					landed.graphics.lineStyle(0,0x000000);
					landed.graphics.beginFill(colors[currentTetromino]);
					landed.graphics.drawRect(baseoffsetx + blockdim*(tCol+j),baseoffsety + blockdim*(tRow+i),blockdim,blockdim);
					landed.graphics.endFill();
					landed.name="r"+(tRow+i)+"c"+(tCol+j);
					fieldArray[tRow+i][tCol+j]=1;
				}
			}
		  }
		 // removeChild(tetromino);
		  timeCount.removeEventListener(TimerEvent.TIMER, onTime);
		  timeCount.stop();
		  checkForLines();
		}
		private function checkForLines():void {
		  for (var i:int=0; i<20; i++) {
			if (fieldArray[i].indexOf(0)==-1) {
			  for (var j:int=0; j<10; j++) {
				fieldArray[i][j]=0;		
				removeChild(getChildByName("r"+i+"c"+j));
			  }
			  /*
			  for (j=i; j>=0; j--) {
				for (var k:int=0; k<10; k++) {
				  if (fieldArray[j][k]==1) {
					fieldArray[j][k]=0;
					fieldArray[j+1][k]=1;
					getChildByName("r"+j+"c"+k).y+=blockdim;
					getChildByName("r"+j+"c"+k).name="r"+(j+1)+"c"+k;
				  }
				}
			  }*//*
			}
		  }
		}
		private function canFit(row:int,col:int,side:uint):Boolean {
		  var ct:uint=currentTetromino;
		  for (var i:int=0; i<tetrominoes[ct][side].length; i++) 
		{
			for (var j:int=0; j<tetrominoes[ct][side][i].length; 
		j++) {
			  if (tetrominoes[ct][side][i][j]==1) {
				// out of left boundary
				if (col+j<0) {
				  return false;
				}
				// out of right boundary
				if (col+j>19) {
				  return false;
				}
				// out of bottom boundary
				if (row+i>19) {
				  return false;
				}
				// over another tetromino
				if (fieldArray[row+i][col+j]==1) {
				  return false;
				}
			  }
			}
		  }
		  return true;
		}
		private function generateTetromino():void {
		  if (! gameOver) {
			currentTetromino = nextTetromino;
			nextTetromino=Math.floor(Math.random()*7);
			drawNext();
			currentRotation=0;
			tRow=0;
			if (tetrominoes[currentTetromino][0][0].indexOf(1)==-1) {
				tRow =-1;
			}
			tCol=3;
			drawTetromino();
			if (canFit(tRow,tCol,currentRotation)) {
			  timeCount.addEventListener(TimerEvent.TIMER, onTime);
			  timeCount.start();
			} else {			  
			  showGameOver();
			}
		  }
		}
		private function drawNext():void {
		  if (getChildByName("next")!=null) {
			removeChild(getChildByName("next"));
		  }
		  var next_t:Sprite=new Sprite();
		  next_t.x=630;
		  next_t.name="next";
		  addChild(next_t);
		  next_t.graphics.lineStyle(0,0x000000);
		  for (var i:int=0; i<tetrominoes[nextTetromino][0].length; i++) {
			for (var j:int=0; j<tetrominoes[nextTetromino][0][i].length; j++) 
		{
			  if (tetrominoes[nextTetromino][0][i][j]==1) {
				next_t.graphics.beginFill(colors[nextTetromino]);
				next_t.graphics.drawRect(baseoffsetx + blockdim*j,baseoffsety + blockdim*i,blockdim,blockdim);
				next_t.graphics.endFill();
			  }
			}
		  }
		}
		private function onTime(e:TimerEvent):void {
		  if (canFit(tRow+1,tCol,currentRotation)) {
			tRow++;
			placeTetromino();
		  } else {
			landTetromino();
			generateTetromino();
		  }
		}
		private function drawTetromino():void {
		  var ct:uint=currentTetromino;
		  tetromino=new Sprite();
		  addChild(tetromino);
		  tetromino.graphics.lineStyle(0,0x000000);
		  for (var i:int=0; i<tetrominoes[ct][currentRotation].length; i++) 
		{
			for (var j:int=0; j<tetrominoes[ct][currentRotation][i].length; 
		j++) {
			  if (tetrominoes[ct][currentRotation][i][j]==1) {
				tetromino.graphics.beginFill(colors[ct]);
				tetromino.graphics.drawRect(blockdim*j,blockdim*i,blockdim,blockdim);
				tetromino.graphics.endFill();
			  }
			}
		  }
		  placeTetromino();
		}
		private function placeTetromino():void {
		  tetromino.x=baseoffsetx + tCol*blockdim;
		  tetromino.y=tRow*blockdim;
		}		
		private function Player():void
		{
			player = new Shape();
			player.graphics.beginFill(0xFF0000);
			player.graphics.drawRect(baseoffsetx + 5*blockdim,baseheight - blockdim,blockdim,blockdim);
			player.graphics.endFill();
			addChild(player);
		}
		private function Target():void
		{
			target = new Shape();
			target.graphics.beginFill(0x00FF00);
			target.graphics.drawRect(baseoffsetx + blockdim,blockdim,blockdim,blockdim);
			target.graphics.endFill();
			addChild(target);
		}
	}	*/
}
}