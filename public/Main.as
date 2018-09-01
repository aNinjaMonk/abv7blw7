package  {
	import Box2D.Collision.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Common.*;
	import Box2D.Collision.Shapes.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	public class Main extends Sprite{
		private var m_world:b2World;
		private var m_iterations:int = 10;
		private var m_timeStep:Number = 1.0/30.0;
		var body:b2Body;
		var bodyDef:b2BodyDef;
		var boxDef:b2PolygonDef;
		var circleDef:b2CircleDef;
		var gamegrid:Array = new Array( new Array(0,0,0,0,0,0),
										new Array(0,0,0,0,0,0),
										new Array(0,0,0,0,0,0),
										new Array(0,0,0,0,0,0),
										new Array(0,0,0,0,0,0),
										new Array(0,0,0,0,0,0)
									  );
						
		public function Main() {
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			//stage.align = StageAlign.TOP_LEFT;
			//btnfullScreen.addEventListener(MouseEvent.CLICK,goFullScreen);
			trace(gamegrid[0][0]);
			stage.addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			SetPhysicsWorld();
			stage.addEventListener(MouseEvent.CLICK,releaseCoin);
			stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,newCoin);
		}
		private function newCoin(e:MouseEvent):void
		{
			bodyDef = new b2BodyDef();
			bodyDef.position.x = Math.max(1.5,Math.min(18.5,this.mouseX/31.5));
			bodyDef.position.y = 1;
			var rX:Number = 1.51;
			//var rY:Number = Math.random() + 0.5;
			circleDef = new b2CircleDef();
			circleDef.radius = rX;
			circleDef.density = 1.0;
			circleDef.friction = 0.5;
			circleDef.restitution = 0.55;
			bodyDef.userData = new Coin1();
			bodyDef.userData.width = rX * 2 * 30; 
			bodyDef.userData.height = rX * 2 * 30; 
			body = m_world.CreateBody(bodyDef);
			body.CreateShape(circleDef);					
			addChild(bodyDef.userData);
			setChildIndex(bodyDef.userData,0);
		}
		private function releaseCoin(e:MouseEvent):void
		{
			body.SetMassFromShapes();
		}
		private function SetPhysicsWorld()
		{
			stage.addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			
			// Create world AABB
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-100.0, -100.0);
			worldAABB.upperBound.Set(100.0, 100.0);
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			m_world = new b2World(worldAABB, gravity, doSleep);
			
			// set debug draw
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			addChild(dbgSprite);
			dbgDraw.m_sprite = dbgSprite;
			dbgDraw.m_drawScale = 30.0;
			dbgDraw.m_fillAlpha = 0.0;
			dbgDraw.m_lineThickness = 1.0;
			dbgDraw.m_drawFlags = 0xFFFFFFFF;
			//m_world.SetDebugDraw(dbgDraw);			
			
			// Add ground body
			bodyDef = new b2BodyDef();			
			bodyDef.position.Set(10, 20);
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(10, 0.05);
			boxDef.friction = 0.1;
			boxDef.density = 0; // static bodies require zero density			
			// Add sprite to body userData
			bodyDef.userData = new PhysGround();
			bodyDef.userData.width = stage.width;
			bodyDef.userData.height = 1; 
			addChild(bodyDef.userData);
			body = m_world.CreateBody(bodyDef);
			body.CreateShape(boxDef);
			body.SetMassFromShapes();
			var x = [0.17,0.28+3.22,0.28+3.22*2,0.28+3.22*3,0.30+3.22*4,0.35+3.22*5,0.47+3.22*6];
			var w = [11,7.6,5.6,7.6,8.6,7.9,13];
			for(var i=0;i<7;i++)
			{
				bodyDef = new b2BodyDef();					
				bodyDef.position.Set(x[i], 10.8);
				boxDef = new b2PolygonDef();
				boxDef.SetAsBox(0.05, 10.8);
				boxDef.friction = 0.1;
				boxDef.density = 0; // static bodies require zero density			
				// Add sprite to body userData
				bodyDef.userData = new PhysGround();
				bodyDef.userData.width = w[i];
				bodyDef.userData.height = stage.stageHeight - 50; 
				addChild(bodyDef.userData);
				body = m_world.CreateBody(bodyDef);
				body.CreateShape(boxDef);
				body.SetMassFromShapes();
			}			
		}
		private function Update(e:Event):void{
			m_world.Step(m_timeStep, m_iterations);
			
			// Go through body list and update sprite positions/rotations
			for (var bb:b2Body = m_world.m_bodyList; bb; bb = bb.m_next){
				if (bb.m_userData is Sprite){
					bb.m_userData.x = bb.GetPosition().x * 30;
					bb.m_userData.y = bb.GetPosition().y * 30;
					bb.m_userData.rotation = bb.GetAngle() * (180/Math.PI);
				}
			}
		}
	}	
}
