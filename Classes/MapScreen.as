package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;

	public class MapScreen extends MovieClip
	{
		public var mapLevel:int;
		public var optionsBtn:SimpleButton;
		public var updatesBtn:SimpleButton;
		
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
			
			updatesBtn = new UpdatesBtn();
			updatesBtn.x = stage.stageWidth - optionsBtn.width - updatesBtn.width;
			updatesBtn.addEventListener(MouseEvent.CLICK, onClickUpdates, false, 0, true);
			addChild(updatesBtn);
			
			levelBtn_1.levelText.text = "1";
			levelBtn_2.levelText.text = "2";
			levelBtn_3.levelText.text = "3";
			levelBtn_4.levelText.text = "4";
			levelBtn_5.levelText.text = "5";
						
			switch(mapLevel)
			{
				case 1:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_2.gotoAndStop(4);
				levelBtn_3.gotoAndStop(4);
				levelBtn_4.gotoAndStop(4);
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 2:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_3.gotoAndStop(4);
				levelBtn_4.gotoAndStop(4);
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 3:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_3.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_4.gotoAndStop(4);
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 4:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_3.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_4.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 5:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_3.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_4.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				
				levelBtn_5.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_5.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_5.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				break;
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
			e.currentTarget.gotoAndStop(2);
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop(1);
		}
		
		public function onLevelClick(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case "levelBtn_1":
				mapLevel = 1;
				dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
				break;
				
				case "levelBtn_2":
				mapLevel = 2;
				dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
				break;
				
				case "levelBtn_3":
				mapLevel = 3;
				dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
				break;
				
				case "levelBtn_4":
				mapLevel = 4;
				dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
				break;
				
				case "levelBtn_5":
				mapLevel = 5;
				dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
				break;
			}
		}
	}
}