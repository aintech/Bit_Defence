package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

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
			gotoAndStop("start");
			x = Main.STAGE_WIDTH;
		}
	}
}