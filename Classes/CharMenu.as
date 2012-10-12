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
			upgradeBtn.hitRect.alpha = 0;
			sellBtn.hitRect.alpha = 0;
			
			sellBtn.filters = [new GlowFilter(0xFF0000)];
			sellBtn.hitRect.buttonMode = true;
			sellBtn.hitRect.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			sellBtn.hitRect.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
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
			upgradeBtn.hitRect.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			upgradeBtn.hitRect.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			upgradeBtn.filters = [];
			upgradeBtn.hitRect.buttonMode = false;
		}*/
		
		public function enableUpgrade():void
		{
			upgradeBtn.filters = [new GlowFilter(0x0000FF)];
			upgradeBtn.hitRect.buttonMode = true;
			upgradeBtn.hitRect.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			upgradeBtn.hitRect.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
		}
	}
}