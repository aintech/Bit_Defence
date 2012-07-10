package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.display.MovieClip;

	public class BuyUpgradesScreen extends MovieClip
	{
		public var matrix:Array;
		public var buttonsArray:Array = [];
		
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
			//CONTINIUM - нужна четкая идея апдейтов...//////////////////////////////////////////////////////////////////////////////
			//turretBtnArray
			matrix = [
					  0.3086, 0.6094, 0.082, 0, 0,
					  0.3086, 0.6094, 0.082, 0, 0,
					  0.3086, 0.6094, 0.082, 0, 0,
					       0,	   0,	  0, 1, 0
					  ];
						
			gun_III.gotoAndStop("Gun_III");
			swarm_III.gotoAndStop("Swarm_III");
			launcher_III.gotoAndStop("Launcher_III");
			freeze_III.gotoAndStop("Freeze_III");
			
			gun_V.gotoAndStop("Gun_V");
			swarm_V.gotoAndStop("Swarm_V");
			launcher_V.gotoAndStop("Launcher_V");
			freeze_V.gotoAndStop("Freeze_V");
			
			buttonsArray.push(gun_III, swarm_III, launcher_III, freeze_III, gun_V, swarm_V, launcher_V, freeze_V);
			
			if(Variables.GUN_LEVEL >= 3) gun_III.achieved = true;
			if(Variables.GUN_LEVEL == 5) gun_V.achieved = true;
			
			if(Variables.SWARM_LEVEL >= 3) swarm_III.achieved = true;
			if(Variables.SWARM_LEVEL == 5) swarm_V.achieved = true;
			
			if(Variables.LAUNCHER_LEVEL >= 3) launcher_III.achieved = true;
			if(Variables.LAUNCHER_LEVEL == 5) launcher_V.achieved = true;
			
			if(Variables.FREEZE_LEVEL >= 3) freeze_III.achieved = true;
			if(Variables.FREEZE_LEVEL == 5) freeze_V.achieved = true;
			
			for each(var btn:MovieClip in buttonsArray)
			{
				if(btn.achieved == false)
				{
					btn.filters = [new ColorMatrixFilter(matrix)];
					btn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
				}
				btn.addEventListener(MouseEvent.MOUSE_OVER, overBtn, false, 0, true);
			}
			
			txtSymbols.text 		= "Symbols: " + String(Variables.SYMBOLS);
			
			/*gunLevel.mouseEnabled = false;
			swarmLevel.mouseEnabled = false;
			freezeLevel.mouseEnabled = false;
			launcherLevel.mouseEnabled = false;
			buttons.push(gunLevel, swarmLevel, freezeLevel, launcherLevel);
			
			gunLevel.text 			= "lvl "+ String(Variables.GUN_LEVEL);
			swarmLevel.text 		= "lvl "+ String(Variables.SWARM_LEVEL);
			freezeLevel.text 		= "lvl "+ String(Variables.FREEZE_LEVEL);
			launcherLevel.text 	= "lvl "+ String(Variables.LAUNCHER_LEVEL);
			
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
		
		private function overBtn(e:MouseEvent):void
		{
			
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