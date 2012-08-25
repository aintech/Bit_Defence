package 
{
	import flash.display.MovieClip;
	import flash.geom.Point;

	public class Drop extends MovieClip
	{
		public static const DROP_SYMBOLS:String = "drop symbols";
		public static const DROP_MEMORY:String 	= "drop memory";
		public static const DROP_DISTANCE:int	= 40;
		
		public var dropType:String;
		public var dropAmaunt:int;
		
		public var speed:int = 7;
		public var gotoScoreSpeed:int = 25;
		public var destX:Number;
		public var destY:Number;
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var gotoScorePoint:Point;
		
		public var gotoScoreBoard:Boolean = false;
		public var waitCounter:int = 0;
		public var waitTime:int = 30;
		
		public function Drop()
		{
			this.buttonMode = true;
			this.mouseChildren = false;
		}
	}
}