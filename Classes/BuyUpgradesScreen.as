package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BuyUpgradesScreen extends MovieClip
	{
		public function BuyUpgradesScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			gunLevel.mouseEnabled = false;
			swarmLevel.mouseEnabled = false;
			freezeLevel.mouseEnabled = false;
			launcherLevel.mouseEnabled = false;
			
			gunLevel.text 			= "lvl "+ String(Variables.GUN_LEVEL);
			swarmLevel.text 		= "lvl "+ String(Variables.SWARM_LEVEL);
			freezeLevel.text 		= "lvl "+ String(Variables.FREEZE_LEVEL);
			launcherLevel.text 	= "lvl "+ String(Variables.LAUNCHER_LEVEL);
			txtSymbols.text 		= "Symbols: " + String(Variables.SYMBOLS);
			
			gunBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
			swarmBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
			freezeBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
			launchBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
		}
		
		private function onClickBtn(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "gunBtn":
				break;
				
				case "swarmBtn":
				break;
				
				case "freezeBtn":
				break;
				
				case "launchBtn":
				break;
			}
			stage.focus = this;
		}
	}
}