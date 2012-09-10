package 
{
	import flash.geom.Point;
	import flash.events.Event;

	public class Enemy_Recoder extends Enemy
	{		
		public function Enemy_Recoder()
		{
			init();
		}
		
		private function init():void
		{
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			clip.filters = [glowFilter, blurFilter];
			symbolsDrop = 50 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 30;
			protectDrop = 15;
			baseSpeed = 5;
			stoppingSpeed = .5;
			
			health = maxHealth = 150;
			speed = baseSpeed;
			systemDamage = .4;
			
			baseHackChance = 10;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarWidth 	= 50;
			
			lifeBarUP		= new Point(35, 0);
			lifeBarDOWN 	= new Point(-35, 0);
			lifeBarLEFT		= new Point(0, 25);
			lifeBarRIGHT	= new Point(0, -25);
			
			healAmount 		= 2;
			healDistance	= 120;
		}
		
		override protected function onAdd(e:Event):void
		{
			super.onAdd(e);
			hitPoint = this.HitingPoint;
			graphPoint = this.GraphPoint;
			tileNumPoint = this.TileNumPoint;
		}
	}
}