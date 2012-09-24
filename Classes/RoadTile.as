package 
{
	import flash.display.MovieClip;

	public class RoadTile extends MovieClip
	{
		public var direct:String;
		public var ID:int;
		public var tileNumber:int;
		public var collideWithEnemy:Boolean;
		public var runID:int;
		public var mineOccupied:Boolean;
		
		public function RoadTile(type:String, xVal:int, yVal:int)
		{
			direct = type;
			x = xVal;
			y = yVal;
		}
	}
}