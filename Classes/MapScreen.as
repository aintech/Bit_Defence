package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;

	public class MapScreen extends MovieClip
	{
		public var numLevels:int = 10;
		public var mapLevel:int;
		public var optionsBtn:Button;
		public var upgradesBtn:Button;
		public var levelBtn:LevelBtn;
		public var choosedLevel:int;
		
		private var blockName:TextField;
		private var blockFormat:TextFormat;
		
		private var saveTimer:Timer = new Timer(50);
		private var saveText:Button = new Button("progress saved...");
		
		private var levelDescript:LevelDescription;
		
		public function MapScreen(openLevels:int)
		{
			mapLevel = openLevels;
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false ,0, true);
		}
		
		public function onAdd(e:Event):void
		{
			var Bg:Sprite = new Sprite;
			Bg.graphics.beginFill(0x000000);
			Bg.graphics.drawRect(0, 0, Main.STAGE_WIDTH, Main.STAGE_HEIGHT);
			Bg.graphics.endFill();
			addChildAt(Bg, 0);
			
			addEventListener(MouseEvent.CLICK, stageFocus, false, 0, true);
			
			blockFormat = new TextFormat("Digital-7", 60, 0xFFFFFF)
			
			blockName = new TextField();
			blockName.defaultTextFormat = blockFormat;
			blockName.embedFonts = true;
			blockName.autoSize = TextFieldAutoSize.CENTER;
			blockName.text = "DATA BLOCK - 01";
			blockName.selectable = false;
			blockName.x = Main.STAGE_WIDTH * .3 - blockName.width * .5;
			blockName.y = 20;
			blockName.filters = [new GlowFilter(0xFF0000)];
			addChild(blockName);
			
			optionsBtn = new Button("OPTIONS", true);
			optionsBtn.x = Main.STAGE_WIDTH - optionsBtn.width - optionsBtn.offset;
			optionsBtn.y = optionsBtn.offset;
			optionsBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			addChild(optionsBtn);
			
			upgradesBtn = new Button("UPGRADES", true);
			upgradesBtn.x = optionsBtn.x - upgradesBtn.width - upgradesBtn.offset;
			upgradesBtn.y = upgradesBtn.offset;
			upgradesBtn.addEventListener(MouseEvent.CLICK, onClickUpdates, false, 0, true);
			addChild(upgradesBtn);
			
			for(var i:int = 1; i <= numLevels; i++)
			{
				levelBtn = new LevelBtn(i);
				levelBtn.x = Main.STAGE_WIDTH * .3;
				levelBtn.y = 550 - i * 40;
				if(mapLevel >= i)
				{
					levelBtn.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
					levelBtn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
					levelBtn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
					levelBtn.gotoAndStop(i+1);
					levelBtn.buttonMode = true;
					levelBtn.mouseChildren = true;
					levelBtn.mouseEnabled = true;
				}
				else levelBtn.gotoAndStop("level_Closed");
				
				levelBtn.alpha = .7;
				addChild(levelBtn);
				
				levelBtn.filters = [new DropShadowFilter(4, 0)];
			}
			
			saveText.disableButton();
			saveText.scaleX = saveText.scaleY = .4;
			saveText.x = Main.STAGE_WIDTH - saveText.width * 1.5 - 5;
			saveText.y = Main.STAGE_HEIGHT - saveText.height - 5;
			
			levelDescript = new LevelDescription();
			levelDescript.x = 550;
			levelDescript.y = 130;
			addChild(levelDescript);
			
			levelDescript.txtBlockNumber.text = "";
			levelDescript.lvlRoad.visible = false;
			levelDescript.lvlBG.visible = false;
			levelDescript.txtLevelDescription.text = "";
		}
		
		private function stageFocus(e:MouseEvent):void
		{
			if(stage) stage.focus = this;
		}
		
		private function onClickUpdates(e:MouseEvent):void
		{
			dispatchEvent(new CustomEvents(CustomEvents.SHOW_UPGRADES));
		}
		
		private function onClickOptions(e:MouseEvent):void
		{
			dispatchEvent(new CustomEvents(CustomEvents.SHOW_OPTIONS));
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			e.stopPropagation();
			e.currentTarget.alpha = 1;
			e.currentTarget.scaleX = e.currentTarget.scaleY = 1.05;
			
			if(e.currentTarget.level < 10) levelDescript.txtBlockNumber.text = "BLOCK 0" + e.currentTarget.level;
			else levelDescript.txtBlockNumber.text = "BLOCK " + e.currentTarget.level;
			levelDescript.txtBlockNumber.filters = [new GlowFilter(LevelData.levelColors(e.currentTarget.level))];
			levelDescript.lvlRoad.visible = true;
			levelDescript.lvlRoad.gotoAndStop(e.currentTarget.level);
			levelDescript.lvlBG.visible = true;
			levelDescript.lvlBG.gotoAndStop(e.currentTarget.level);
			levelDescript.BG.filters = [new GlowFilter(LevelData.levelColors(e.currentTarget.level))];
			
			switch(e.currentTarget.level)
			{
				case 1:
					levelDescript.txtLevelDescription.text = "first line of defence";
				break;
				
				case 2:
					levelDescript.txtLevelDescription.text = "second line of defence";
				break;
				
				case 3:
					levelDescript.txtLevelDescription.text = "third line of defence";
				break;
				
				case 4:
					levelDescript.txtLevelDescription.text = "fourth line of defence";
				break;
				
				case 5:
					levelDescript.txtLevelDescription.text = "fifth line of defence";
				break;
				
				case 6:
					levelDescript.txtLevelDescription.text = "sixth line of defence";
				break;
				
				case 7:
					levelDescript.txtLevelDescription.text = "seventh line of defence";
				break;
				
				case 8:
					levelDescript.txtLevelDescription.text = "eighth line of defence";
				break;
				
				case 9:
					levelDescript.txtLevelDescription.text = "ninth line of defence";
				break;
				
				case 10:
					levelDescript.txtLevelDescription.text = "tenth line of defence";
				break;
			}
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			e.stopPropagation();
			e.currentTarget.alpha = .7;
			e.currentTarget.scaleX = e.currentTarget.scaleY = 1;
			
			levelDescript.txtBlockNumber.text = "";
			levelDescript.lvlRoad.visible = false;
			levelDescript.lvlBG.visible = false;
			levelDescript.txtLevelDescription.text = "";
			levelDescript.BG.filters = [];
		}
		
		public function onLevelClick(e:MouseEvent):void
		{
			choosedLevel = e.currentTarget.level;
			dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
		}
		
		public function saveGameMessage():void
		{
			saveTimer.stop();
			saveTimer.reset();
			if(saveTimer.hasEventListener(TimerEvent.TIMER)) saveTimer.removeEventListener(TimerEvent.TIMER, saveTick);
			saveText.alpha = 1;
			
			addChild(saveText);
			saveTimer.start();
			saveTimer.addEventListener(TimerEvent.TIMER, saveTick, false, 0, true);
		}
		
		private function saveTick(e:TimerEvent):void
		{
			if(saveTimer.currentCount >= 40) saveText.alpha -= .05;
			if(saveText.alpha <= 0)
			{
				saveTimer.stop();
				saveTimer.reset();
				saveTimer.removeEventListener(TimerEvent.TIMER, saveTick);
				saveText.alpha = 1;
				removeChild(saveText);
			}
		}
	}
}