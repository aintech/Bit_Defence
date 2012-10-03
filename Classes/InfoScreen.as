package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.GlowFilter;

	public class InfoScreen extends MovieClip
	{
		public var previusTarget:* = null;
		public var target:*;
		
		public function InfoScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void
		{
			filters = [new GlowFilter(0x0000FF)];
			gotoAndStop("start");
			x = Main.STAGE_WIDTH;
		}
	}
}