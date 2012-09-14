package 
{
	import flash.geom.Point;
	import flash.events.Event;
	
	public class Enemy_Protector extends Enemy
	{
		public function Enemy_Protector()
		{
			init();
		}
		
		private function init():void
		{
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			clip.filters = [blurFilter, glowFilter];
			symbolsDrop = 30 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 10;
			protectDrop = 10;
			baseSpeed = 4;
			stoppingSpeed = .4;
			
			health = maxHealth = 2000;
			speed = baseSpeed;
			systemDamage = .1;// 4% sec
			
			baseHackChance = 16;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarUP 		= new Point(25, 0);
			lifeBarDOWN 	= new Point(-25, 0);
			lifeBarLEFT 	= new Point(0, 25);
			lifeBarRIGHT 	= new Point(0, -25);
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