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
		public var upBtn:SimpleButton;
		
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
			upBtn.x = 15;//stage.stageWidth - optionsBtn.width - upBtn.width;
			upBtn.y = 15;
			upBtn.addEventListener(MouseEvent.CLICK, onClickUpdates, false, 0, true);
			addChild(upBtn);
			
			levelBtn_1.levelTxt.text = "1";
			levelBtn_2.levelTxt.text = "2";
			levelBtn_3.levelTxt.text = "3";
			levelBtn_4.levelTxt.text = "4";
			levelBtn_5.levelTxt.text = "5";
			
			levelBtn_1.levelTxt.mouseEnabled = false;
			levelBtn_2.levelTxt.mouseEnabled = false;
			levelBtn_3.levelTxt.mouseEnabled = false;
			levelBtn_4.levelTxt.mouseEnabled = false;
			levelBtn_5.levelTxt.mouseEnabled = false;
									
			switch(mapLevel)
			{
				case 1:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_1.buttonMode = true;
				
				levelBtn_2.gotoAndStop(4);
				levelBtn_3.gotoAndStop(4);
				levelBtn_4.gotoAndStop(4);
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 2:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_1.buttonMode = true;
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_2.buttonMode = true;
				
				levelBtn_3.gotoAndStop(4);
				levelBtn_4.gotoAndStop(4);
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 3:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_1.buttonMode = true;
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_2.buttonMode = true;
				
				levelBtn_3.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_3.buttonMode = true;
				
				levelBtn_4.gotoAndStop(4);
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 4:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_1.buttonMode = true;
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_2.buttonMode = true;
				
				levelBtn_3.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_3.buttonMode = true;
				
				levelBtn_4.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_4.buttonMode = true;
				
				levelBtn_5.gotoAndStop(4);
				break;
				
				case 5:
				levelBtn_1.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_1.buttonMode = true;
				
				levelBtn_2.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_2.buttonMode = true;
				
				levelBtn_3.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_3.buttonMode = true;
				
				levelBtn_4.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_4.buttonMode = true;
				
				levelBtn_5.addEventListener(MouseEvent.CLICK, onLevelClick, false, 0, true);
				levelBtn_5.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
				levelBtn_5.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
				levelBtn_5.buttonMode = true;
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
				break;
				
				case "levelBtn_2":
				mapLevel = 2;
				break;
				
				case "levelBtn_3":
				mapLevel = 3;
				break;
				
				case "levelBtn_4":
				mapLevel = 4;
				break;
				
				case "levelBtn_5":
				mapLevel = 5;
				break;
			}
			dispatchEvent(new CustomEvents(CustomEvents.NEW_LEVEL));
		}
	}
}