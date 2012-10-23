package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.GlowFilter;
	import flash.display.Sprite;

	public class SettingsScreen extends MovieClip
	{
		private var txtName:TextField;
		private var nameFormat:TextFormat;
		
		private var lifeBarSwitch:TextField;
		private var switchFormat:TextFormat;
		
		private var lifeBarBtn:Button;
		private var backBtn:Button;
		
		private var BG:Sprite;
		private var opaqueBG:Boolean;
		
		public function SettingsScreen(drawBG:Boolean)
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
			opaqueBG = drawBG;
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
			addEventListener(MouseEvent.CLICK, stageFocus, false, 0, true);
		}
		
		private function stageFocus(e:MouseEvent):void
		{
			stage.focus = this;
		}
		
		private function init():void
		{
			nameFormat = new TextFormat("Digital-7", 60, 0xFFFFFF)
			
			txtName = new TextField();
			txtName.defaultTextFormat = nameFormat;
			txtName.embedFonts = true;
			txtName.autoSize = TextFieldAutoSize.CENTER;
			txtName.text = "SETTINGS";
			txtName.selectable = false;
			txtName.x = Main.STAGE_WIDTH * .5 - txtName.width * .5;
			txtName.y = 35;
			txtName.filters = [new GlowFilter(0xFF0000)];
			addChild(txtName);
			
			switchFormat = new TextFormat("Digital-7", 50, 0xFFFFFF)
			
			lifeBarSwitch = new TextField();
			lifeBarSwitch.defaultTextFormat = switchFormat;
			lifeBarSwitch.embedFonts = true;
			lifeBarSwitch.autoSize = TextFieldAutoSize.LEFT;
			lifeBarSwitch.text = "ON";
			lifeBarSwitch.selectable = false;
			lifeBarSwitch.filters = [new GlowFilter(0xFF0000)];
			addChild(lifeBarSwitch);
			
			lifeBarBtn = new Button("LIFEBAR");
			lifeBarBtn.x = Main.STAGE_WIDTH * .5 - lifeBarBtn.width * .5;
			lifeBarBtn.y = 300;
			addChild(lifeBarBtn);
			
			lifeBarSwitch.x = lifeBarBtn.x + lifeBarBtn.width + lifeBarBtn.offset;
			lifeBarSwitch.y = lifeBarBtn.y;
			
			backBtn = new Button("BACK");
			backBtn.x = Main.STAGE_WIDTH * .5 - backBtn.width * .5;
			backBtn.y = lifeBarBtn.y + lifeBarBtn.height + backBtn.offset + 60;
			addChild(backBtn);
			
			//soundBtn.addEventListener(MouseEvent.CLICK, clickSound, false, 0, true);
			//musicBtn.addEventListener(MouseEvent.CLICK, clickMusic, false, 0, true);
			lifeBarBtn.addEventListener(MouseEvent.CLICK, clickLifeBar, false, 0, true);
			backBtn.addEventListener(MouseEvent.CLICK, backToMenu, false, 0, true);
			
			/*if(Settings.SOUND_ON) soundSwitch.text = "ON";
			else if(!Settings.SOUND_ON) soundSwitch.text = "OFF";
			
			if(Settings.MUSIC_ON) musicSwitch.text = "ON";
			else if(!Settings.MUSIC_ON) musicSwitch.text = "OFF";*/
			
			if(Settings.LIFEBAR_VISIBLE) lifeBarSwitch.text = "ON";
			else if(!Settings.LIFEBAR_VISIBLE) lifeBarSwitch.text = "OFF";
			
			BG = new Sprite;
			BG.graphics.beginFill(0x000000);
			BG.graphics.drawRect(0, 0, Main.STAGE_WIDTH, Main.STAGE_HEIGHT);
			BG.graphics.endFill();
			addChildAt(BG, 0);
			if(!opaqueBG) BG.alpha = 0; 
		}
		
		/*private function clickSound(e:MouseEvent):void
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
		}*/
		
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
			/*soundBtn.removeEventListener(MouseEvent.CLICK, clickSound);
			musicBtn.removeEventListener(MouseEvent.CLICK, clickMusic);*/
			lifeBarBtn.removeEventListener(MouseEvent.CLICK, clickLifeBar);
			backBtn.removeEventListener(MouseEvent.CLICK, backToMenu);
			dispatchEvent(new CustomEvents(CustomEvents.CLOSE_SETTINGS));
		}
	}
}