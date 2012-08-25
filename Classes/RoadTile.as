package 
{
	import flash.display.MovieClip;

	public class RoadTile extends MovieClip
	{
		public var direct:String;
		public var ID:int;
		public var startRoadTile:Boolean = false;
		public var endRoadTile:Boolean = false;
		public var tileNumber:int;
		
		public function RoadTile(type:String, xVal:int, yVal:int)
		{
			direct = type;
			x = xVal;
			y = yVal;
		}
	}
}