package 
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;

	public class AvailableActionFlag extends Sprite
	{
		public function AvailableActionFlag()
		{
			this.filters = [new GlowFilter(0x00FFFF)];
		}
	}
}