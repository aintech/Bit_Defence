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
			hitPoint.visible = false;
			clip.filters = [blurFilter, glowFilter];
			moneyDrop = 50;
			baseSpeed = 3;
			xSpeed = baseSpeed;
			ySpeed = 0;
			
			health = maxHealth = 300;
			speed = baseSpeed;
			
			hackChance = 20;
			
			lifeBarUP 		= new Point(40, 0);
			lifeBarDOWN 	= new Point(-50, 0);
			lifeBarLEFT 	= new Point(0, 30);
			lifeBarRIGHT 	= new Point(0, -30);
			
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