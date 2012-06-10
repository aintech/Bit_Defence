package 
{
	import flash.display.MovieClip;

	public class Missile extends MovieClip
	{
		public var speed:int = 20;
		public var ease:int = 10;
		
		public var target:MovieClip;
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var damage:int;
		
		public var turretLevel:int;
		
		public function Missile()
		{
			// constructor code
		}
	}
}