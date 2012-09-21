package 
{	
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Enemy_Worm extends Enemy
	{
		override protected function init():void
		{
			super.init();
			type = "Worm";
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			symbolsDrop = 40 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 30;
			protectDrop = 10;
			baseSpeed = 3;
			stoppingSpeed = .3;
			
			health = baseMaxHealth = maxHealth = 3000;
			shield = 0;
			speed = baseSpeed;
			systemDamage = baseSystemDamage = .6;// 12% in sec = .6% in timer tic
			
			baseHackChance = 20;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarUP 		= new Point(30, 0);
			lifeBarDOWN 	= new Point(-35, 0);
			lifeBarLEFT 	= new Point(0, 20);
			lifeBarRIGHT 	= new Point(0, -20);
			
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