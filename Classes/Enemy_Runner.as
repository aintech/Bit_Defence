package 
{
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Enemy_Runner extends Enemy
	{
		override protected function init():void
		{
			super.init();
			type = "Runner";
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			symbolsDrop = 20 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 15;
			protectDrop = 5;
			baseSpeed = 3;
			stoppingSpeed = 1.8;
			runnerTargetID = 999;
			maxSpeed = 12;
			runnerBrakeDist = 60;
			
			health = baseMaxHealth = maxHealth = 1000;
			shield = 0;
			speed = baseSpeed;
			systemDamage = baseSystemDamage = .3;// 6% sec
			
			baseHackChance = 10;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarUP 		= new Point(25, 0);
			lifeBarDOWN 	= new Point(-25, 0);
			lifeBarLEFT 	= new Point(0, 25);
			lifeBarRIGHT 	= new Point(0, -25);
			
			hitPoint = this.HitingPoint;
			graphPoint = this.GraphPoint;
			tileNumPoint = this.TileNumPoint;
			
			health += baseMaxHealth * Variables.NUM_PROTECTORS * .1;
			maxHealth += baseMaxHealth * Variables.NUM_PROTECTORS * .1;
		}
		
		override public function updateDirection(direct:String):void
		{
			super.updateDirection(direct);
			runnerTargetID--;
		}
		
		override public function updateLevel():void
		{
			super.updateLevel();
			clip.filters = [blurFilter, glowFilter];
		}
	}
}