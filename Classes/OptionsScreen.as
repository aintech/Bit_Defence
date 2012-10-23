package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.GlowFilter;
	import flash.display.Shape;

	public class OptionsScreen extends MovieClip
	{
		private var optionsField:TextField;
		private var optionsFormat:TextFormat;
		
		public var resumeBtn:Button;
		public var restartBtn:Button;
		public var settingsBtn:Button;
		public var mapBtn:Button;
		public var menuBtn:Button;
		public var saveBtn:Button;
		
		public function OptionsScreen()
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
			var Bg:Shape = new Shape();
			Bg.graphics.beginFill(0x000000, 0);
			Bg.graphics.drawRect(0, 0, Main.STAGE_WIDTH, Main.STAGE_HEIGHT);
			addChild(Bg);
			
			optionsFormat = new TextFormat("Digital-7", 60, 0xFFFFFF)
			
			optionsField = new TextField();
			optionsField.defaultTextFormat = optionsFormat;
			optionsField.embedFonts = true;
			optionsField.autoSize = TextFieldAutoSize.CENTER;
			optionsField.text = "OPTIONS";
			optionsField.selectable = false;
			optionsField.x = Main.STAGE_WIDTH * .5 - optionsField.width * .5;
			optionsField.y = 35;
			optionsField.filters = [new GlowFilter(0xFF0000)];
			addChild(optionsField);
			
			resumeBtn = new Button("RESUME");
			resumeBtn.name = "resumeBtn";
			resumeBtn.x = Main.STAGE_WIDTH * .5 - resumeBtn.width * .5;
			resumeBtn.y = 200;
			addChild(resumeBtn);
			
			restartBtn = new Button("RESTART");
			restartBtn.x = resumeBtn.x;
			restartBtn.name = "restartBtn";
			restartBtn.y = resumeBtn.y + restartBtn.height + restartBtn.offset;
			addChild(restartBtn);
			
			settingsBtn = new Button("SETTINGS");
			settingsBtn.name = "settingsBtn";
			settingsBtn.x = restartBtn.x;
			settingsBtn.y = restartBtn.y + settingsBtn.height + settingsBtn.offset;
			addChild(settingsBtn);
			
			mapBtn = new Button("MAP");
			mapBtn.name = "mapBtn";
			mapBtn.x = settingsBtn.x;
			mapBtn.y = settingsBtn.y + mapBtn.height + mapBtn.offset;
			addChild(mapBtn);
			
			menuBtn = new Button("MENU");
			menuBtn.name = "menuBtn"
			menuBtn.x = mapBtn.x;
			menuBtn.y = mapBtn.y + menuBtn.height + menuBtn.offset;
			addChild(menuBtn);
			
			saveBtn = new Button("SAVE");
			saveBtn.name = "saveBtn";
			saveBtn.x = menuBtn.x;
			saveBtn.y = menuBtn.y + saveBtn.height + saveBtn.offset;
			addChild(saveBtn);
		}
	}
}