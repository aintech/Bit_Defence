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
									  0,		 0,	  0, 1, 0
					  			];
						
			gun_III.gotoAndStop("Gun_III");
			gun_V.gotoAndStop("Gun_V");
			criticalX3.gotoAndStop("criticalX3");
			critChance.gotoAndStop("critChance");
			additionalTool_Gun.gotoAndStop("additionalTool");
			
			swarm_III.gotoAndStop("Swarm_III");
			launcher_III.gotoAndStop("Launcher_III");
			freeze_III.gotoAndStop("Freeze_III");
			
			swarm_V.gotoAndStop("Swarm_V");
			launcher_V.gotoAndStop("Launcher_V");
			freeze_V.gotoAndStop("Freeze_V");
			
			
			descript = new UpgradeDescription();
			descript.visible = false;
			descript.mouseEnabled = false;
			addChild(descript);
			
			buttonsArray.push(gun_III, 		criticalX3, 	gun_V, 		critChance, 	additionalTool_Gun,
							  		swarm_III, 							swarm_V,
							  		launcher_III, 						launcher_V,
							  		freeze_III, 						freeze_V);
			checkBtns();
		}
		
		private function checkBtns():void
		{
			//Gun branch
			if(Variables.GUN_LEVEL >= 3) gun_III.achieved = true;
			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_III) gun_III.canBeAchieved = true;
			if(Variables.GUN_CRIT_DAMAGE_MULTIPLY == 3) criticalX3.achieved = true;
			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_X3) && gun_III.achieved) criticalX3.canBeAchieved = true;
			if(Variables.GUN_LEVEL == 5) gun_V.achieved = true;
			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_V) && criticalX3.achieved) gun_V.canBeAchieved = true;
			if(Variables.GUN_CRIT_CHANCE == 20) critChance.achieved = true;
			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_CHANCE) && gun_V.achieved) critChance.canBeAchieved = true;
			if(Variables.ADDITIONAL_TOOL_GUN_ACHIEVED) additionalTool_Gun.achieved = true;
			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_ADD_TOOL) && critChance.achieved) additionalTool_Gun.canBeAchieved = true;
						
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
				
				btn.filters = [];
				btn.btnFrame.filters = [];
				btn.buttonMode = false;
				
				if(btn.mouseIsOver && btn.canBeAchieved) btn.filters = [new GlowFilter(0x00FF00, 1, 10, 10)];
				if(btn.achieved == false && btn.canBeAchieved == false)	btn.filters = [new ColorMatrixFilter(grayMatrix)];
				else if(btn.achieved == false && btn.canBeAchieved == true)
				{
					btn.btnFrame.filters = [new ColorMatrixFilter(grayMatrix)];
					btn.addEventListener(MouseEvent.MOUSE_DOWN, onPressBtn, false, 0, true);
					btn.buttonMode = true;
				}
				btn.addEventListener(MouseEvent.MOUSE_OVER, overBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_OUT, outBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_MOVE, moveOnBtn, false, 0, true);
			}
			
			(criticalX3.achieved)? 				gunLadder_I.gotoAndStop(2): gunLadder_I.gotoAndStop(1);
			(gun_V.achieved)? 					gunLadder_II.gotoAndStop(2): gunLadder_II.gotoAndStop(1);
			(critChance.achieved)?				gunLadder_III.gotoAndStop(2): gunLadder_III.gotoAndStop(1);
			(additionalTool_Gun.achieved)?	gunLadder_IV.gotoAndStop(2): gunLadder_IV.gotoAndStop(1);
		}
		
		private function overBtn(e:MouseEvent):void
		{
			descript.visible = true;
			if(e.currentTarget.canBeAchieved == true) e.currentTarget.filters = [new GlowFilter(0x00FF00, 1, 10, 10)];
			e.currentTarget.mouseIsOver = true;
		}
		
		private function outBtn(e:MouseEvent):void
		{
			descript.visible = false;
			if(e.currentTarget.canBeAchieved) e.currentTarget.filters = [];
			e.currentTarget.mouseIsOver = false;
		}
		
		private function moveOnBtn(e:MouseEvent):void
		{
			descript.x = e.stageX;
			descript.y = e.stageY;
			e.updateAfterEvent();
		}
		
		private function onPressBtn(e:MouseEvent):void
		{
			CONTINIUM правим UpgradeBtn в BuyUpgradeScreen
			switch(e.currentTarget.name)
			{
				case "gun_III":
					if(Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_III)
					{
						Variables.GUN_LEVEL = 3;
						Variables.SYMBOLS -= Variables.UPGRADE_COST_GUN_III;
						gun_III.achieved = true;
						gun_III.canBeAchieved = false;
					}
					else trace("low Symbols");
				break;
				
				case "gun_V":
					if(Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_V)
					{
						Variables.GUN_LEVEL = 5;
						Variables.SYMBOLS -= Variables.UPGRADE_COST_GUN_V;
						gun_V.achieved = true;
						gun_V.canBeAchieved = false;
					}
					else trace("low Symbols");
				break;
				
				case "criticalX3":
					if(Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_X3)
					{
						Variables.GUN_CRIT_DAMAGE_MULTIPLY = 3;
						Variables.SYMBOLS -= Variables.UPGRADE_COST_CRIT_X3;
						criticalX3.achieved = true;
						criticalX3.canBeAchieved = false;
					}
					else trace("low Symbols");
				break;
				
				case "critChance":
					if(Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_CHANCE)
					{
						Variables.GUN_CRIT_CHANCE = 20;
						Variables.SYMBOLS -= Variables.UPGRADE_COST_CRIT_CHANCE;
						critChance.achieved = true;
						critChance.canBeAchieved = false;
					}
					else trace("low Symbols");
				break;
				
				case "additionalTool_Gun":
					if(Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_ADD_TOOL)
					{
						Variables.ADDITIONAL_TOOL_GUN_ACHIEVED = true;
						Variables.SYMBOLS -= Variables.UPGRADE_COST_GUN_ADD_TOOL;
						additionalTool_Gun.achieved = true;
						additionalTool_Gun.canBeAchieved = false;
					}
					else trace("low Symbols");
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
			txtSymbols.text = "Symbols: " + String(Variables.SYMBOLS);
			stage.focus = this;
		}
	}
}