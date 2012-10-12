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
		
		public static const STAGE_HEIGHT:int 	= 600;
		public static const STAGE_WIDTH:int 	= 900;
		
		public var maxLevels:int = 5;
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
			trace(userData.data.symbols);
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
			userData.data.symbols = Variables.SYMBOLS;
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