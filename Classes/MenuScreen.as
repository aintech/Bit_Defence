package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class MenuScreen extends MovieClip
	{		
		public function MenuScreen()
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
			startBtn.addEventListener(MouseEvent.CLICK, onClickStart, false, 0, true);
			settingsBtn.addEventListener(MouseEvent.CLICK, onClickSettings, false, 0, true);
		}
		
		private function onClickStart(e:MouseEvent):void
		{
			startBtn.removeEventListener(MouseEvent.CLICK, onClickStart);
			settingsBtn.removeEventListener(MouseEvent.CLICK, onClickSettings);
			dispatchEvent(new CustomEvents(CustomEvents.START_GAME));
		}
		
		private function onClickSettings(e:MouseEvent):void
		{
			startBtn.removeEventListener(MouseEvent.CLICK, onClickStart);
			settingsBtn.removeEventListener(MouseEvent.CLICK, onClickSettings);
			dispatchEvent(new CustomEvents(CustomEvents.SHOW_SETTINGS));
		}
	}
}