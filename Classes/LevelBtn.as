package 
{
	import flash.display.MovieClip;

	public class LevelBtn extends MovieClip
	{
		public var level:int;
		
		public function LevelBtn(level:int = 0)
		{
			this.level = level;
			mouseEnabled = false;
			mouseChildren = false;
		}
	}
}