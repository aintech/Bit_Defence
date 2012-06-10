package 
{
	import flash.display.MovieClip;

	public class CharIcon extends MovieClip
	{
		public var charType:String;
		public var memoryUse:int;
		public var range:int;
		
		public function CharIcon(type:String)
		{
			charType = type;
		}
	}
}