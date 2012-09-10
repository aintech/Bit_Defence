package 
{	
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Enemy_Worm extends Enemy
	{
		public function Enemy_Worm()
		{
			init();
		}
		
		private function init():void
		{
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			clip.filters = [blurFilter, glowFilter];
			symbolsDrop = 40 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 30;
			protectDrop = 10;
			baseSpeed = 3;
			stoppingSpeed = .3;
			
			health = maxHealth = 300;
			speed = baseSpeed;
			systemDamage = .6;// 12% in sec = .6% in timer tic
			
			baseHackChance = 20;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarWidth	= 55;
			lifeBarUP 		= new Point(40, 0);
			lifeBarDOWN 	= new Point(-50, 0);
			lifeBarLEFT 	= new Point(0, 30);
			lifeBarRIGHT 	= new Point(0, -30);
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