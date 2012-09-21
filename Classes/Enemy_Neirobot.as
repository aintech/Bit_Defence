package 
{
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Enemy_Neirobot extends Enemy
	{
		override protected function init():void
		{
			super.init();
			type = "Neirobot";
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			symbolsDrop = 20 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 10;
			protectDrop = 510;
			baseSpeed = 4;
			stoppingSpeed = .4;
			
			health = baseMaxHealth = maxHealth = 1600;
			shield = 0;
			speed = baseSpeed;
			systemDamage = baseSystemDamage = .2;// 4% sec
			
			baseHackChance = 15;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarUP 		= new Point(30, 0);
			lifeBarDOWN 	= new Point(-30, 0);
			lifeBarLEFT 	= new Point(0, 25);
			lifeBarRIGHT 	= new Point(0, -25);
			
			hitPoint = this.HitingPoint;
			graphPoint = this.GraphPoint;
			tileNumPoint = this.TileNumPoint;
			
			health += baseMaxHealth * Variables.NUM_PROTECTORS * .1;
			maxHealth += baseMaxHealth * Variables.NUM_PROTECTORS * .1;
		}
		
		override public function updateLevel():void
		{
			super.updateLevel();
			clip.filters = [blurFilter, glowFilter];
		}
	}
}