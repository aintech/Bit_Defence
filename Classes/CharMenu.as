package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;

	public class CharMenu extends MovieClip
	{
		public var target:Object;
		
		public function CharMenu()
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
			sellBtn.filters = [new GlowFilter(0xFF0000)];
			sellBtn.buttonMode = true;
			sellBtn.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			sellBtn.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
		}
		
		private function onOver(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case "upgradeBtn":
					upgradeBtn.filters = [new GlowFilter(0x0000FF, 1, 10, 10)];
				break;
				
				case "sellBtn":
					sellBtn.filters = [new GlowFilter(0xFF0000, 1, 10, 10)];
				break;
			}
		}
		
		private function onOut(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case "upgradeBtn":
					upgradeBtn.filters = [new GlowFilter(0x0000FF)];
				break;
				
				case "sellBtn":
					sellBtn.filters = [new GlowFilter(0xFF0000)];
				break;
			}
		}
		
		/*public function disableUpgrade():void
		{
			upgradeBtn.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			upgradeBtn.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			upgradeBtn.filters = [];
			upgradeBtn.buttonMode = false;
		}*/
		
		public function enableUpgrade():void
		{
			upgradeBtn.filters = [new GlowFilter(0x0000FF)];
			upgradeBtn.buttonMode = true;
			upgradeBtn.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			upgradeBtn.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
		}
	}
}