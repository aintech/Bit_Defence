package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;

	public class SpecialToolsCooldown extends MovieClip
	{
		public var timeToWait:int;
		public var waitCounter:int	= 0;
		public var tool:SpecialTools;
		
		public function SpecialToolsCooldown(toolInAction:SpecialTools)
		{
			tool = toolInAction as SpecialTools;
			filters = [new GlowFilter(0xFF0000)];
			mouseEnabled = false;
			mouseChildren = false;
		}
	}
}