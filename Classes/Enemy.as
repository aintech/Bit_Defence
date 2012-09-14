package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Enemy extends MovieClip
	{
		public static var STARTING_DIRECTION:String;
		
		public static const DIR_RIGHT:String 	= "direction Right";
		public static const DIR_LEFT:String		= "direction Left";
		public static const DIR_UP:String		= "direction Up";
		public static const DIR_DOWN:String		= "direction Down";
		
		public static const STATUS_POISON:String 	= "status poison";
		public static const STATUS_STUN:String		= "status stun";
		public static const STATUS_FREEZE:String	= "status freeze";
		public static const STATUS_CLOUD:String	= "status cloud";
		public static const STATUS_HEAL:String		= "status heal";
		
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
		public var protectDrop:int;
		public var baseSpeed:Number;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var speed:Number;
		
		public var maxHealth:int;
		public var health:int;
		public var lifeBar:MovieClip;
		public var ID:int = 11111;
		
		public var underFreeze:Boolean;
		public var freezeCounter:int = 0;
		public var maxTimeFreeze:int = Variables.FREEZE_SPEED_REDUCE_DURATION;
		
		public var isStuned:Boolean;
		public var stunCounter:int = 0;
		public var maxTimeStuned:int = Variables.FREEZE_STUN_DURATION;
		public var stoppingSpeed:Number;
		public var speedUP:Boolean;
		
		public var isPoisoned:Boolean;
		public var poisonCounter:int = 0;
		public var maxPoisonCounter:int = Variables.LAUNCHER_POISON_DURATION;
		
		public var baseHackChance:int;
		public var hackChance:int;
		
		public var lifeBarUP:Point;
		public var lifeBarDOWN:Point;
		public var lifeBarRIGHT:Point;
		public var lifeBarLEFT:Point;
				
		public var hackChanceDecreased:Boolean;
		public var roadID:int;
		
		public var poisonCloudOnBoard:Boolean;
		public var touchCloud:Boolean;
		public var stunProlonger:Boolean;
		public var thisTurnCloudTouched:Boolean;
		
		public var tileNum:int = 999;
		public var distToMissile:Number;
				
		public var direction:String;
		
		public var statusHolder:Sprite;
		public var statusEffect:StatusEffects;
		public var effectsArray:Array = [];
		
		public var systemDamage:Number;
		public var isFalseHacking:Boolean;
		
		public var isHealing:Boolean;
		public var healAmount:int;
		public var healDistance:int;
		
		public var isHacking:Boolean;
				
		public function Enemy()
		{
			level = baseLevel;
			levelColor = levelColors[level];
			glowFilter = new GlowFilter(levelColor);
			blurFilter = new BlurFilter(2, 2);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		protected function onAdd(e:Event):void
		{	
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			lifeBar = new LifeBar();
			addChild(lifeBar);
			lifeBar.gotoAndStop(lifeBar.totalFrames);
			if(!Settings.LIFEBAR_VISIBLE) lifeBar.visible = false;
			
			ID = Math.round(Math.random() * 100000);
			
			statusHolder = new Sprite;
			addChild(statusHolder);
			
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
		
		public function addStatus(effect:String)
		{
			switch(effect)
			{
				case Enemy.STATUS_FREEZE:
					underFreeze = true;
					freezeCounter = 0;
					speed = baseSpeed * Variables.FREEZE_SPEED_REDUCE_MULTIPLY;
				break;
				
				case Enemy.STATUS_POISON:
					isPoisoned = true;
					poisonCounter = 0;
				break;
				
				case Enemy.STATUS_STUN:
					isStuned = true;
					stunCounter = 0;
				break;
				
				case Enemy.STATUS_CLOUD:
					touchCloud = true;
				break;
				
				case Enemy.STATUS_HEAL:
					if(isHealing) return;
					isHealing = true;
				break;
			}
			statusEffect = new StatusEffects(effect);
			statusEffect.gotoAndStop(effect);
			statusHolder.addChild(statusEffect);
			effectsArray.push(statusEffect);
			sortStatusEffects();
		}
		
		public function removeStatus(effect:String)
		{
			switch(effect)
			{
				case Enemy.STATUS_FREEZE:
					underFreeze = false;
					freezeCounter = 0;
				break;
				
				case Enemy.STATUS_POISON:
					isPoisoned = false;
					poisonCounter = 0;
				break;
				
				case Enemy.STATUS_STUN:
					isStuned = false;
					stunCounter = 0;
					speedUP = true;
				break;
				
				case Enemy.STATUS_CLOUD:
					touchCloud = false;
				break;
				
				case Enemy.STATUS_HEAL:
					isHealing = false;
				break;
			}
			for(var i:int = effectsArray.length; --i >= 0;)
			{
				var tempStatus:StatusEffects = effectsArray[i];
				if(tempStatus.effect == effect)
				{
					effectsArray.splice(i, 1);
					statusHolder.removeChild(tempStatus);
					tempStatus = null;
				}
			}
			sortStatusEffects();
		}
		
		private function sortStatusEffects()
		{
			var effLength:int = effectsArray.length;
			for(var i:int = 0; i < effLength; i++)
			{
				statusEffect = effectsArray[i];
				statusEffect.x = -(statusEffect.width * .5 * effLength) + (statusEffect.width * i);
			}
		}
		
		public function calcDamage(value:int):void
		{
			health -= value;
			lifeBar.gotoAndStop(Math.floor(health / maxHealth * 100));
			//if(lifeBar.currentFrame >= 76) lifeBar.filters = [new GlowFilter(0xFFFFFF, 1, 1, 3)];
			//else if(lifeBar.currentFrame >= 51) lifeBar.filters = [new GlowFilter(0x00FF00, 1, 1, 3)];
			//else if(lifeBar.currentFrame >= 26) lifeBar.filters = [new GlowFilter(0xFFFF00, 1, 1, 3)];
			//else lifeBar.filters = [new GlowFilter(0xFF0000, 1, 1, 3)];
		}
	}
}