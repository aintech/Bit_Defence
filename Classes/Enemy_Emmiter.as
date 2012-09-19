package 
{
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Enemy_Emmiter extends Enemy
	{
		override protected function init():void
		{
			super.init();
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			symbolsDrop = 20 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 30;
			protectDrop = 20;
			baseSpeed = 4;
			stoppingSpeed = .4;
			
			health = maxHealth = 10000;
			shield = 0;
			speed = baseSpeed;
			systemDamage = .3;// 6% sec
			bugsAppearTime = 30;// каждые 1,5 сек появляется Bug
			bugsWaitTime = 0;
			
			baseHackChance = 25;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarUP 		= new Point(40, 0);
			lifeBarDOWN 	= new Point(-40, 0);
			lifeBarLEFT 	= new Point(0, 25);
			lifeBarRIGHT 	= new Point(0, -25);
			
			hitPoint = this.HitingPoint;
			graphPoint = this.GraphPoint;
			tileNumPoint = this.TileNumPoint;
		}
		
		override public function updateLevel():void
		{
			super.updateLevel();
			clip.filters = [blurFilter, glowFilter];
		}
	}
}