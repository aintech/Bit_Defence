package 
{
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Enemy_Cycler extends Enemy
	{
		override protected function init():void
		{
			super.init();
			type = "Cycler";
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			symbolsDrop = 20 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 15;
			protectDrop = 10;
			baseSpeed = 7;
			stoppingSpeed = .7;
			
			health = baseMaxHealth = maxHealth = 5000;
			shield = 0;
			speed = baseSpeed;
			systemDamage = baseSystemDamage = .5;// 10% sec
			
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
		
		override public function calcDamage(value:int):void
		{
			super.calcDamage(value);
			systemDamage = Number((health / maxHealth * .5).toFixed(1));
			if(systemDamage < .1) systemDamage = .1;
		}
		
		override public function updateLevel():void
		{
			super.updateLevel();
			clip.filters = [blurFilter, glowFilter];
		}
	}
}