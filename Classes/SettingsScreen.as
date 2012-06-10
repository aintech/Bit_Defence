package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class SettingsScreen extends MovieClip
	{
		public function SettingsScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			init();
			addEventListener(MouseEvent.CLICK, stageFocus, false, 0, true);
		}
		
		private function stageFocus(e:MouseEvent):void
		{
			stage.focus = this;
		}
		
		private function init():void
		{
			soundBtn.addEventListener(MouseEvent.CLICK, clickSound, false, 0, true);
			musicBtn.addEventListener(MouseEvent.CLICK, clickMusic, false, 0, true);
			lifeBarBtn.addEventListener(MouseEvent.CLICK, clickLifeBar, false, 0, true);
			backToMenuBtn.addEventListener(MouseEvent.CLICK, backToMenu, false, 0, true);
			
			if(Settings.SOUND_ON) soundSwitch.text = "ON";
			else if(!Settings.SOUND_ON) soundSwitch.text = "OFF";
			
			if(Settings.MUSIC_ON) musicSwitch.text = "ON";
			else if(!Settings.MUSIC_ON) musicSwitch.text = "OFF";
			
			if(Settings.LIFEBAR_VISIBLE) lifeBarSwitch.text = "ON";
			else if(!Settings.LIFEBAR_VISIBLE) lifeBarSwitch.text = "OFF";
		}
		
		private function clickSound(e:MouseEvent):void
		{
			Settings.SOUND_ON = !Settings.SOUND_ON;
			if(Settings.SOUND_ON) soundSwitch.text = "ON";
			else if(!Settings.SOUND_ON) soundSwitch.text = "OFF";
			Settings.SETTINGS_CHANGED = true;
			stage.focus = this;
		}
		
		private function clickMusic(e:MouseEvent):void
		{
			Settings.MUSIC_ON = !Settings.MUSIC_ON;
			if(Settings.MUSIC_ON) musicSwitch.text = "ON";
			else if(!Settings.MUSIC_ON) musicSwitch.text = "OFF";
			Settings.SETTINGS_CHANGED = true;
			stage.focus = this;
		}
		
		private function clickLifeBar(e:MouseEvent):void
		{
			Settings.LIFEBAR_VISIBLE = !Settings.LIFEBAR_VISIBLE;
			if(Settings.LIFEBAR_VISIBLE) lifeBarSwitch.text = "ON";
			else if(!Settings.LIFEBAR_VISIBLE) lifeBarSwitch.text = "OFF";
			Settings.SETTINGS_CHANGED = true;
			stage.focus = this;
		}
		
		private function backToMenu(e:MouseEvent):void
		{
			e.stopPropagation();
			soundBtn.removeEventListener(MouseEvent.CLICK, clickSound);
			musicBtn.removeEventListener(MouseEvent.CLICK, clickMusic);
			lifeBarBtn.removeEventListener(MouseEvent.CLICK, clickLifeBar);
			backToMenuBtn.removeEventListener(MouseEvent.CLICK, backToMenu);
			dispatchEvent(new CustomEvents(CustomEvents.CLOSE_SETTINGS));
		}
	}
}