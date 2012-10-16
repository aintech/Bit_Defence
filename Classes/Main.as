package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.events.KeyboardEvent;
	import flash.net.SharedObject;
	
	public class Main extends MovieClip
	{	
		public var menuScreen:MovieClip;
		public var settingsScreen:MovieClip;
		public var optionsScreen:MovieClip;
		public var mapScreen:MovieClip;
		public var upgradesScreen:MovieClip;
		public var playScreen:MovieClip;
		public var levelWinScreen:MovieClip;
		public var levelLoseScreen:MovieClip;
		public var gameWinScreen:MovieClip;
		public var sourceScreen:String;
		
		public static const STAGE_WIDTH:int 	= 900;
		public static const STAGE_HEIGHT:int 	= 600;
		
		public var maxLevels:int = 10;
		public var availableLevel:int = 1;
		public var level:int = 1;
		
		public var userData:SharedObject;
		
		public function init():void
		{
			stage.stageFocusRect = false;
			
			menuScreen = new MenuScreen();
			addChild(menuScreen);
			menuScreen.addEventListener(CustomEvents.START_GAME, onGameStart, false, 0, true);
			menuScreen.addEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen, false, 0, true);
			stage.focus = menuScreen;
			
			userData = SharedObject.getLocal("BitDefence_Data");
			if(userData.data.symbols) menuScreen.addEventListener(CustomEvents.CONTINUE_GAME, continueGame, false, 0, true);
			else menuScreen.disableContinue();
		}
		
		private function continueGame(e:CustomEvents):void
		{
			userData = SharedObject.getLocal("BitDefence_Data");
			
			availableLevel = userData.data.levels;
			
			Variables.SYMBOLS 				= userData.data.symbols;
			Variables.SYMBOLS_DROP_CHANCE 	= userData.data.symbols_drop_chance;
			Variables.MEMORY_DROP_CHANCE 	= userData.data.memory_drop_chance;
			Variables.PROTECT_DROP_CHANCE 	= userData.data.protect_drop_chance;
			Variables.SYMBOLS_DROP_MULTIPLE = userData.data.symbols_drop_multiple;
			Variables.HACK_PROTECT_LEVEL 	= userData.data.hack_protect_level ;
			
			Variables.GUN_START_LEVEL 		= userData.data.gun_start_level;
			Variables.SWARM_START_LEVEL 	= userData.data.swarm_start_level;
			Variables.FREEZE_START_LEVEL 	= userData.data.freeze_start_level;
			Variables.LAUNCHER_START_LEVEL 	= userData.data.launcher_start_level;
			Variables.GUN_MAX_LEVEL 		= userData.data.gun_max_level;
			Variables.SWARM_MAX_LEVEL 		= userData.data.swarm_max_level;
			Variables.FREEZE_MAX_LEVEL 		= userData.data.freeze_max_level;
			Variables.LAUNCHER_MAX_LEVEL 	= userData.data.launcher_max_level;
			
			Variables.GUN_CRIT_CHANCE 			= userData.data.gun_crit_chance;
			Variables.GUN_CRIT_DAMAGE_MULTIPLY 	= userData.data.gun_crit_damage_multiply;
			Variables.GUN_ACC_DAMAGE 			= userData.data.gun_acc_damage;
			
			Variables.FREEZE_STUN_CHANCE 			= userData.data.freeze_stun_chance;
			Variables.FREEZE_STUN_DURATION 			= userData.data.freeze_stun_duration;
			Variables.FREEZE_MULTY_STUN_DISTANCE 	= userData.data.freeze_multy_stun_distance;
			Variables.FREEZE_SPEED_REDUCE_DURATION 	= userData.data.freeze_speed_reduce_duration;
			Variables.FREEZE_SPEED_REDUCE_MULTIPLY 	= userData.data.freeze_speed_reduce_multiply;
			
			Variables.LAUNCHER_POISON_CHANCE 			= userData.data.launcher_poison_chance;
			Variables.LAUNCHER_POISON_DURATION 			= userData.data.launcher_poison_duration;
		 	Variables.LAUNCHER_POISON_DAMAGE 			= userData.data.launcher_poison_damage;
		 	Variables.LAUNCHER_POISON_CLOUD_DAMAGE 		= userData.data.launcher_poison_cloud_damage;
		 	Variables.LAUNCHER_POISON_CLOUD_LIFETIME 	= userData.data.launcher_poison_cloud_lifetime;
			
		 	Variables.SWARM_SPLASH_CHANCE = userData.data.swarm_splash_chance;
		 	Variables.SWARM_SPLASH_DAMAGE = userData.data.swarm_splash_damage;
			
		 	Variables.SPECIAL_TOOL_GAUGE = userData.data.special_tool_gauge;
			
		 	Variables.SPECIAL_FLOW_OVERLOAD_DAMAGE 				= userData.data.special_flow_overload_damage;
		 	Variables.SPECIAL_SYS_DAMAGE_MULTIPLY 				= userData.data.special_sys_damage_multiply;
			Variables.SPECIAL_SYS_DAMAGE_REDUCE_TIME 			= userData.data.special_sys_damage_reduce_time;
		 	Variables.SPECIAL_FLOW_STOP_DURATION 				= userData.data.special_flow_stop_duration;
		 	Variables.SPECIAL_ADDITIONAL_MARKER_INSTALL_TIME 	= userData.data.special_additional_marker_install_time;
			Variables.SPECIAL_FALSE_TARGET_PROTECTION 			= userData.data.special_false_target_protection;
			Variables.SPECIAL_FALSE_TARGET_PROTECTION_LIFE 		= userData.data.special_false_target_protection_life;
			Variables.SPECIAL_MINES_NUMBER 						= userData.data.special_mines_number;
			Variables.SPECIAL_MINES_DAMAGE 						= userData.data.special_mines_damage;
			Variables.SPECIAL_MINES_DISTANCE 					= userData.data.special_mines_distance;
			
		 	Variables.UPGRADE_GUN_III 			= userData.data.upgrade_gun_iii;
		 	Variables.UPGRADE_CRITICAL_X4 		= userData.data.upgrade_critical_x4;
		 	Variables.UPGRADE_GUN_V 			= userData.data.upgrade_gun_v;
		 	Variables.UPGRADE_CRIT_CHANCE 		= userData.data.upgrade_crit_chance;
		 	Variables.UPGRADE_ADDITIONAL_TOOLS 	= userData.data.upgrade_additional_tools;
		 	Variables.UPGRADE_ACC_DAMAGE 		= userData.data.upgrade_acc_damage;
		 	Variables.UPGRADE_GUN_MASTERED 		= userData.data.upgrade_gun_mastered;
			
		 	Variables.UPGRADE_SWARM_III 		= userData.data.upgrade_swarm_iii;
			Variables.UPGRADE_WIDE_SPLASH 		= userData.data.upgrade_wide_splash;
		 	Variables.UPGRADE_SWARM_V 			= userData.data.upgrade_swarm_v;
		 	Variables.UPGRADE_SPLASH_CHANCE 	= userData.data.upgrade_splash_chance;
		 	Variables.UPGRADE_MORE_SYMBOLS 		= userData.data.upgrade_more_symbols;
		 	Variables.UPGRADE_BOMB_CASCADE 		= userData.data.upgrade_bomb_cascade;
		 	Variables.UPGRADE_SWARM_MASTERED 	= userData.data.upgrade_swarm_mastered;
			
		 	Variables.UPGRADE_LAUNCHER_III 		= userData.data.upgrade_launcher_iii;
		 	Variables.UPGRADE_POISON_DAMAGE 	= userData.data.upgrade_poison_damage;
		 	Variables.UPGRADE_LAUNCHER_V 		= userData.data.upgrade_launcher_v;
		 	Variables.UPGRADE_POISON_CHANCE 	= userData.data.upgrade_poison_chance;
		 	Variables.UPGRADE_MEMORY_CHANCE 	= userData.data.upgrade_memory_chance;
		 	Variables.UPGRADE_POISON_CLOUD 		= userData.data.upgrade_poison_cloud;
		 	Variables.UPGRADE_LAUNCHER_MASTERED = userData.data.upgrade_launcher_mastered;
			
		 	Variables.UPGRADE_FREEZE_III 		= userData.data.upgrade_freeze_iii;
		 	Variables.UPGRADE_LONGER_STUN 		= userData.data.upgrade_longer_stun;
		 	Variables.UPGRADE_FREEZE_V 			= userData.data.upgrade_freeze_v;
		 	Variables.UPGRADE_STUN_CHANCE 		= userData.data.upgrade_stun_chance;
		 	Variables.UPGRADE_HACK_PROTECT 		= userData.data.upgrade_hack_protect;
		 	Variables.UPGRADE_MULTY_STUN 		= userData.data.upgrade_multy_stun;
		 	Variables.UPGRADE_FREEZE_MASTERED 	= userData.data.upgrade_freeze_mastered;
			
			Variables.INTRODUCE_SPEEDER 	= userData.data.introduce_speeder;
			Variables.INTRODUCE_WORM 		= userData.data.introduce_worm;
			Variables.INTRODUCE_RECODER 	= userData.data.introduce_recoder;
			Variables.INTRODUCE_PROTECTOR 	= userData.data.introduce_protector;
			Variables.INTRODUCE_NEIROBOT 	= userData.data.introduce_neirobot;
			Variables.INTRODUCE_RUNNER 		= userData.data.introduce_runner;
			Variables.INTRODUCE_CYCLER 		= userData.data.introduce_cycler;
			Variables.INTRODUCE_EMMITER 	= userData.data.introduce_emmiter;
			Variables.INTRODUCE_BUG 		= userData.data.introduce_bug;
			
			Variables.INTRODUCE_GUN 		= userData.data.introduce_gun;
			Variables.INTRODUCE_SWARM 		= userData.data.introduce_swarm;
			Variables.INTRODUCE_LAUNCHER 	= userData.data.introduce_launcher;
			Variables.INTRODUCE_FREEZE 		= userData.data.introduce_freeze;
			
			Variables.INTRODUCE_ADDITIONAL_MARKER 	= userData.data.introduce_additional_marker;
			Variables.INTRODUCE_FLOW_OVERLOAD 		= userData.data.introduce_flow_overload;
			Variables.INTRODUCE_FLOW_STOP 			= userData.data.introduce_flow_stop;
			Variables.INTRODUCE_SYS_DAMAGE_REDUCE 	= userData.data.introduce_sys_damage_reduce;
			Variables.INTRODUCE_RELOCATE_TURRET 	= userData.data.introduce_relocate_turret;
			Variables.INTRODUCE_FALSE_TARGET 		= userData.data.introduce_false_target;
			Variables.INTRODUCE_MINES 				= userData.data.introduce_mines;
			
			Variables.NUM_NEIROBOTS 	= userData.data.num_neirobots;
			Variables.NUM_PROTECTORS 	= userData.data.num_protectors;
			
			menuScreen.removeEventListener(CustomEvents.START_GAME, onGameStart);
			menuScreen.removeEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen);
			if(menuScreen.hasEventListener(CustomEvents.CONTINUE_GAME)) menuScreen.removeEventListener(CustomEvents.CONTINUE_GAME, continueGame);
			removeChild(menuScreen);
			menuScreen = null;
			
			mapScreen = new MapScreen(availableLevel);
			stage.focus = mapScreen;
			mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades, false, 0, true);
			mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(mapScreen);
		}
		
		private function showSettingsScreen(e:CustomEvents):void
		{
			if(menuScreen)
			{
				menuScreen.removeEventListener(CustomEvents.START_GAME, onGameStart);
				menuScreen.removeEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen);
				if(menuScreen.hasEventListener(CustomEvents.CONTINUE_GAME)) menuScreen.removeEventListener(CustomEvents.CONTINUE_GAME, continueGame);
				removeChild(menuScreen);
				menuScreen = null;
				sourceScreen = "menuScreen";
			}
			else if(e == null)
			{
				sourceScreen = "optionsScreen";
			}
			settingsScreen = new SettingsScreen();
			stage.focus = settingsScreen;
			settingsScreen.addEventListener(CustomEvents.CLOSE_SETTINGS, closeSettings, false, 0, true);
			settingsScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(settingsScreen);
		}
		
		private function closeSettings(e:CustomEvents):void
		{
			settingsScreen.removeEventListener(CustomEvents.CLOSE_SETTINGS, closeSettings);
			settingsScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(settingsScreen);
			settingsScreen = null;
			
			if(sourceScreen == "menuScreen")
			{
				menuScreen = new MenuScreen();
				stage.focus = menuScreen;
				menuScreen.addEventListener(CustomEvents.START_GAME, onGameStart, false, 0, true);
				menuScreen.addEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen, false, 0, true);
				addChild(menuScreen);
				
				userData = SharedObject.getLocal("BitDefence_Data");
				if(userData.data.symbols) menuScreen.addEventListener(CustomEvents.CONTINUE_GAME, continueGame, false, 0, true);
				else menuScreen.disableContinue();
			}
			else if(sourceScreen == "optionsScreen") showOptions(null);
			
			sourceScreen = "";
		}
		
		private function onGameStart(e:CustomEvents):void
		{
			menuScreen.removeEventListener(CustomEvents.START_GAME, onGameStart);
			menuScreen.removeEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen);
			if(menuScreen.hasEventListener(CustomEvents.CONTINUE_GAME)) menuScreen.removeEventListener(CustomEvents.CONTINUE_GAME, continueGame);
			removeChild(menuScreen);
			menuScreen = null;
			
			mapScreen = new MapScreen(availableLevel);
			stage.focus = mapScreen;
			mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades, false, 0, true);
			mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(mapScreen);
			Variables.setToDefault();
		}
		
		private function onShowUpgrades(e:CustomEvents):void
		{
			mapScreen.removeEventListener(CustomEvents.NEW_LEVEL, onChooseLevel);
			mapScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
			mapScreen.removeEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades);
			mapScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(mapScreen);
			mapScreen = null;
			
			upgradesScreen = new UpgradesScreen();
			stage.focus = upgradesScreen;
			upgradesScreen.addEventListener(CustomEvents.CLOSE_UPGRADES, backToMap, false, 0, true);
			upgradesScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(upgradesScreen);
		}
		
		private function backToMap(e:CustomEvents):void
		{
			upgradesScreen.removeEventListener(CustomEvents.CLOSE_UPGRADES, backToMap);
			upgradesScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(upgradesScreen);
			upgradesScreen = null;
			
			mapScreen = new MapScreen(availableLevel);
			stage.focus = mapScreen;
			mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false ,0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades, false, 0, true);
			mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(mapScreen);
		}
		
		private function onChooseLevel(e:CustomEvents):void
		{
			level = e.currentTarget.choosedLevel;
			mapScreen.removeEventListener(CustomEvents.NEW_LEVEL, onChooseLevel);
			mapScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
			mapScreen.removeEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades);
			mapScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(mapScreen);
			mapScreen = null;
			
			playScreen = new GamePlay(level, STAGE_WIDTH, STAGE_HEIGHT);
			stage.focus = playScreen;
			playScreen.addEventListener(CustomEvents.LEVEL_WIN, onLevelWin, false, 0, true);
			playScreen.addEventListener(CustomEvents.LEVEL_LOSE, onLevelLose, false, 0, true);
			playScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			playScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(playScreen);
		}
		
		public function onPressEsc(e:KeyboardEvent):void
		{
			if(e.keyCode == 27)
			{
				if(e.target is SettingsScreen)
				{ 
					if(playScreen || mapScreen)
					{
						sourceScreen = "optionsScreen";
						closeSettings(null);
					}
					else if(!playScreen)
					{
						sourceScreen = "menuScreen";
						closeSettings(null);
					}
				}
				else if(e.target is MapScreen && optionsScreen)
				{
					optionsScreen.resumeBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
					optionsScreen.settingsBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
					optionsScreen.menuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
					optionsScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
					removeChild(optionsScreen);
					optionsScreen = null;
						
					mapScreen.filters = [];
					stage.focus = mapScreen;
				}
				else if(e.target is MapScreen) showOptions(null);
				else if(e.target is OptionsScreen)
				{
					if(mapScreen)
					{
						optionsScreen.resumeBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.settingsBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.menuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
						removeChild(optionsScreen);
						optionsScreen = null;
						
						mapScreen.filters = [];
						stage.focus = mapScreen;
					}
					else if(playScreen)
					{
						optionsScreen.resumeBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.restartBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.settingsBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.menuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.mapBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
						optionsScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
						removeChild(optionsScreen);
						optionsScreen = null;
						
						playScreen.filters = [];
						playScreen.pauseGame(false);
						if(playScreen.waveTimerInAction) playScreen.nextWaveTimer.start();
						stage.focus = playScreen;
					}
				}
				else if(e.target is GamePlay) showOptions(null);
				else if(e.target is UpgradesScreen) backToMap(null);
			}
		}
		
		private function showOptions(e:CustomEvents):void
		{
			optionsScreen = new OptionsScreen();
			addChild(optionsScreen);
			optionsScreen.resumeBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			optionsScreen.settingsBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			optionsScreen.menuBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			optionsScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			
			if(playScreen)
			{
				playScreen.pauseGame();
				if(playScreen.waveTimerInAction) playScreen.nextWaveTimer.stop();
				playScreen.filters = [new BlurFilter(10, 10)];
				
				optionsScreen.saveBtn.visible = false;
				optionsScreen.restartBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
				optionsScreen.mapBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			}
			else if(mapScreen)
			{
				mapScreen.filters = [new BlurFilter(10, 10)];
					
				optionsScreen.restartBtn.visible = false;
				optionsScreen.mapBtn.visible = false;
				optionsScreen.saveBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
				optionsScreen.saveBtn.y = optionsScreen.resumeBtn.y + optionsScreen.resumeBtn.height + 20;
				optionsScreen.settingsBtn.y = optionsScreen.saveBtn.y + optionsScreen.saveBtn.height + 20;
				optionsScreen.menuBtn.y = optionsScreen.settingsBtn.y + optionsScreen.settingsBtn.height + 20;
			}
			stage.focus = optionsScreen;
		}
		
		private function onClickOptions(e:MouseEvent):void
		{
			optionsScreen.resumeBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
			if(optionsScreen.restartBtn.hasEventListener(MouseEvent.CLICK)) optionsScreen.restartBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
			if(optionsScreen.saveBtn.hasEventListener(MouseEvent.CLICK)) optionsScreen.saveBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
			if(optionsScreen.mapBtn.hasEventListener(MouseEvent.CLICK)) optionsScreen.mapBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
			optionsScreen.settingsBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
			optionsScreen.menuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
			optionsScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(optionsScreen);
			optionsScreen = null;
			
			switch(e.currentTarget.name)
			{
				case "resumeBtn":
					if(playScreen)
					{
						playScreen.pauseGame(false);
						playScreen.filters = [];
						if(playScreen.waveTimerInAction) playScreen.nextWaveTimer.start();
					}
					else if(mapScreen)
					{
						mapScreen.filters = [];
						stage.focus = mapScreen;
					}
				break;
				
				case "restartBtn":
					playScreen.removeEventListener(CustomEvents.LEVEL_WIN, onLevelWin);
					playScreen.removeEventListener(CustomEvents.LEVEL_LOSE, onLevelLose);
					playScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
					playScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
					removeChild(playScreen);
					playScreen = null;
				
					playScreen = new GamePlay(level, STAGE_WIDTH, STAGE_HEIGHT);
					stage.focus = playScreen;
					playScreen.addEventListener(CustomEvents.LEVEL_WIN, onLevelWin, false, 0, true);
					playScreen.addEventListener(CustomEvents.LEVEL_LOSE, onLevelLose, false, 0, true);
					playScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
					playScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
					addChild(playScreen);
				break;
				
				case "saveBtn":
					saveData();
					mapScreen.filters = [];
					mapScreen.saveGameMessage();
					stage.focus = mapScreen;
				break;
				
				case "settingsBtn":
					showSettingsScreen(null);
				break;
				
				case "mapBtn":
					playScreen.removeEventListener(CustomEvents.LEVEL_WIN, onLevelWin);
					playScreen.removeEventListener(CustomEvents.LEVEL_LOSE, onLevelLose);
					playScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
					playScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
					removeChild(playScreen);
					playScreen = null;
				
					mapScreen = new MapScreen(availableLevel);
					stage.focus = mapScreen;
					mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false, 0, true);
					mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
					mapScreen.addEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades, false, 0, true);
					mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
					addChild(mapScreen);
				break;
				
				case "menuBtn":
				if(playScreen)
				{
					playScreen.removeEventListener(CustomEvents.LEVEL_WIN, onLevelWin);
					playScreen.removeEventListener(CustomEvents.LEVEL_LOSE, onLevelLose);
					playScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
					playScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
					removeChild(playScreen);
					playScreen = null;
				}
				else if(mapScreen)
				{
					mapScreen.removeEventListener(CustomEvents.NEW_LEVEL, onChooseLevel);
					mapScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
					mapScreen.removeEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades);
					mapScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
					removeChild(mapScreen);
					mapScreen = null;
				}
				
				restartGame(null);
				break;
			}
		}
		
		private function saveData():void
		{
			userData = SharedObject.getLocal("BitDefence_Data");
			
			userData.data.levels = availableLevel;
			
			userData.data.symbols 				= Variables.SYMBOLS;
			userData.data.symbols_drop_chance 	= Variables.SYMBOLS_DROP_CHANCE;
			userData.data.memory_drop_chance 	= Variables.MEMORY_DROP_CHANCE;
			userData.data.protect_drop_chance 	= Variables.PROTECT_DROP_CHANCE;
			userData.data.symbols_drop_multiple = Variables.SYMBOLS_DROP_MULTIPLE;
			userData.data.hack_protect_level 	= Variables.HACK_PROTECT_LEVEL;
			
			userData.data.gun_start_level 		= Variables.GUN_START_LEVEL;
			userData.data.swarm_start_level 	= Variables.SWARM_START_LEVEL;
			userData.data.freeze_start_level 	= Variables.FREEZE_START_LEVEL;
			userData.data.launcher_start_level 	= Variables.LAUNCHER_START_LEVEL;
			userData.data.gun_max_level 		= Variables.GUN_MAX_LEVEL;
			userData.data.swarm_max_level 		= Variables.SWARM_MAX_LEVEL;
			userData.data.freeze_max_level 		= Variables.FREEZE_MAX_LEVEL;
			userData.data.launcher_max_level 	= Variables.LAUNCHER_MAX_LEVEL;
			
			userData.data.gun_crit_chance 			= Variables.GUN_CRIT_CHANCE;
			userData.data.gun_crit_damage_multiply 	= Variables.GUN_CRIT_DAMAGE_MULTIPLY;
			userData.data.gun_acc_damage 			= Variables.GUN_ACC_DAMAGE;
			
			userData.data.freeze_stun_chance 			= Variables.FREEZE_STUN_CHANCE;
			userData.data.freeze_stun_duration 			= Variables.FREEZE_STUN_DURATION;
			userData.data.freeze_multy_stun_distance 	= Variables.FREEZE_MULTY_STUN_DISTANCE;
			userData.data.freeze_speed_reduce_duration 	= Variables.FREEZE_SPEED_REDUCE_DURATION;
			userData.data.freeze_speed_reduce_multiply 	= Variables.FREEZE_SPEED_REDUCE_MULTIPLY;
			
			userData.data.launcher_poison_chance 			= Variables.LAUNCHER_POISON_CHANCE;
			userData.data.launcher_poison_duration 			= Variables.LAUNCHER_POISON_DURATION;
		 	userData.data.launcher_poison_damage 			= Variables.LAUNCHER_POISON_DAMAGE;
		 	userData.data.launcher_poison_cloud_damage 		= Variables.LAUNCHER_POISON_CLOUD_DAMAGE;
		 	userData.data.launcher_poison_cloud_lifetime 	= Variables.LAUNCHER_POISON_CLOUD_LIFETIME;
			
		 	userData.data.swarm_splash_chance = Variables.SWARM_SPLASH_CHANCE;
		 	userData.data.swarm_splash_damage = Variables.SWARM_SPLASH_DAMAGE;
			
		 	userData.data.special_tool_gauge = Variables.SPECIAL_TOOL_GAUGE;
			
		 	userData.data.special_flow_overload_damage 				= Variables.SPECIAL_FLOW_OVERLOAD_DAMAGE;
		 	userData.data.special_sys_damage_multiply 				= Variables.SPECIAL_SYS_DAMAGE_MULTIPLY;
			userData.data.special_sys_damage_reduce_time 			= Variables.SPECIAL_SYS_DAMAGE_REDUCE_TIME;
		 	userData.data.special_flow_stop_duration 				= Variables.SPECIAL_FLOW_STOP_DURATION;
		 	userData.data.special_additional_marker_install_time 	= Variables.SPECIAL_ADDITIONAL_MARKER_INSTALL_TIME;
			userData.data.special_false_target_protection 			= Variables.SPECIAL_FALSE_TARGET_PROTECTION;
			userData.data.special_false_target_protection_life 		= Variables.SPECIAL_FALSE_TARGET_PROTECTION_LIFE;
			userData.data.special_mines_number 						= Variables.SPECIAL_MINES_NUMBER;
			userData.data.special_mines_damage 						= Variables.SPECIAL_MINES_DAMAGE;
			userData.data.special_mines_distance 					= Variables.SPECIAL_MINES_DISTANCE;
			
		 	userData.data.upgrade_gun_iii 			= Variables.UPGRADE_GUN_III;
		 	userData.data.upgrade_critical_x4 		= Variables.UPGRADE_CRITICAL_X4;
		 	userData.data.upgrade_gun_v 			= Variables.UPGRADE_GUN_V;
		 	userData.data.upgrade_crit_chance 		= Variables.UPGRADE_CRIT_CHANCE;
		 	userData.data.upgrade_additional_tools 	= Variables.UPGRADE_ADDITIONAL_TOOLS;
		 	userData.data.upgrade_acc_damage 		= Variables.UPGRADE_ACC_DAMAGE;
		 	userData.data.upgrade_gun_mastered 		= Variables.UPGRADE_GUN_MASTERED;
			
		 	userData.data.upgrade_swarm_iii 		= Variables.UPGRADE_SWARM_III;
			userData.data.upgrade_wide_splash 		= Variables.UPGRADE_WIDE_SPLASH;
		 	userData.data.upgrade_swarm_v 			= Variables.UPGRADE_SWARM_V;
		 	userData.data.upgrade_splash_chance 	= Variables.UPGRADE_SPLASH_CHANCE;
		 	userData.data.upgrade_more_symbols 		= Variables.UPGRADE_MORE_SYMBOLS;
		 	userData.data.upgrade_bomb_cascade 		= Variables.UPGRADE_BOMB_CASCADE;
		 	userData.data.upgrade_swarm_mastered 	= Variables.UPGRADE_SWARM_MASTERED;
			
		 	userData.data.upgrade_launcher_iii 		= Variables.UPGRADE_LAUNCHER_III;
		 	userData.data.upgrade_poison_damage 	= Variables.UPGRADE_POISON_DAMAGE;
		 	userData.data.upgrade_launcher_v 		= Variables.UPGRADE_LAUNCHER_V;
		 	userData.data.upgrade_poison_chance 	= Variables.UPGRADE_POISON_CHANCE;
		 	userData.data.upgrade_memory_chance 	= Variables.UPGRADE_MEMORY_CHANCE;
		 	userData.data.upgrade_poison_cloud 		= Variables.UPGRADE_POISON_CLOUD;
		 	userData.data.upgrade_launcher_mastered = Variables.UPGRADE_LAUNCHER_MASTERED;
			
		 	userData.data.upgrade_freeze_iii 		= Variables.UPGRADE_FREEZE_III;
		 	userData.data.upgrade_longer_stun 		= Variables.UPGRADE_LONGER_STUN;
		 	userData.data.upgrade_freeze_v 			= Variables.UPGRADE_FREEZE_V;
		 	userData.data.upgrade_stun_chance 		= Variables.UPGRADE_STUN_CHANCE;
		 	userData.data.upgrade_hack_protect 		= Variables.UPGRADE_HACK_PROTECT;
		 	userData.data.upgrade_multy_stun 		= Variables.UPGRADE_MULTY_STUN;
		 	userData.data.upgrade_freeze_mastered 	= Variables.UPGRADE_FREEZE_MASTERED;
			
			userData.data.introduce_speeder 	= Variables.INTRODUCE_SPEEDER;
			userData.data.introduce_worm 		= Variables.INTRODUCE_WORM;
			userData.data.introduce_recoder 	= Variables.INTRODUCE_RECODER;
			userData.data.introduce_protector 	= Variables.INTRODUCE_PROTECTOR;
			userData.data.introduce_neirobot 	= Variables.INTRODUCE_NEIROBOT;
			userData.data.introduce_runner 		= Variables.INTRODUCE_RUNNER;
			userData.data.introduce_cycler 		= Variables.INTRODUCE_CYCLER;
			userData.data.introduce_emmiter 	= Variables.INTRODUCE_EMMITER;
			userData.data.introduce_bug 		= Variables.INTRODUCE_BUG;
			
			userData.data.introduce_gun 		= Variables.INTRODUCE_GUN;
			userData.data.introduce_swarm 		= Variables.INTRODUCE_SWARM;
			userData.data.introduce_launcher 	= Variables.INTRODUCE_LAUNCHER;
			userData.data.introduce_freeze 		= Variables.INTRODUCE_FREEZE;
			
			userData.data.introduce_additional_marker 	= Variables.INTRODUCE_ADDITIONAL_MARKER;
			userData.data.introduce_flow_overload 		= Variables.INTRODUCE_FLOW_OVERLOAD;
			userData.data.introduce_flow_stop 			= Variables.INTRODUCE_FLOW_STOP;
			userData.data.introduce_sys_damage_reduce 	= Variables.INTRODUCE_SYS_DAMAGE_REDUCE;
			userData.data.introduce_relocate_turret 	= Variables.INTRODUCE_RELOCATE_TURRET;
			userData.data.introduce_false_target 		= Variables.INTRODUCE_FALSE_TARGET;
			userData.data.introduce_mines 				= Variables.INTRODUCE_MINES;
			
			userData.data.num_neirobots 	= Variables.NUM_NEIROBOTS;
			userData.data.num_protectors 	= Variables.NUM_PROTECTORS;
		}
		
		private function onLevelWin(e:CustomEvents):void
		{
			if(availableLevel == level) availableLevel++;
			
			playScreen.removeEventListener(CustomEvents.LEVEL_WIN, onLevelWin);
			playScreen.removeEventListener(CustomEvents.LEVEL_LOSE, onLevelLose);
			playScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
			playScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(playScreen);
			playScreen = null;
				
			levelWinScreen = new LevelWinScreen();
			stage.focus = levelWinScreen;
			levelWinScreen.txtLevel.text = level.toString();
			addChild(levelWinScreen);
			
			if(level == maxLevels) levelWinScreen.addEventListener(MouseEvent.CLICK, gameWin, false, 0, true);
			else levelWinScreen.addEventListener(MouseEvent.CLICK, levelWinScreenClicked, false, 0, true);
			
		}
		
		private function levelWinScreenClicked(e:MouseEvent):void
		{
			levelWinScreen.removeEventListener(MouseEvent.CLICK, levelWinScreenClicked);
			levelWinScreen.txtLevel.text = "";
			removeChild(levelWinScreen);
			levelWinScreen = null;
			
			mapScreen = new MapScreen(availableLevel);
			stage.focus = mapScreen;
			mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades, false, 0, true);
			mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(mapScreen);
		}
		
		private function onLevelLose(e:CustomEvents):void
		{
			playScreen.removeEventListener(CustomEvents.LEVEL_WIN, onLevelWin);
			playScreen.removeEventListener(CustomEvents.LEVEL_LOSE, onLevelLose);
			playScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
			playScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(playScreen);
			playScreen = null;
			
			levelLoseScreen = new LevelLoseScreen();
			stage.focus = levelLoseScreen;
			levelLoseScreen.addEventListener(MouseEvent.CLICK, levelLoseScreenClicked, false, 0, true);
			addChild(levelLoseScreen);
		}
		
		private function levelLoseScreenClicked(e:MouseEvent):void
		{
			levelLoseScreen.removeEventListener(MouseEvent.CLICK, levelLoseScreenClicked);
			removeChild(levelLoseScreen);
			levelLoseScreen = null;
			
			mapScreen = new MapScreen(availableLevel);
			stage.focus = mapScreen;
			mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_UPGRADES, onShowUpgrades, false, 0, true);
			mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(mapScreen);
		}
		
		private function gameWin(e:MouseEvent):void
		{
			levelWinScreen.removeEventListener(MouseEvent.CLICK, gameWin);
			levelWinScreen.txtLevel.text = "";
			removeChild(levelWinScreen);
			levelWinScreen = null;
			
			gameWinScreen = new GameWinScreen();
			stage.focus = gameWinScreen;
			gameWinScreen.addEventListener(MouseEvent.CLICK, restartGame, false, 0, true);
			addChild(gameWinScreen);
		}
		
		private function restartGame(e:MouseEvent):void
		{
			if(gameWinScreen)
			{
				gameWinScreen.removeEventListener(MouseEvent.CLICK, restartGame);
				removeChild(gameWinScreen);
				gameWinScreen = null;
			}
			
			menuScreen = new MenuScreen();
			stage.focus = menuScreen;
			availableLevel = 1;
			level = 1;
			menuScreen.addEventListener(CustomEvents.START_GAME, onGameStart, false, 0, true);
			menuScreen.addEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen, false, 0, true);
			menuScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(menuScreen);
			
			userData = SharedObject.getLocal("BitDefence_Data");
			if(userData.data.symbols) menuScreen.addEventListener(CustomEvents.CONTINUE_GAME, continueGame, false, 0, true);
			else menuScreen.disableContinue();
			
			Variables.setToDefault();
		}
	}
}