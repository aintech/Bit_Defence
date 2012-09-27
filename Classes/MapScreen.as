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
		
		public function MapScreen(openLevels:int)
		{
			mapLevel = openLevels;
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false ,0, true);
		}
		
		public function onAdd(e:Event):void
		{
			addEventListener(MouseEvent.CLICK, stageFocus, false, 0, true);
			
			blockFormat = new TextFormat("Digital-7", 60, 0xFFFFFF)
			
			blockName = new TextField();
			blockName.defaultTextFormat = blockFormat;
			blockName.autoSize = TextFieldAutoSize.CENTER;
			blockName.text = "DATA BLOCK - 01";
			blockName.selectable = false;
			blockName.x = Main.STAGE_WIDTH * .3 - blockName.width * .5;
			blockName.y = 20;
			blockName.filters = [new GlowFilter(0xFF0000)];
			addChild(blockName);
			
			optionsBtn = new Button("OPTIONS");
			optionsBtn.scaleX = optionsBtn.scaleY = .6;
			optionsBtn.x = Main.STAGE_WIDTH - optionsBtn.width - optionsBtn.offset;
			optionsBtn.y = optionsBtn.offset;
			optionsBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			addChild(optionsBtn);
			
			upgradesBtn = new Button("UPGRADES");
			upgradesBtn.scaleX = upgradesBtn.scaleY = .6;
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
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			e.stopPropagation();
			e.currentTarget.alpha = .7;
			e.currentTarget.scaleX = e.currentTarget.scaleY = 1;
		}
		
		public function onLevelClick(e:MouseEvent):void
		{
			choosedLevel = e.currentTarget.level;
			dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
		}
	}
}