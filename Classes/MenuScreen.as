package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class MenuScreen extends MovieClip
	{
		private var newGameBtn:Button;
		private var continueBtn:Button;
		private var settingsBtn:Button;
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
			newGameBtn = new Button("NEW GAME");
			continueBtn = new Button("CONTINUE");
			settingsBtn = new Button("SETTINGS");
			
			newGameBtn.x = Main.STAGE_WIDTH * .5 - newGameBtn.width * .5;
			newGameBtn.y = 300;
			addChild(newGameBtn);
			
			continueBtn.x = newGameBtn.x;
			continueBtn.y = newGameBtn.y + newGameBtn.height + 10;
			addChild(continueBtn);
			
			settingsBtn.x = continueBtn.x;
			settingsBtn.y = continueBtn.y + continueBtn.height + 10;
			addChild(settingsBtn);
			
			newGameBtn.addEventListener(MouseEvent.CLICK, onClickNewGame, false, 0, true);
			continueBtn.addEventListener(MouseEvent.CLICK, onClickContinue, false, 0, true);
			settingsBtn.addEventListener(MouseEvent.CLICK, onClickSettings, false, 0, true);
		}
		
		private function onClickNewGame(e:MouseEvent):void
		{
			newGameBtn.removeEventListener(MouseEvent.CLICK, onClickNewGame);
			continueBtn.removeEventListener(MouseEvent.CLICK, onClickContinue);
			settingsBtn.removeEventListener(MouseEvent.CLICK, onClickSettings);
			dispatchEvent(new CustomEvents(CustomEvents.START_GAME));
		}
		
		private function onClickContinue(e:MouseEvent):void
		{
			
		}
		
		private function onClickSettings(e:MouseEvent):void
		{
			newGameBtn.removeEventListener(MouseEvent.CLICK, onClickNewGame);
			continueBtn.removeEventListener(MouseEvent.CLICK, onClickContinue);
			settingsBtn.removeEventListener(MouseEvent.CLICK, onClickSettings);
			dispatchEvent(new CustomEvents(CustomEvents.SHOW_SETTINGS));
		}
	}
}