package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.display.Sprite;

	public class Enemy extends MovieClip
	{
		public static var STARTING_DIRECTION:String;
		
		public static const DIR_RIGHT:String 	= "direction Right";
		public static const DIR_LEFT:String		= "direction Left";
		public static const DIR_UP:String		= "direction Up";
		public static const DIR_DOWN:String		= "direction Down";
		CONTINIUM указать эти константы в levelData и GamePlay
		
		public var baseLevel:int = 1;
		public var level:int;
		
		public var hitPoint:MovieClip;
		public var graphPoint:GraphicPoint;
		public var tileNumPoint:MovieClip;
		
		protected var levelColors:Array = [NaN, 0x0000ff, 0x22ff22, 0xff0000];
		protected var glowFilter:GlowFilter;
		protected var blurFilter:BlurFilter;
		public var levelColor:uint;
		
		public var symbolsDrop:int;
		public var memoryDrop:int;
		public var baseSpeed:Number;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var speed:Number;
		
		public var maxHealth:int;
		public var health:int;
		public var lifeBar:MovieClip;
		public var ID:int = 11111;
		
		public var underFreeze:Boolean = false;
		public var freezeCounter:int = 0;
		public var maxTimeFreeze:int = Variables.FREEZE_SPEED_REDUCE_DURATION;
		
		public var isStuned:Boolean = false;
		public var stunCounter:int = 0;
		public var maxTimeStuned:int = Variables.FREEZE_STUN_DURATION;
		public var stoppingSpeed:Number;
		public var speedUP:Boolean = false;
		
		public var isPoisoned:Boolean = false;
		public var poisonCounter:int = 0;
		public var maxPoisonCounter:int = Variables.LAUNCHER_POISON_DURATION;
		
		public var baseHackChance:int;
		public var hackChance:int;
		
		public var lifeBarWidth:int;
		public var lifeBarUP:Point;
		public var lifeBarDOWN:Point;
		public var lifeBarRIGHT:Point;
		public var lifeBarLEFT:Point;
				
		public var hackChanceDecreased:Boolean = false;
		public var roadID:int;
		
		public var poisonCloudOnBoard:Boolean	= false;
		public var stunProlonger:Boolean		= false;
		
		public var tileNum:int = 999;
		public var distToMissile:Number;
				
		public var direction:String;
		
		public var statusHolder:Sprite;
		public var statusEffect:StatusEffects;
		CONTINIUM статусы пихаются в statusHolder и сортируются согласно его numChildren
		
		public function Enemy()
		{
			level = baseLevel;
			levelColor = levelColors[level];
			glowFilter = new GlowFilter(levelColor);
			blurFilter = new BlurFilter(2, 2);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
			
		}
		
		private function onAdd(e:Event):void
		{			
			lifeBar = new LifeBar();
			addChild(lifeBar);
			lifeBar.width = getChildByName("clip").width;
			lifeBar.gotoAndStop(lifeBar.totalFrames);
			if(!Settings.LIFEBAR_VISIBLE) lifeBar.visible = false;
			
			ID = Math.round(Math.random() * 100000);
			
			statusHolder = new Sprite;
			addChild(statusHolder);
			
			/*statusEffect = new StatusEffects();
			statusEffect.gotoAndStop(1);
			statusHolder.addChild(statusEffect);*/
			
			updateDirection(Enemy.STARTING_DIRECTION);
		}
		
		public function updateDirection(direct:String):void
		{
			switch(direct)
			{
				case Enemy.DIR_DOWN:
					rotation = 90;
					direction = Enemy.DIR_DOWN;
					lifeBar.rotation = statusHolder.rotation = -90;
					lifeBar.x = lifeBarDOWN.x;
					lifeBar.y = lifeBarDOWN.y;
					statusHolder.x = lifeBar.x - 10;
					statusHolder.y = lifeBar.y;
				break;
				
				case Enemy.DIR_LEFT:
					rotation = -180;
					direction = Enemy.DIR_LEFT;
					lifeBar.rotation = statusHolder.rotation = 180;
					lifeBar.x = lifeBarLEFT.x;
					lifeBar.y = lifeBarLEFT.y;
					statusHolder.x = lifeBar.x;
					statusHolder.y = lifeBar.y + 10;
				break;
				
				case Enemy.DIR_RIGHT:
					rotation = 0;
					direction = Enemy.DIR_RIGHT;
					lifeBar.rotation = statusHolder.rotation = 0;
					lifeBar.x = lifeBarRIGHT.x;
					lifeBar.y = lifeBarRIGHT.y;
					statusHolder.x = lifeBar.x;
					statusHolder.y = lifeBar.y - 10;
				break;
				
				case Enemy.DIR_UP:
					rotation = -90;
					direction = Enemy.DIR_UP;
					lifeBar.rotation = statusHolder.rotation = 90;
					lifeBar.x = lifeBarUP.x;
					lifeBar.y = lifeBarUP.y;
					statusHolder.x = lifeBar.x + 10;
					statusHolder.y = lifeBar.y;
				break;
			}
		}
	}
}