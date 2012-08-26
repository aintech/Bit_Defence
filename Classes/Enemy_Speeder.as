package 
{
	import flash.geom.Point;
	import flash.events.Event;

	public class Enemy_Speeder extends Enemy
	{
		public function Enemy_Speeder()
		{
			init();
		}
		
		private function init():void
		{
			HitingPoint.visible = false;
			TileNumPoint.visible = false;
			clip.filters = [blurFilter, glowFilter];
			symbolsDrop = 20 * Variables.SYMBOLS_DROP_MULTIPLE;
			memoryDrop = 15;
			baseSpeed = 7;
			//xSpeed = baseSpeed;
			//ySpeed = 7;
			
			health = maxHealth = 50;
			speed = baseSpeed;
			
			baseHackChance = 10;
			hackChance = baseHackChance - ((baseHackChance * Variables.HACK_PROTECT_LEVEL) / 100);
			
			lifeBarWidth 	= 26;
			lifeBarUP 		= new Point(25, 0);
			lifeBarDOWN 	= new Point(-25, 0);
			lifeBarLEFT 	= new Point(0, 25);
			lifeBarRIGHT 	= new Point(0, -25);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			/*if(lifeBar)
			{
				lifeBar.width = clip.width;
				lifeBar.x = lifeBarRIGHT.x;
				lifeBar.y = lifeBarRIGHT.y;
				lifeBar.gotoAndStop(100);
			}*/
			hitPoint = this.HitingPoint;
			graphPoint = this.GraphPoint;
			tileNumPoint = this.TileNumPoint;
			//lifeBar.width = lifeBarWidth;
		}
	}
}