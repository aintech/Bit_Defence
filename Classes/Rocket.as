package 
{
	import flash.display.MovieClip;

	public class Rocket extends MovieClip
	{
		public var speed:int = 20;
		
		public var destX:int;
		public var destY:int;
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var damage:int;
		
		public var turretLevel:int;
		
		public function Rocket(xTarget:int, yTarget:int)
		{
			destX = xTarget;
			destY = yTarget;
		}
	}
}