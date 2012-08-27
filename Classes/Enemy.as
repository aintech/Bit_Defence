package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;

	public class Enemy extends MovieClip
	{
		public static var STARTING_DIRECTION:String;
		
		public static const DIR_RIGHT:String 	= "direction Right";
		public static const DIR_LEFT:String		= "direction Left";
		public static const DIR_UP:String		= "direction Up";
		public static const DIR_DOWN:String		= "direction Down";
		
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
		
		public var previusXSpeed:Number;
		public var previusYSpeed:Number;		
		public var firstStun:Boolean = false;
		public var speedUP:Boolean = false;
		
		public var hackChanceDecreased:Boolean = false;
		public var roadID:int;
		
		public var poisonCloudOnBoard:Boolean	= false;
		public var stunProlonger:Boolean		= false;
		
		public var tileNum:int = 999;
		public var distToMissile:Number;
		
		public var direction:String;
		
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
			if(!Settings.LIFEBAR_VISIBLE) lifeBar.visible = false;
			
			ID = Math.round(Math.random() * 100000);
			
			switch(Enemy.STARTING_DIRECTION)
			{
				case Enemy.DIR_DOWN:
				lifeBar.rotation = -90;
				lifeBar.x = lifeBarDOWN.x;
				lifeBar.y = lifeBarDOWN.y;
				break;
				
				case Enemy.DIR_LEFT:
				lifeBar.rotation = 180;
				lifeBar.x = lifeBarLEFT.x;
				lifeBar.y = lifeBarLEFT.y;
				break;
				
				case Enemy.DIR_RIGHT:
				lifeBar.rotation = 0;
				lifeBar.x = lifeBarRIGHT.x;
				lifeBar.y = lifeBarRIGHT.y;
				break;
				
				case Enemy.DIR_UP:
				lifeBar.rotation = 90;
				lifeBar.x = lifeBarUP.x;
				lifeBar.y = lifeBarUP.y;
				break;
			}
			lifeBar.gotoAndStop(lifeBar.totalFrames);
		}
		
		public function updateLevel(newLevel:int):void
		{
			
		}
	}
}