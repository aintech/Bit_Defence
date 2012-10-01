package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;

	public class CancelSpecialTool extends MovieClip
	{
		public function CancelSpecialTool()
		{
			filters = [new GlowFilter(0xFF0000)];
		}
	}
}