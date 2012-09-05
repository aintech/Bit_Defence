package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.events.KeyboardEvent;

	public class Main extends MovieClip
	{		
		public var menuScreen:MovieClip;
		public var settingsScreen:MovieClip;
		public var optionsScreen:MovieClip;
		public var mapScreen:MovieClip;
		public var buyUpgradesScreen:MovieClip;
		public var levelBriefingScreen:MovieClip;
		public var playScreen:MovieClip;
		public var levelWinScreen:MovieClip;
		public var levelLoseScreen:MovieClip;
		public var gameWinScreen:MovieClip;
		public var sourceScreen:String;
		
		public var stageH:int;
		public var stageW:int;
		
		public var maxLevels:int = 5;
		public var availableLevel:int = 1;
		public var level:int = 1;
		
		public function Main()
		{
			stageH = stage.stageHeight;
			stageW = stage.stageWidth;
			stage.stageFocusRect = false;
			
			menuScreen = new MenuScreen();
			stage.focus = menuScreen;
			menuScreen.addEventListener(CustomEvents.START_GAME, onGameStart, false, 0, true);
			menuScreen.addEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen, false, 0, true);
			addChild(menuScreen);
		}
		
		private function showSettingsScreen(e:CustomEvents):void
		{
			if(menuScreen)
			{
				menuScreen.removeEventListener(CustomEvents.START_GAME, onGameStart);
				menuScreen.removeEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen);
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
			}
			else if(sourceScreen == "optionsScreen") showOptions(null);
			
			sourceScreen = "";
		}
		
		private function onGameStart(e:CustomEvents):void
		{
			menuScreen.removeEventListener(CustomEvents.START_GAME, onGameStart);
			menuScreen.removeEventListener(CustomEvents.SHOW_SETTINGS, showSettingsScreen);
			removeChild(menuScreen);
			menuScreen = null;
			
			mapScreen = new MapScreen(availableLevel);
			stage.focus = mapScreen;
			mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false ,0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades, false, 0, true);
			mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(mapScreen);
			Variables.setToDefault();
		}
		
		private function onShowUpgrades(e:CustomEvents):void
		{
			mapScreen.removeEventListener(CustomEvents.NEW_LEVEL, onChooseLevel);
			mapScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
			mapScreen.removeEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades);
			mapScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(mapScreen);
			mapScreen = null;
			
			buyUpgradesScreen = new BuyUpgradesScreen();
			stage.focus = buyUpgradesScreen;
			buyUpgradesScreen.backToMapBtn.addEventListener(MouseEvent.CLICK, backToMap, false, 0, true);
			buyUpgradesScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(buyUpgradesScreen);
		}
		
		private function backToMap(e:MouseEvent):void
		{
			buyUpgradesScreen.backToMapBtn.removeEventListener(MouseEvent.CLICK, backToMap);
			buyUpgradesScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(buyUpgradesScreen);
			buyUpgradesScreen = null;
			
			mapScreen = new MapScreen(availableLevel);
			stage.focus = mapScreen;
			mapScreen.addEventListener(CustomEvents.NEW_LEVEL, onChooseLevel, false ,0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
			mapScreen.addEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades, false, 0, true);
			mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(mapScreen);
		}
		
		private function onChooseLevel(e:CustomEvents):void
		{
			level = e.currentTarget.mapLevel;
			mapScreen.removeEventListener(CustomEvents.NEW_LEVEL, onChooseLevel);
			mapScreen.removeEventListener(CustomEvents.SHOW_OPTIONS, showOptions);
			mapScreen.removeEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades);
			mapScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(mapScreen);
			mapScreen = null;
			
			levelBriefingScreen = new LevelBriefingScreen();
			stage.focus = levelBriefingScreen;
			levelBriefingScreen.txtLevel.text = level;
			levelBriefingScreen.addEventListener(MouseEvent.CLICK, startLevel, false, 0, true);
			levelBriefingScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			addChild(levelBriefingScreen);
		}
		
		private function startLevel(e:MouseEvent):void
		{
			levelBriefingScreen.removeEventListener(MouseEvent.CLICK, startLevel);
			levelBriefingScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(levelBriefingScreen);
			levelBriefingScreen = null;
			
			playScreen = new GamePlay(level, stageW, stageH);
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
					optionsScreen.mainMenuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
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
						optionsScreen.mainMenuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
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
						optionsScreen.mainMenuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
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
				else if(e.target is BuyUpgradesScreen) backToMap(null);
			}
		}
		
		private function showOptions(e:CustomEvents):void
		{
			optionsScreen = new OptionsScreen();
			optionsScreen.resumeBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			optionsScreen.settingsBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			optionsScreen.mainMenuBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
			optionsScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
			
			if(playScreen)
			{
				playScreen.pauseGame();
				if(playScreen.waveTimerInAction) playScreen.nextWaveTimer.stop();
				playScreen.filters = [new BlurFilter()];
				
				optionsScreen.restartBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
				optionsScreen.mapBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
				optionsScreen.saveBtn.visible = false;
				addChild(optionsScreen);
			}
			else if(mapScreen)
			{
				mapScreen.filters = [new BlurFilter(5, 5)];
					
				optionsScreen.restartBtn.visible = false;
				optionsScreen.saveBtn.addEventListener(MouseEvent.CLICK, onClickOptions, false, 0, true);
				optionsScreen.saveBtn.y = optionsScreen.resumeBtn.y + optionsScreen.resumeBtn.height + 20;
				optionsScreen.settingsBtn.y = optionsScreen.saveBtn.y + optionsScreen.saveBtn.height + 20;
				optionsScreen.mainMenuBtn.y = optionsScreen.settingsBtn.y + optionsScreen.settingsBtn.height + 20;
				optionsScreen.mapBtn.visible = false;
				addChild(optionsScreen);
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
			optionsScreen.mainMenuBtn.removeEventListener(MouseEvent.CLICK, onClickOptions);
			optionsScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
			removeChild(optionsScreen);
			optionsScreen = null;
			
			switch(e.target.name)
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
				
				playScreen = new GamePlay(level, stageW, stageH);
				stage.focus = playScreen;
				playScreen.addEventListener(CustomEvents.LEVEL_WIN, onLevelWin, false, 0, true);
				playScreen.addEventListener(CustomEvents.LEVEL_LOSE, onLevelLose, false, 0, true);
				playScreen.addEventListener(CustomEvents.SHOW_OPTIONS, showOptions, false, 0, true);
				playScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
				addChild(playScreen);
				break;
				
				case "saveBtn":
				mapScreen.filters = [];
				stage.focus = mapScreen;
				trace("SaveGame");
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
				mapScreen.addEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades, false, 0, true);
				mapScreen.addEventListener(KeyboardEvent.KEY_DOWN, onPressEsc, false, 0, true);
				addChild(mapScreen);
				break;
				
				case "mainMenuBtn":
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
					mapScreen.removeEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades);
					mapScreen.removeEventListener(KeyboardEvent.KEY_DOWN, onPressEsc);
					removeChild(mapScreen);
					mapScreen = null;
				}
				
				restartGame(null);
				break;
			}
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
			mapScreen.addEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades, false, 0, true);
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
			mapScreen.addEventListener(CustomEvents.SHOW_UPDATES, onShowUpgrades, false, 0, true);
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
			Variables.setToDefault();
		}
	}
}