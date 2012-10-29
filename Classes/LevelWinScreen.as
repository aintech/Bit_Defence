package 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	public class LevelWinScreen extends MovieClip
	{
		private var winTimer:Timer;
		private var currLevel:int;
		private var addSymbols:int;
		
		public function LevelWinScreen(level:int)
		{
			currLevel = level;
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void
		{
			addSymbols = currLevel * 100;
			txtLevel.text = String(currLevel);
			txtSymbols.text = String(Variables.SYMBOLS);
			txtAddSymbols.text = " + " + addSymbols;
			
			winTimer = new Timer(2000, 1);
			winTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startAddingSymbols, false, 0, true);
			winTimer.start();
			addEventListener(MouseEvent.CLICK, startAddingSymbols, false, 0, true);
		}
		
		private function startAddingSymbols(e:Event = null):void
		{
			removeEventListener(MouseEvent.CLICK, startAddingSymbols);
			winTimer.stop();
			winTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, startAddingSymbols);
			
			winTimer = new Timer(10);
			winTimer.addEventListener(TimerEvent.TIMER, collectSymbols, false, 0, true);
			winTimer.start();
		}
		
		private function collectSymbols(e:TimerEvent):void
		{
			if(addSymbols <= 0)
			{
				winTimer.stop();
				winTimer.removeEventListener(TimerEvent.TIMER, collectSymbols);
				txtAddSymbols.text = "";
				addEventListener(MouseEvent.CLICK, closeScreen, false, 0, true);
			}
			else
			{
				addSymbols--;
				Variables.SYMBOLS++;
				txtSymbols.text = String(Variables.SYMBOLS);
				txtAddSymbols.text = " + " + addSymbols;
			}
		}
		
		private function closeScreen(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.CLICK, closeScreen);
			dispatchEvent(new CustomEvents(CustomEvents.CLOSE_LEVEL_WIN));
		}
	}
}