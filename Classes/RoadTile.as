package 
{
	import flash.display.MovieClip;

	public class RoadTile extends MovieClip
	{
		public var direct:String;
		
		public function RoadTile(type:String, xVal:int, yVal:int)
		{
			direct = type;
			x = xVal;
			y = yVal;
		}
	}
}