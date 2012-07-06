package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;

	public class BuyUpgradesScreen extends MovieClip
	{
		public var matrix:Array;
		public var turretBtnArray:Array = [];
		public var numBtns:int			= 20;
		public var btnsInRow:int		= 5;
		
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
			CONTINIUM - сначала доделать иконки UpgradeBtn
			//turretBtnArray
			matrix = [
					  0.3086, 0.6094, 0.082, 0, 0,
					  0.3086, 0.6094, 0.082, 0, 0,
					  0.3086, 0.6094, 0.082, 0, 0,
					       0,	   0,	  0, 1, 0
					  ];
			
			/*gunLevel.mouseEnabled = false;
			swarmLevel.mouseEnabled = false;
			freezeLevel.mouseEnabled = false;
			launcherLevel.mouseEnabled = false;
			buttons.push(gunLevel, swarmLevel, freezeLevel, launcherLevel);
			
			gunLevel.text 			= "lvl "+ String(Variables.GUN_LEVEL);
			swarmLevel.text 		= "lvl "+ String(Variables.SWARM_LEVEL);
			freezeLevel.text 		= "lvl "+ String(Variables.FREEZE_LEVEL);
			launcherLevel.text 	= "lvl "+ String(Variables.LAUNCHER_LEVEL);
			txtSymbols.text 		= "Symbols: " + String(Variables.SYMBOLS);
			
			if(Variables.SYMBOLS >= Variables.UPGRADE_GUN_SYMBOLS_COST) gunBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
			else
			{
				gunBtn.filters = [new ColorMatrixFilter(matrix)];
				gunBtn.mouseEnabled = false;
			}
			if(Variables.SYMBOLS >= Variables.UPGRADE_SWARM_SYMBOLS_COST) swarmBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
			if(Variables.SYMBOLS >= Variables.UPGRADE_FREEZE_SYMBOLS_COST) freezeBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
			if(Variables.SYMBOLS >= Variables.UPGRADE_LAUNCHER_SYMBOLS_COST) launchBtn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);*/
		}
		
		private function onClickBtn(e:MouseEvent):void
		{
			/*switch(e.target.name)
			{
				case "gunBtn":
				break;
				
				case "swarmBtn":
				break;
				
				case "freezeBtn":
				break;
				
				case "launchBtn":
				break;
			}*/
			stage.focus = this;
		}
	}
}