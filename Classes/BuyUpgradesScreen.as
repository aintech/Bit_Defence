package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;

	public class BuyUpgradesScreen extends MovieClip
	{
		public var matrix:Array;
		public var buttonsArray:Array = [];
		public var descript:MovieClip;
		public var targetBtn:*;
		
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
			else if(Variables.SYMBOLS >= Variables.UPGRADE_GUN_III_SYMBOLS_COST) gun_III.canBeAchieved = true;
			if(Variables.GUN_LEVEL == 5) gun_V.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_GUN_V_SYMBOLS_COST) gun_V.canBeAchieved = true;
			
			if(Variables.SWARM_LEVEL >= 3) swarm_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_SWARM_III_SYMBOLS_COST) swarm_III.canBeAchieved = true;
			if(Variables.SWARM_LEVEL == 5) swarm_V.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_SWARM_V_SYMBOLS_COST) swarm_V.canBeAchieved = true;
			
			if(Variables.LAUNCHER_LEVEL >= 3) launcher_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_LAUNCHER_III_SYMBOLS_COST) launcher_III.canBeAchieved = true;
			if(Variables.LAUNCHER_LEVEL == 5) launcher_V.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_LAUNCHER_V_SYMBOLS_COST) launcher_V.canBeAchieved = true;
			
			if(Variables.FREEZE_LEVEL >= 3) freeze_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_FREEZE_III_SYMBOLS_COST) freeze_III.canBeAchieved = true;
			if(Variables.FREEZE_LEVEL == 5) freeze_V.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_FREEZE_V_SYMBOLS_COST) freeze_V.canBeAchieved = true;
			
			for each(var btn:MovieClip in buttonsArray)
			{
				if(btn.achieved == false && btn.canBeAchieved == false)
				{
					btn.filters = [new ColorMatrixFilter(matrix)];
				}
				else if(btn.achieved == false && btn.canBeAchieved == true)
				{
					btn.btnFrame.filters = [new ColorMatrixFilter(matrix)];
					btn.addEventListener(MouseEvent.CLICK, onClickBtn, false, 0, true);
					btn.mouseEnabled = true;
					btn.useHandCursor = true;
					CONTINIUM
				}
				btn.addEventListener(MouseEvent.MOUSE_OVER, overBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_OUT, outBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_MOVE, moveOnBtn, false, 0, true);
			}
			
			txtSymbols.text 		= "Symbols: " + String(Variables.SYMBOLS);
			
			descript = new UpgradeDescription();
			descript.visible = false;
			descript.mouseEnabled = false;
			addChild(descript);
		}
		
		private function overBtn(e:MouseEvent):void
		{
			descript.visible = true;
			if(e.currentTarget.canBeAchieved == true) e.currentTarget.filters = [new GlowFilter(0x00FF00, 1, 10, 10)];
		}
		
		private function outBtn(e:MouseEvent):void
		{
			descript.visible = false;
			if(e.currentTarget.canBeAchieved) e.currentTarget.filters = [];
		}
		
		private function moveOnBtn(e:MouseEvent):void
		{
			descript.x = e.stageX;
			descript.y = e.stageY;
			e.updateAfterEvent();
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