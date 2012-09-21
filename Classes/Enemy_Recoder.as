package 
{
	import flash.geom.Point;
	import flash.events.Event;

	public class Enemy_Recoder extends Enemy
	{
		override protected function init():void
		{
			super.init();
			type = "Recoder";
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			symbolsDrop = 50 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 30;
			protectDrop = 15;
			baseSpeed = 5;
			stoppingSpeed = .5;
			
			health = baseMaxHealth = maxHealth = 500;
			shield = 0;
			speed = baseSpeed;
			systemDamage = baseSystemDamage = .4;
			
			baseHackChance = 10;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
						
			lifeBarUP		= new Point(35, 0);
			lifeBarDOWN 	= new Point(-35, 0);
			lifeBarLEFT		= new Point(0, 25);
			lifeBarRIGHT	= new Point(0, -25);
			
			hitPoint = this.HitingPoint;
			graphPoint = this.GraphPoint;
			tileNumPoint = this.TileNumPoint;
			
			health += baseMaxHealth * Variables.NUM_PROTECTORS * .1;
			maxHealth += baseMaxHealth * Variables.NUM_PROTECTORS * .1;
			
			healAmount 		= 2;
			healDistance	= 200;
		}
		
		override public function updateLevel():void
		{
			super.updateLevel();
			clip.filters = [blurFilter, glowFilter];
		}
	}
}