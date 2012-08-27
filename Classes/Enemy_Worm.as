package 
{
	import flash.events.Event;
	import flash.geom.Point;
	
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
			baseSpeed = 3;
			stoppingSpeed = .3;
			
			health = maxHealth = 300;
			speed = baseSpeed;
			
			baseHackChance = 20;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarWidth	= 55;
			lifeBarUP 		= new Point(40, 0);
			lifeBarDOWN 	= new Point(-50, 0);
			lifeBarLEFT 	= new Point(0, 30);
			lifeBarRIGHT 	= new Point(0, -30);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			hitPoint = this.HitingPoint;
			graphPoint = this.GraphPoint;
			tileNumPoint = this.TileNumPoint;
		}
	}
}