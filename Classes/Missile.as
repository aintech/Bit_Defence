package 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;

	public class Missile extends MovieClip
	{
		public var speed:int = 20;
		public var ease:int = 10;
		
		public var target:MovieClip;
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var damage:int;
		
		public var turretLevel:int;
		public var numBombs:int;
		
		public var lostTarget:Boolean = false;
		
		public var orbiterPoint:Point;
		public var orbiterRadius:int = Math.round(Math.random() * 5) + 20;
		public var orbiterSpeed:int = 20;
		public var orbiterAngle:Number = 0;
		
		public var lifeTime:int;
		
		public function Missile()
		{
			
		}
	}
}