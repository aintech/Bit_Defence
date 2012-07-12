package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;

	public class BuyUpgradesScreen extends MovieClip
	{
		public var grayMatrix:Array;
		public var buttonsArray:Array = [];
		public var descript:MovieClip;
		
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
			txtSymbols.text = "Symbols: " + String(Variables.SYMBOLS);
			grayMatrix = [
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
			
			criticalX3.gotoAndStop("criticalX3");
			critChance.gotoAndStop("critChance");
			
			descript = new UpgradeDescription();
			descript.visible = false;
			descript.mouseEnabled = false;
			addChild(descript);
			
			buttonsArray.push(gun_III, 		criticalX3, 	gun_V, 		critChance, 	additionalTool,
							  swarm_III, 					swarm_V,
							  launcher_III, 				launcher_V,
							  freeze_III, 					freeze_V);
			checkBtns();
		}
		
		private function checkBtns():void
		{
			//Gun branch
			if(Variables.GUN_LEVEL >= 3) gun_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_III) gun_III.canBeAchieved = true;
			if(Variables.GUN_CRIT_DAMAGE_MULTIPLY == 3) criticalX3.achieved = true;
			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_X3) && (gun_III.achieved)) criticalX3.canBeAchieved = true;
			if(Variables.GUN_LEVEL == 5) gun_V.achieved = true;
			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_V) && criticalX3.achieved) gun_V.canBeAchieved = true;
			if(Variables.GUN_CRIT_CHANCE == 20) critChance.achieved = true;
			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_CHANCE) && (gun_V.achieved)) critChance.canBeAchieved = true;
			CONTINIUM --> additional tool (gun)
			
			//Swarm branch
			if(Variables.SWARM_LEVEL >= 3) swarm_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_SWARM_III) swarm_III.canBeAchieved = true;
			if(Variables.SWARM_LEVEL == 5) swarm_V.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_SWARM_V) swarm_V.canBeAchieved = true;
			
			//Launcher branch
			if(Variables.LAUNCHER_LEVEL >= 3) launcher_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_LAUNCHER_III) launcher_III.canBeAchieved = true;
			if(Variables.LAUNCHER_LEVEL == 5) launcher_V.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_LAUNCHER_V) launcher_V.canBeAchieved = true;
			
			//Freeze branch
			if(Variables.FREEZE_LEVEL >= 3) freeze_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_FREEZE_III) freeze_III.canBeAchieved = true;
			if(Variables.FREEZE_LEVEL == 5) freeze_V.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_FREEZE_V) freeze_V.canBeAchieved = true;
			
			
			for each(var btn:UpgradeBtn in buttonsArray)
			{
				if(btn.hasEventListener(MouseEvent.MOUSE_DOWN)) btn.removeEventListener(MouseEvent.MOUSE_DOWN, onPressBtn);
				if(btn.hasEventListener(MouseEvent.MOUSE_OVER)) btn.removeEventListener(MouseEvent.MOUSE_OVER, overBtn);
				if(btn.hasEventListener(MouseEvent.MOUSE_OUT )) btn.removeEventListener(MouseEvent.MOUSE_OUT, outBtn);
				if(btn.hasEventListener(MouseEvent.MOUSE_MOVE)) btn.removeEventListener(MouseEvent.MOUSE_MOVE, moveOnBtn);
				
				if(btn.achieved == false && btn.canBeAchieved == false)	btn.filters = [new ColorMatrixFilter(grayMatrix)];
				else if(btn.achieved == false && btn.canBeAchieved == true)
				{
					btn.btnFrame.filters = [new ColorMatrixFilter(grayMatrix)];
					btn.addEventListener(MouseEvent.MOUSE_DOWN, onPressBtn, false, 0, true);
					btn.buttonMode = true;
					//CONTINIUM
				}
				btn.addEventListener(MouseEvent.MOUSE_OVER, overBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_OUT, outBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_MOVE, moveOnBtn, false, 0, true);
			}
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
		
		private function onPressBtn(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "gun_III":
				break;
				
				case "gun_V":
				break;
				
				case "criticalX3":
				break;
				
				case "critChance":
				break;
				
				case "swarm_III":
				break;
				
				case "swarm_V":
				break;
				
				case "freeze_III":
				break;
				
				case "freeze_V":
				break;
				
				case "launcher_III":
				break;
				
				case "launcher_V":
				break;
			}
			checkBtns();
			stage.focus = this;
		}
	}
}