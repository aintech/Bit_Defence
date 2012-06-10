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
			clip.hitPoint.visible = false;
			clip.filters = [blurFilter, glowFilter];
			moneyDrop = 30;
			baseSpeed = 7;
			xSpeed = baseSpeed;
			ySpeed = 0;
			
			health = maxHealth = 50;
			speed = baseSpeed;
			
			hackChance = 10;
			
			lifeBarUP 		= new Point(25, 0);
			lifeBarDOWN 	= new Point(-25, 0);
			lifeBarLEFT 	= new Point(0, 25);
			lifeBarRIGHT 	= new Point(0, -25);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			if(lifeBar)
			{
				lifeBar.width = clip.width;
				lifeBar.x = lifeBarRIGHT.x;
				lifeBar.y = lifeBarRIGHT.y;
				lifeBar.gotoAndStop(100);
			}
		}
	}
}