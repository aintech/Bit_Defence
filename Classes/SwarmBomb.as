package 
{
	import flash.display.MovieClip;

	public class SwarmBomb extends MovieClip
	{
		public static var DAMAGE:int = 3;
		public var speed:Number = 5;
		
		public var destX:Number;
		public var destY:Number;
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var angle:Number;
		public var rads:Number;
		public var flyDist:int = 40;
		
		public function SwarmBomb()
		{
			// constructor code
		}
	}
}