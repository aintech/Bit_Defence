package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.filters.DropShadowFilter;
	import flash.display.SimpleButton;

	public class MapScreen extends MovieClip
	{
		public var numLevels:int = 10;
		public var levelData:LevelData;
		public var mapLevel:int;
		public var optionsBtn:SimpleButton;
		public var upBtn:SimpleButton;
		public var levelBtn:LevelBtn;
		public var choosedLevel:int;
		
		public function MapScreen(openLevels:int)
		{
			mapLevel = openLevels;
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false ,0, true);
		}
		
		public function onAdd(e:Event):void
		{
			addEventListener(MouseEvent.CLICK, stageFocus, false, 0, true);
			optionsBtn = new OptionsGear();
			optionsBtn.x = stage.stageWidth - optionsBtn.width;
			optionsBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			addChild(optionsBtn);
			
			upBtn = new GotoUpgradesBtn();
			upBtn.x = stage.stageWidth - optionsBtn.width - upBtn.width;
			upBtn.addEventListener(MouseEvent.CLICK, onClickUpdates, false, 0, true);
			addChild(upBtn);
			
			for(var i:int = 1; i <= numLevels; i++)
			{
				levelBtn = new LevelBtn(i);
				levelBtn.x = Main.STAGE_WIDTH * .3;
				levelBtn.y = 520 - i * 40;
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
			dispatchEvent(new CustomEvents(CustomEvents.SHOW_UPDATES));
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