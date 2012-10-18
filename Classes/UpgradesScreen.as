package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;

	public class UpgradesScreen extends MovieClip
	{
		public var buttonsArray:Array = [];
		public var linksArray:Array	= [];
		public var descript:MovieClip;
		public var pressedUpgrades:Array = [];
		
		private var undoBtn:Button;
		private var doneBtn:Button;
		
		
		private const gun_III_descript:String					= "  you can upgrade your gun up to level 3";
		private const critical_X4_descript:String				= "  if gun perfoming critical attack, it's damage x4";
		private const gun_V_descript:String						= "  you can upgrade your gun up to level 5";
		private const crit_chance_descript:String				= "  increases chance of critical by 10%";
		private const additional_tools_descript:String			= "  give +2 Special tools";
		private const acc_damage_descript:String				= "  each hit on single target increase damage on this target";
		private const gun_mastered_descript:String				= "  gun installation starts from level 3";
		
		private const swarm_III_descript:String					= "  you can upgrade your swarm up to level 3";
		private const wide_splash_descript:String				= "  if swarm perfoming splash attack, it's radius x1,5 wider";
		private const swarm_V_descript:String					= "  you can upgrade your swarm up to level 3";
		private const splash_chance_descript:String				= "  increases chance of splash by 10%";
		private const more_symbols_descript:String				= "  more Symbols falling from enemies";
		private const bomb_cascade_descript:String				= "  some rockets perfoming bombs with splash damage";
		private const swarm_mastered_descript:String			= "  swarm installation starts from level 3";
		
		private const launcher_III_descript:String				= "  you can upgrade your launcher up to level 3";
		private const poison_damage_descript:String				= "  poison damage is x1,5 greater";
		private const launcher_V_descript:String				= "  you can upgrade your launcher up to level 3";
		private const poison_chance_descript:String				= "  increases chance of poison by 10%";
		private const memory_chance_descript:String				= "  enemies drop memory more often";
		private const poison_cloud_descript:String				= "  poison cloud stays on attacking zone";
		private const launcher_mastered_descript:String			= "  launcher installation starts from level 3";
		
		private const freeze_III_descript:String				= "  you can upgrade your freeze up to level 3";
		private const longer_stun_descript:String				= "  if freeze perform stun attack, it's x1,5 longer";
		private const freeze_V_descript:String					= "  you can upgrade your freeze up to level 3";
		private const stun_chance_descript:String				= "  increases chance of stun by 10%";
		private const hack_protect_descript:String				= "  enemies have 20% less chance for hacking system";
		private const multy_stun_descript:String				= "  stun multiple enemies";
		private const freeze_mastered_descript:String			= "  freeze installation starts from level 3";
		
		public function UpgradesScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			doneBtn = new Button("DONE");
			doneBtn.scaleX = doneBtn.scaleY = .6;
			doneBtn.x = Main.STAGE_WIDTH - doneBtn.width - doneBtn.offset;
			doneBtn.y = doneBtn.offset;
			doneBtn.addEventListener(MouseEvent.CLICK, closeUpgrades, false, 0, true);
			addChild(doneBtn);
			
			undoBtn = new Button("UNDO");
			undoBtn.scaleX = undoBtn.scaleY = .6;
			undoBtn.x = doneBtn.x - undoBtn.width - undoBtn.offset;
			undoBtn.y = undoBtn.offset;
			undoBtn.addEventListener(MouseEvent.CLICK, undoChanges, false, 0, true);
			addChild(undoBtn);
			
			txtSymbols.text = "Symbols: " + String(Variables.SYMBOLS);	
			
			descript = new UpgradeDescription();
			descript.visible = false;
			descript.mouseEnabled = false;
			descript.gotoAndStop("top_right");
			addChild(descript);
			
			buttonsArray.push(gun_III, 		criticalX4, 	gun_V, 		critChance, 	additionalTools, 	accumulateDamage,		gunMastered,
							  swarm_III, 		wideSplash,		swarm_V,		splashChance,	moreSymbols,		bombCascade,	swarmMastered,
							  launcher_III, 	poisonDamage,	launcher_V,	poisonChance,	memoryChance,		poisonCloud,	launcherMastered,
							  freeze_III, 	longerStun,		freeze_V,	stunChance,		hackProtect,		multyStun,		freezeMastered);
			
			
			linksArray.push(gun_III_link, 		criticalX4_link, 	gun_V_link, 		critChance_link, 	additionalTools_link, 	accumulateDamage_link,		gunMastered_link,
							  swarm_III_link, 		wideSplash_link,		swarm_V_link,		splashChance_link,	moreSymbols_link,		bombCascade_link,	swarmMastered_link,
							  launcher_III_link, 	poisonDamage_link,	launcher_V_link,	poisonChance_link,	memoryChance_link,		poisonCloud_link,	launcherMastered_link,
							  freeze_III_link, 	longerStun_link,		freeze_V_link,	stunChance_link,		hackProtect_link,		multyStun_link,		freezeMastered_link);
		
			for(var i:int = 0; i < buttonsArray.length; i++)
			{
				var btn:MovieClip = buttonsArray[i];
				var n:String = btn.name;
				btn.gotoAndStop(n);
				for(var l:int = 0; l < linksArray.length; l++)
				{
					var link:MovieClip = linksArray[l];
					var ln:String = link.name;
					if(ln == String(n) + "_link")
					{
						if(btn.achieved) link.gotoAndStop(2);
						else link.gotoAndStop(1);
					}
				}
			}
			
			checkBtns();
		}
		
		private function checkBtns():void
		{
			//Gun branch
			if(Variables.UPGRADE_GUN_III) gun_III.achieved = true;						else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_III) gun_III.canBeAchieved = true;												else gun_III.canBeAchieved = false;
			if(Variables.UPGRADE_CRITICAL_X4) criticalX4.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_X4) && gun_III.achieved) criticalX4.canBeAchieved = true;						else criticalX4.canBeAchieved = false;
			if(Variables.UPGRADE_GUN_V) gun_V.achieved = true;							else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_V) && criticalX4.achieved) gun_V.canBeAchieved = true;							else gun_V.canBeAchieved = false;
			if(Variables.UPGRADE_CRIT_CHANCE) critChance.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_CRIT_CHANCE) && gun_V.achieved) critChance.canBeAchieved = true;					else critChance.canBeAchieved = false;
			if(Variables.UPGRADE_ADDITIONAL_TOOLS) additionalTools.achieved = true;		else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_ADD_TOOLS) && critChance.achieved) additionalTools.canBeAchieved = true;			else additionalTools.canBeAchieved = false;
			if(Variables.UPGRADE_ACC_DAMAGE) accumulateDamage.achieved = true;			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_ACC_DAM) && additionalTools.achieved) accumulateDamage.canBeAchieved = true;		else accumulateDamage.canBeAchieved = false;
			if(Variables.UPGRADE_GUN_MASTERED) gunMastered.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_GUN_MASTER) && accumulateDamage.achieved) gunMastered.canBeAchieved = true;		else gunMastered.canBeAchieved = false;
						
			//Swarm branch
			if(Variables.UPGRADE_SWARM_III) swarm_III.achieved = true;					else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_SWARM_III) swarm_III.canBeAchieved = true;											else swarm_III.canBeAchieved = false;
			if(Variables.UPGRADE_WIDE_SPLASH) wideSplash.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_WIDE_SPLASH) && swarm_III.achieved) wideSplash.canBeAchieved = true;				else wideSplash.canBeAchieved = false;
			if(Variables.UPGRADE_SWARM_V) swarm_V.achieved = true;						else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_SWARM_V) && wideSplash.achieved) swarm_V.canBeAchieved = true;						else swarm_V.canBeAchieved = false;
			if(Variables.UPGRADE_SPLASH_CHANCE) splashChance.achieved = true;			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_SPLASH_CHANCE) && swarm_V.achieved) splashChance.canBeAchieved = true;				else splashChance.canBeAchieved = false;
			if(Variables.UPGRADE_MORE_SYMBOLS) moreSymbols.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_MORE_SYMBOLS) && splashChance.achieved) moreSymbols.canBeAchieved = true;			else moreSymbols.canBeAchieved = false;
			if(Variables.UPGRADE_BOMB_CASCADE) bombCascade.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_BOMB_CASCADE) && moreSymbols.achieved) bombCascade.canBeAchieved = true;			else bombCascade.canBeAchieved = false;
			if(Variables.UPGRADE_SWARM_MASTERED) swarmMastered.achieved = true;			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_SWARM_MASTER) && bombCascade.achieved) swarmMastered.canBeAchieved = true;			else swarmMastered.canBeAchieved = false;
			
			//Launcher branch
			if(Variables.UPGRADE_LAUNCHER_III) launcher_III.achieved = true;			else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_LAUNCHER_III) launcher_III.canBeAchieved = true;									else launcher_III.canBeAchieved = false;
			if(Variables.UPGRADE_POISON_DAMAGE) poisonDamage.achieved = true;			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_POISON_DAMAGE) && launcher_III.achieved) poisonDamage.canBeAchieved = true;		else poisonDamage.canBeAchieved = false;
			if(Variables.UPGRADE_LAUNCHER_V) launcher_V.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_LAUNCHER_V) && poisonDamage.achieved) launcher_V.canBeAchieved = true;				else launcher_V.canBeAchieved = false;
			if(Variables.UPGRADE_POISON_CHANCE) poisonChance.achieved = true;			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_POISON_CHANCE) && launcher_V.achieved) poisonChance.canBeAchieved = true;			else poisonChance.canBeAchieved = false;
			if(Variables.UPGRADE_MEMORY_CHANCE) memoryChance.achieved = true;			else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_MEMORY_CHANCE) && poisonChance.achieved) memoryChance.canBeAchieved = true;		else memoryChance.canBeAchieved = false;
			if(Variables.UPGRADE_POISON_CLOUD) poisonCloud.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_POISON_CLOUD) && memoryChance.achieved) poisonCloud.canBeAchieved = true;			else poisonCloud.canBeAchieved = false;
			if(Variables.UPGRADE_LAUNCHER_MASTERED) launcherMastered.achieved = true;	else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_LAUNCHER_MASTER) && poisonCloud.achieved) launcherMastered.canBeAchieved = true;	else launcherMastered.canBeAchieved = false;
			
			//Freeze branch
			if(Variables.UPGRADE_FREEZE_III) freeze_III.achieved = true;				else if(Variables.SYMBOLS >= Variables.UPGRADE_COST_FREEZE_III) freeze_III.canBeAchieved = true;										else freeze_III.canBeAchieved = false;
			if(Variables.UPGRADE_LONGER_STUN) longerStun.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_LONGER_STUN) && freeze_III.achieved) longerStun.canBeAchieved = true;				else longerStun.canBeAchieved = false;
			if(Variables.UPGRADE_FREEZE_V) freeze_V.achieved = true;					else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_FREEZE_V) && longerStun.achieved) freeze_V.canBeAchieved = true;					else freeze_V.canBeAchieved = false;
			if(Variables.UPGRADE_STUN_CHANCE) stunChance.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_STUN_CHANCE) && freeze_V.achieved) stunChance.canBeAchieved = true;				else stunChance.canBeAchieved = false;
			if(Variables.UPGRADE_HACK_PROTECT) hackProtect.achieved = true;				else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_HACK_PROTECT) && stunChance.achieved) hackProtect.canBeAchieved = true;			else hackProtect.canBeAchieved = false;
			if(Variables.UPGRADE_MULTY_STUN) multyStun.achieved = true;					else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_MULTY_STUN) && hackProtect.achieved) multyStun.canBeAchieved = true;				else multyStun.canBeAchieved = false;
			if(Variables.UPGRADE_FREEZE_MASTERED) freezeMastered.achieved = true;		else if((Variables.SYMBOLS >= Variables.UPGRADE_COST_FREEZE_MASTER) && multyStun.achieved) freezeMastered.canBeAchieved = true;			else freezeMastered.canBeAchieved = false;
			
			
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
				if(btn.achieved == false && btn.canBeAchieved == false)	btn.filters = [new ColorMatrixFilter(Variables.GRAY_MATRIX)];
				else if(btn.achieved == false && btn.canBeAchieved == true)
				{
					btn.btnFrame.filters = [new ColorMatrixFilter(Variables.GRAY_MATRIX)];
					btn.addEventListener(MouseEvent.MOUSE_DOWN, onPressBtn, false, 0, true);
					btn.buttonMode = true;
				}
				btn.addEventListener(MouseEvent.MOUSE_OVER, overBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_OUT, outBtn, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_MOVE, moveOnBtn, false, 0, true);
				
				for each(var link:UpgradesLink in linksArray)
				{
					if(link.name == String(btn.name) + "_link")
					{
						if(btn.achieved)
						{
							link.gotoAndStop(2);
							link.filters = [new GlowFilter(0x00FF00)];
						}
						else
						{
							link.gotoAndStop(1);
							link.filters = [];
						}
					}
				}
			}
		}
		
		private function overBtn(e:MouseEvent):void
		{
			descript.visible = true;
			if(stage.mouseX > stage.stageWidth * .7) descript.gotoAndStop("top_left"); 
			else descript.gotoAndStop("top_right");
			if(e.currentTarget.canBeAchieved == true) e.currentTarget.filters = [new GlowFilter(0x00FF00, 1, 10, 10)];
			e.currentTarget.mouseIsOver = true;
			
			switch(e.currentTarget.name)
			{
				case "gun_III":
					descript.txtName.text = "Gun III"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_GUN_III);
					descript.txtDescription.text = gun_III_descript;
				break;
				
				case "criticalX4":
					descript.txtName.text = "Critical X4"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_CRIT_X4);
					descript.txtDescription.text = critical_X4_descript;
				break;
				
				case "gun_V":
					descript.txtName.text = "Gun V"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_GUN_V);
					descript.txtDescription.text = gun_V_descript;
				break;
								
				case "critChance":
					descript.txtName.text = "Crit Chance 20%"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_CRIT_CHANCE);
					descript.txtDescription.text = crit_chance_descript;
				break;
				
				case "additionalTools":
					descript.txtName.text = "Tools +2"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_ADD_TOOLS);
					descript.txtDescription.text = additional_tools_descript;
				break;
				
				case "accumulateDamage":
					descript.txtName.text = "Accum Damage"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_ACC_DAM);
					descript.txtDescription.text = acc_damage_descript;
				break;
				
				case "gunMastered":
					descript.txtName.text = "Gun Master"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_GUN_MASTER);
					descript.txtDescription.text = gun_mastered_descript;
				break;
				
				
				
				case "swarm_III":
					descript.txtName.text = "Swarm III"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_SWARM_III);
					descript.txtDescription.text = swarm_III_descript;
				break;
				
				case "wideSplash":
					descript.txtName.text = "Wide Splash"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_WIDE_SPLASH);
					descript.txtDescription.text = wide_splash_descript;
				break;
				
				case "swarm_V":
					descript.txtName.text = "Swarm V"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_SWARM_V);
					descript.txtDescription.text = swarm_V_descript;
				break;
				
				case "splashChance":
					descript.txtName.text = "Splash Chance 20%"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_SPLASH_CHANCE);
					descript.txtDescription.text = splash_chance_descript;
				break;
				
				case "moreSymbols":
					descript.txtName.text = "More Symbols"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_MORE_SYMBOLS);
					descript.txtDescription.text = more_symbols_descript;
				break;
				
				case "bombCascade":
					descript.txtName.text = "Bombs Cascade"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_BOMB_CASCADE);
					descript.txtDescription.text = bomb_cascade_descript;
				break;
				
				case "swarmMastered":
					descript.txtName.text = "Swarm Master"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_SWARM_MASTER);
					descript.txtDescription.text = swarm_mastered_descript;
				break;
				
				
				
				case "launcher_III":
					descript.txtName.text = "Launcher III"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_LAUNCHER_III);
					descript.txtDescription.text = launcher_III_descript;
				break;
				
				case "poisonDamage":
					descript.txtName.text = "Poison Damage X1,5"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_POISON_DAMAGE);
					descript.txtDescription.text = poison_damage_descript;
				break;
				
				case "launcher_V":
					descript.txtName.text = "Launcher V"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_LAUNCHER_V);
					descript.txtDescription.text = launcher_V_descript;
				break;
				
				case "poisonChance":
					descript.txtName.text = "Poison Chance 20%"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_POISON_CHANCE);
					descript.txtDescription.text = poison_chance_descript;
				break;
				
				case "memoryChance":
					descript.txtName.text = "Memory Chance X1,5"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_MEMORY_CHANCE);
					descript.txtDescription.text = memory_chance_descript;
				break;
				
				case "poisonCloud":
					descript.txtName.text = "Poison Cloud"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_POISON_CLOUD);
					descript.txtDescription.text = poison_cloud_descript;
				break;
				
				case "launcherMastered":
					descript.txtName.text = "Launcher Master"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_LAUNCHER_MASTER);
					descript.txtDescription.text = launcher_mastered_descript;
				break;
				
				
				
				case "freeze_III":
					descript.txtName.text = "Freeze III"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_FREEZE_III);
					descript.txtDescription.text = freeze_III_descript;
				break;
				
				case "longerStun":
					descript.txtName.text = "Longer Stun"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_LONGER_STUN);
					descript.txtDescription.text = longer_stun_descript;
				break;
				
				case "freeze_V":
					descript.txtName.text = "Freeze V"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_FREEZE_V);
					descript.txtDescription.text = freeze_V_descript;
				break;
				
				case "stunChance":
					descript.txtName.text = "Stun Chance 20%"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_STUN_CHANCE);
					descript.txtDescription.text = stun_chance_descript;
				break;
				
				case "hackProtect":
					descript.txtName.text = "Hack Protect"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_HACK_PROTECT);
					descript.txtDescription.text = hack_protect_descript;
				break;
				
				case "multyStun":
					descript.txtName.text = "Multy Stun"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_MULTY_STUN);
					descript.txtDescription.text = multy_stun_descript;
				break;
				
				case "freezeMastered":
					descript.txtName.text = "Freeze Master"
					descript.txtCost.text = "S: " + String(Variables.UPGRADE_COST_FREEZE_MASTER);
					descript.txtDescription.text = freeze_mastered_descript;
				break;
			}
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
			switch(e.currentTarget.name)
			{
				case "gun_III":
					Variables.GUN_MAX_LEVEL = 3;
					Variables.UPGRADE_GUN_III = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_GUN_III;
				break;
				
				case "criticalX4":
					Variables.GUN_CRIT_DAMAGE_MULTIPLY = 4;
					Variables.UPGRADE_CRITICAL_X4 = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_CRIT_X4;
				break;
				
				case "gun_V":
					Variables.GUN_MAX_LEVEL = 5;
					Variables.UPGRADE_GUN_V = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_GUN_V;
				break;
								
				case "critChance":
					Variables.GUN_CRIT_CHANCE = 20;
					Variables.UPGRADE_CRIT_CHANCE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_CRIT_CHANCE;
				break;
				
				case "additionalTools":
					Variables.SPECIAL_TOOL_GAUGE += 2;
					Variables.UPGRADE_ADDITIONAL_TOOLS = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_ADD_TOOLS;
				break;
				
				case "accumulateDamage":
					Variables.UPGRADE_ACC_DAMAGE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_ACC_DAM;
				break;
				
				case "gunMastered":
					Variables.GUN_START_LEVEL = 3;
					Variables.UPGRADE_GUN_MASTERED = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_GUN_MASTER;
				break;
				
				
				
				case "swarm_III":
					Variables.SWARM_MAX_LEVEL = 3;
					Variables.UPGRADE_SWARM_III = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_SWARM_III;
				break;
				
				case "wideSplash":
					Variables.UPGRADE_WIDE_SPLASH = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_WIDE_SPLASH;
				break;
				
				case "swarm_V":
					Variables.SWARM_MAX_LEVEL = 5;
					Variables.UPGRADE_SWARM_V = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_SWARM_V;
				break;
				
				case "splashChance":
					Variables.SWARM_SPLASH_CHANCE = 20;
					Variables.UPGRADE_SPLASH_CHANCE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_SPLASH_CHANCE;
				break;
				
				case "moreSymbols":
					Variables.SYMBOLS_DROP_MULTIPLE = 1.5;
					Variables.UPGRADE_MORE_SYMBOLS = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_MORE_SYMBOLS;
				break;
				
				case "bombCascade":
					Variables.UPGRADE_BOMB_CASCADE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_BOMB_CASCADE;
				break;
				
				case "swarmMastered":
					Variables.SWARM_START_LEVEL = 3;
					Variables.UPGRADE_SWARM_MASTERED = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_SWARM_MASTER;
				break;
				
				
				
				case "launcher_III":
					Variables.LAUNCHER_MAX_LEVEL = 3;
					Variables.UPGRADE_LAUNCHER_III = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_LAUNCHER_III;
				break;
				
				case "poisonDamage":
					Variables.LAUNCHER_POISON_DAMAGE = 3;
					Variables.UPGRADE_POISON_DAMAGE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_POISON_DAMAGE;
				break;
				
				case "launcher_V":
					Variables.LAUNCHER_MAX_LEVEL = 5;
					Variables.UPGRADE_LAUNCHER_V = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_LAUNCHER_V;
				break;
				
				case "poisonChance":
					Variables.LAUNCHER_POISON_CHANCE = 20;
					Variables.UPGRADE_POISON_CHANCE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_POISON_CHANCE;
				break;
				
				case "memoryChance":
					Variables.MEMORY_DROP_CHANCE = 20;
					Variables.UPGRADE_MEMORY_CHANCE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_MEMORY_CHANCE;
				break;
				
				case "poisonCloud":
					Variables.UPGRADE_POISON_CLOUD = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_POISON_CLOUD;
				break;
				
				case "launcherMastered":
					Variables.LAUNCHER_START_LEVEL = 3;
					Variables.UPGRADE_LAUNCHER_MASTERED = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_LAUNCHER_MASTER;
				break;
				
				
				
				case "freeze_III":
					Variables.FREEZE_MAX_LEVEL = 3;
					Variables.UPGRADE_FREEZE_III = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_FREEZE_III;
				break;
				
				case "longerStun":
					Variables.FREEZE_STUN_DURATION = 45;
					Variables.UPGRADE_LONGER_STUN = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_LONGER_STUN;
				break;
				
				case "freeze_V":
					Variables.FREEZE_MAX_LEVEL = 5;
					Variables.UPGRADE_FREEZE_V = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_FREEZE_V;
				break;
				
				case "stunChance":
					Variables.FREEZE_STUN_CHANCE = 20;
					Variables.UPGRADE_STUN_CHANCE = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_STUN_CHANCE;
				break;
				
				case "hackProtect":
					Variables.HACK_PROTECT_LEVEL = 10;
					Variables.UPGRADE_HACK_PROTECT = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_HACK_PROTECT;
				break;
				
				case "multyStun":
					Variables.UPGRADE_MULTY_STUN = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_MULTY_STUN;
				break;
				
				case "freezeMastered":
					Variables.FREEZE_START_LEVEL = 3;
					Variables.UPGRADE_FREEZE_MASTERED = true;
					Variables.SYMBOLS -= Variables.UPGRADE_COST_FREEZE_MASTER;
				break;
			}
			
			e.currentTarget.achieved = true;
			e.currentTarget.canBeAchieved = false;
			pressedUpgrades.push(e.currentTarget);
			
			checkBtns();
			txtSymbols.text = String(Variables.SYMBOLS);
			stage.focus = this;
		}
		
		private function undoChanges(e:MouseEvent):void
		{
			for(var i:int = pressedUpgrades.length; --i >= 0;)
			{
				var btn:MovieClip = pressedUpgrades[i];
				switch(btn.name)
				{
					case "gun_III":
						Variables.GUN_MAX_LEVEL = 1;
						Variables.UPGRADE_GUN_III = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_GUN_III;
					break;
				
					case "criticalX4":
						Variables.GUN_CRIT_DAMAGE_MULTIPLY = 2;
						Variables.UPGRADE_CRITICAL_X4 = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_CRIT_X4;
					break;
				
					case "gun_V":
						Variables.GUN_MAX_LEVEL = 3;
						Variables.UPGRADE_GUN_V = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_GUN_V;
					break;
								
					case "critChance":
						Variables.GUN_CRIT_CHANCE = 10;
						Variables.UPGRADE_CRIT_CHANCE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_CRIT_CHANCE;
					break;
				
					case "additionalTools":
						Variables.SPECIAL_TOOL_GAUGE -= 2;
						Variables.UPGRADE_ADDITIONAL_TOOLS = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_ADD_TOOLS;
					break;
				
					case "accumulateDamage":
						Variables.UPGRADE_ACC_DAMAGE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_ACC_DAM;
					break;
					
					case "gunMastered":
						Variables.GUN_START_LEVEL = 1;
						Variables.UPGRADE_GUN_MASTERED = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_GUN_MASTER;
					break;
				
				
				
					case "swarm_III":
						Variables.SWARM_MAX_LEVEL = 1;
						Variables.UPGRADE_SWARM_III = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_SWARM_III;
					break;
				
					case "wideSplash":
						//
						Variables.UPGRADE_WIDE_SPLASH = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_WIDE_SPLASH;
					break;
				
					case "swarm_V":
						Variables.SWARM_MAX_LEVEL = 3;
						Variables.UPGRADE_SWARM_V = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_SWARM_V;
					break;
				
					case "splashChance":
						Variables.SWARM_SPLASH_CHANCE = 10;
						Variables.UPGRADE_SPLASH_CHANCE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_SPLASH_CHANCE;
					break;
				
					case "moreSymbols":
						//
						Variables.UPGRADE_MORE_SYMBOLS = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_MORE_SYMBOLS;
					break;
				
					case "bombCascade":
						//
						Variables.UPGRADE_BOMB_CASCADE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_BOMB_CASCADE;
					break;
				
					case "swarmMastered":
						Variables.SWARM_START_LEVEL = 1;
						Variables.UPGRADE_SWARM_MASTERED = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_SWARM_MASTER;
					break;
				
				
				
					case "launcher_III":
						Variables.LAUNCHER_MAX_LEVEL = 1;
						Variables.UPGRADE_LAUNCHER_III = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_LAUNCHER_III;
					break;
				
					case "poisonDamage":
						//
						Variables.UPGRADE_POISON_DAMAGE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_POISON_DAMAGE;
					break;
				
					case "launcher_V":
						Variables.LAUNCHER_MAX_LEVEL = 3;
						Variables.UPGRADE_LAUNCHER_V = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_LAUNCHER_V;
					break;
				
					case "poisonChance":
						Variables.LAUNCHER_POISON_CHANCE = 10;
						Variables.UPGRADE_POISON_CHANCE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_POISON_CHANCE;
					break;
				
					case "memoryChance":
						//
						Variables.UPGRADE_MEMORY_CHANCE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_MEMORY_CHANCE;
					break;
				
					case "poisonCloud":
						//
						Variables.UPGRADE_POISON_CLOUD = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_POISON_CLOUD;
					break;
				
					case "launcherMastered":
						Variables.LAUNCHER_START_LEVEL = 1;
						Variables.UPGRADE_LAUNCHER_MASTERED = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_LAUNCHER_MASTER;
					break;
				
				
				
					case "freeze_III":
						Variables.FREEZE_MAX_LEVEL = 1;
						Variables.UPGRADE_FREEZE_III = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_FREEZE_III;
					break;
				
					case "longerStun":
						Variables.FREEZE_STUN_DURATION = 30;
						Variables.UPGRADE_LONGER_STUN = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_LONGER_STUN;
					break;
				
					case "freeze_V":
						Variables.FREEZE_MAX_LEVEL = 3;
						Variables.UPGRADE_FREEZE_V = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_FREEZE_V;
					break;
				
					case "stunChance":
						Variables.FREEZE_STUN_CHANCE = 10;
						Variables.UPGRADE_STUN_CHANCE = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_STUN_CHANCE;
					break;
				
					case "hackProtect":
						//
						Variables.UPGRADE_HACK_PROTECT = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_HACK_PROTECT;
					break;
				
					case "multyStun":
						//
						Variables.UPGRADE_MULTY_STUN = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_MULTY_STUN;
					break;
				
					case "freezeMastered":
						Variables.FREEZE_START_LEVEL = 1;
						Variables.UPGRADE_FREEZE_MASTERED = false;
						Variables.SYMBOLS += Variables.UPGRADE_COST_FREEZE_MASTER;
					break;
				}
				pressedUpgrades.splice(i, 1);
			}
			for each(var theBtn:UpgradeBtn in buttonsArray) theBtn.achieved = theBtn.canBeAchieved = false;
			txtSymbols.text = "Symbols: " + String(Variables.SYMBOLS);
			checkBtns();
			stage.focus = this;
		}
		
		private function closeUpgrades(e:MouseEvent):void
		{
			dispatchEvent(new CustomEvents(CustomEvents.CLOSE_UPGRADES));
		}
	}
}