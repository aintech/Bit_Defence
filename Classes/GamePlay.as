//OPTIM: Всем gotoAndStop пусть указывают на кадр с названием а не номером
//OPTIM: Оптимизировать MapScreen, чтобы тамошний код не повторялся для каждого уровня
//TODO: Каждый вид врага взрывается по-своему
//TODO: Анимация взлома со всякими полосками бегущими по enemyFinalTarget
//TODO: сделать прелоадер
//TODO: Экраны должны плавно переходить друг в друга - анимация экранов
//HELP: ||
//TODO: сделать scaleX, scaleY всем лайфбарам в зависимости от какой-то константы (например 10000 жизней, если у цели более 10000 жизни - двойной лайфбар)

//СпецТехника:
//Дополнительный контур защиты - снижает systemDamage врагов
//Остановка потока - все враги на время замирают
//Перегрузка потока - наносятся повреждения всем врагам
//Переустановка - перестановка турели со всеми апгрейдами на другой маркер
//Подключение дополнительного маркера - можно создать новый маркер, на который можно установить турель
//Преграда - фальшивый enemyFinalTarget, который тот должен взломать, чтобы продолжить движение
//Мины - устанавливаются на дороге и взрывается при прикосновении противника

//TODO: нажатии кнопки не исчезают, а уменьшаются - для создания анимации

//TODO: из врагов выпадают бусты - типа защиты от взлома
//TODO: можно настроить, чтобы турели били ближайшего, сильнейшего и т.д.
//TODO: У каждого врага свое время задержки перед выходом

//BALANCE: разные типы врагов устойчивые к разным турелям заставять игрока применять разные тактики

//FIX: иногда пропадает rangeCircle
package 
{
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.filters.ColorMatrixFilter;
	import flash.display.Graphics;
	import flash.events.KeyboardEvent;

	public class GamePlay extends MovieClip
	{
		private var P:String = "Road";
		private var G:String = "Ground";
		private var M:String = "PlaceMarker";
		
		private var S:String = "Start";
		private var F:String = "Finish";
		private var U:String = "Up";
		private var D:String = "Down";
		private var R:String = "Right";
		private var L:String = "Left";
		
		public var currentLevel:int;
		public var currentWave:int = 1;
		
		public var levelMap:Array = [];
		public var enemyWaves:Array = [];
		
		public var scoreBoard:ScoreBoard = new ScoreBoard();
		public var background:MovieClip;
		public var road:MovieClip;
		public var roadStart:Point;
		
		public var backgroundHolder:Sprite 		= new Sprite();
		public var blocksHolder:Sprite			= new Sprite();
		public var groundHolder:Sprite 			= new Sprite();
		public var roadHolder:Sprite			= new Sprite();
		public var markerHolder:Sprite 			= new Sprite();
		public var enemyHolder:Sprite 			= new Sprite();
		public var turretHolder:Sprite 			= new Sprite();
		public var bulletHolder:Sprite 			= new Sprite();
		public var charHolder:Sprite 			= new Sprite();
		public var userInterface:Sprite			= new Sprite();
		public var introduceHolder:Sprite		= new Sprite();
		public var toolGaugeScreen:Sprite		= new Sprite();
		
		public var charScreen:MovieClip;
		public var availableCharArray:Array = [];
		public var charIconXOffset:int = 3;
		public var charIconYOffset:int = 3;
		public var charIcon:MovieClip;
		public var dragCharIcon:MovieClip;
		public var dragging:Boolean = false;
		
		public var toolsScreen:MovieClip;
		public var availableToolsArray:Array = [];
		public var toolIconXOffset:int = 3;
		public var toolIconYOffset:int = 3;
		public var toolIcon:SpecialTools;
		public var toolInfo:SpecialToolInfo;
		
		public var tempChar:MovieClip;
		public var infoScreen:InfoScreen;
		
		public var chooseTurretCircle:MovieClip;
		public var confirmTurretCircle:MovieClip;
		
		public var charMenu:MovieClip;
		
		public var gameWidth:int;
		public var gameHeight:int;
		
		public var rangeCircle:Shape;
		public var baseRangeCircle:Boolean = false;
		
		public var gameTimer:Timer;
		
		public var currentEnemy:int;
		public var enemyTime:int;
		public var enemyLimit:int = Variables.ENEMY_DELAY;//Время задержки появления врагов
		public var enemiesLeft:int;
		
		public var dropArray:Array					= [];
		public var roadArray:Array					= [];
		public var minesArray:Array					= [];
		public var enemyArray:Array 				= [];
		public var swarmArray:Array 				= [];
		public var rocketArray:Array 				= [];
		public var splashArray:Array 				= [];
		public var groundArray:Array				= [];
		public var directArray:Array 				= [];
		public var markerArray:Array 				= [];
		public var turretArray:Array 				= [];
		public var particleArray:Array 				= [];
		public var upgradingArray:Array				= [];
		public var distEnemyArray:Array				= [];
		public var hackingEnemies:Array				= [];
		public var installingArray:Array			= [];
		public var swarmBombsArray:Array			= [];
		public var bombSplashArray:Array			= [];
		public var swarmSplashArray:Array			= [];
		public var poisonCloudsArray:Array			= [];
		public var uninstallingArray:Array			= [];
		public var specialToolsArray:Array			= [];
		public var introScreensArray:Array			= [];
		public var addMarkerCounterArray:Array		= [];
		public var specialToolsGaugeArray:Array		= [];
		public var specialToolsDisablesArray:Array	= [];
		public var availableActionFlagsArray:Array	= [];
		public var specialToolsCooldownsArray:Array	= [];
		
		public var mapCols:int = 15;
		public var mapRows:int = 9;
		
		public var memoryTotal:int;
		public var memoryUsed:int 	= 0;
		
		public var gameOver:Boolean = false;
		public var gamePaused:Boolean = false;
		
		public var optionsGearBtn:SimpleButton;
		
		public var specialToolsGauge:int = Variables.SPECIAL_TOOL_GAUGE;
		public var addingMarker:Boolean = false;
		public var specialToolCooldown:SpecialToolsCooldown;
		public var specialToolDisableClip:Sprite;
		
		public var cancelToolClip:MovieClip;
		
		public var turretRelocatingON:Boolean = false;
		public var relocatingTurretChoosen:Boolean = false;
		public var relocationTurretClip:MovieClip;
		
		public var flowStopInAction:Boolean = false;
		public var flowStopCounter:int;
		
		public var startLevelBtn:MovieClip;
		public var levelStarted:Boolean = false;
		
		public var startBanner:Banner;
		public var startWaveBtn:MovieClip;
		public var startWaveBtnArrow:MovieClip;
		public var nextWaveTimer:Timer;
		public var waveTimerInAction:Boolean = false;
		
		public var scoreMemoryPoint:Point;
		public var scoreSymbolsPoint:Point;
		public var scoreProtectPoint:Point;
		
		public var roadCounter:int = 2;
		
		public var enemyFinalTarget:EnemyFinalTarget;
		public var statusEffects:StatusEffects;
		
		public var introScreen:IntroduceScreen;
		public var introduceInWork:Boolean;
		
		public var systemProtection:Number = 100;
		
		public var falseTarget:EnemyFalseTarget;
		public var placingFalseTarget:Boolean;
		
		public var runnerRoadID:int = 1;
		
		private var enemyFrame:EnemyFrame;
		
		public var systemDamReduceTime:int = 0;
		public var systemDamReduceInAction:Boolean;
		
		public var priorityMark:PriorityMark = new PriorityMark();
				
		public function GamePlay(level:int, gameWidth:int, gameHeight:int)
		{
			currentLevel = level;
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd)
			init();
		}
		
		private function init():void
		{
			levelMap 			= LevelData.makeLevel(currentLevel);
			enemyWaves 			= LevelData.makeEnemies(currentLevel);
			availableCharArray 	= LevelData.levelChars(currentLevel);
			availableToolsArray = LevelData.levelTools(currentLevel);
			memoryTotal 		= LevelData.levelMemory(currentLevel);			
			
			addChild(backgroundHolder);
			addChild(roadHolder);
			addChild(blocksHolder);
			blocksHolder.alpha = 0;
			addChild(groundHolder);
			//groundHolder.alpha = 0;
			addChild(markerHolder);
			addChild(enemyHolder);
			enemyFinalTarget = new EnemyFinalTarget(); addChild(enemyFinalTarget);
			addChild(turretHolder);
			addChild(bulletHolder);
			addChild(charHolder);
			addChild(userInterface);
			addChild(introduceHolder); introduceHolder.y = 90;
			userInterface.addChild(scoreBoard);
			
			optionsGearBtn = new OptionsGear();
			userInterface.addChild(optionsGearBtn);
			optionsGearBtn.x = gameWidth - optionsGearBtn.width;
			optionsGearBtn.addEventListener(MouseEvent.CLICK, showOptions, false, 0, true);
			
			background = new LevelBackgrounds();
			background.gotoAndStop(currentLevel);
			backgroundHolder.addChild(background);
			
			road = new LevelRoads();
			road.gotoAndStop(currentLevel);
			roadHolder.addChild(road);
			
			charScreen = new CharScreen();
			charScreen.x = 0;
			charScreen.y = gameHeight;
			charHolder.addChild(charScreen);
			
			for(var i:int = 0; i < availableCharArray.length; i++)
			{
				var char:String = availableCharArray[i];
				var character:Turret;
				
				switch(char)
				{
					case Turret.TURRET_GUN:
					character = new GunTurret();
					charIcon = new CharIcon(Turret.TURRET_GUN);
					charIcon.gotoAndStop("gunTurret");
					if(!Variables.INTRODUCE_GUN) introduce(IntroduceScreen.GUN);
					break;
					
					case Turret.TURRET_LAUNCHER:
					character = new LauncherTurret();
					charIcon = new CharIcon(Turret.TURRET_LAUNCHER);
					charIcon.gotoAndStop("launcherTurret");
					if(!Variables.INTRODUCE_LAUNCHER) introduce(IntroduceScreen.LAUNCHER);
					break;
					
					case Turret.TURRET_SWARM:
					character = new SwarmTurret();
					charIcon = new CharIcon(Turret.TURRET_SWARM);
					charIcon.gotoAndStop("swarmTurret");
					if(!Variables.INTRODUCE_SWARM) introduce(IntroduceScreen.SWARM);
					break;
					
					case Turret.TURRET_FREEZE:
					character = new FreezeTurret();
					charIcon = new CharIcon(Turret.TURRET_FREEZE);
					charIcon.gotoAndStop("freezeTurret");
					if(!Variables.INTRODUCE_FREEZE) introduce(IntroduceScreen.FREEZE);
					break;
				}
				
				charScreen.addChild(charIcon);
				charIcon.x = i * charIcon.width + charIconXOffset;
				charIcon.y = -charIcon.height - charIconYOffset;
				character.updateLevel();
				charIcon.range = character.range;
				charIcon.memoryUse = character.memoryUse;
				character = null;
				charIcon.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
				charIcon.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				charIcon.addEventListener(MouseEvent.MOUSE_OUT, showChooseInfo, false, 0, true);
				charIcon.addEventListener(MouseEvent.MOUSE_DOWN, dragIcon, false, 0, true);
			}
			
			toolsScreen = new ToolsScreen();
			toolsScreen.x = charScreen.width + 50;
			toolsScreen.y = gameHeight;
			charHolder.addChild(toolsScreen);
			
			for(var s:int = 0; s < availableToolsArray.length; s++)
			{
				var tool:String = availableToolsArray[s];
				switch(tool)
				{
					case SpecialTools.ADDITIONAL_MARKER:
						toolIcon = new SpecialTools(SpecialTools.ADDITIONAL_MARKER);
						toolIcon.gotoAndStop("additionalMarker");
						if(!Variables.INTRODUCE_ADDITIONAL_MARKER) introduce(IntroduceScreen.ADDITIONAL_MARKER);
					break;
					
					case SpecialTools.FLOW_OVERLOAD:
					toolIcon = new SpecialTools(SpecialTools.FLOW_OVERLOAD);
					toolIcon.gotoAndStop("flowOverload");
					if(!Variables.INTRODUCE_FLOW_OVERLOAD) introduce(IntroduceScreen.FLOW_OVERLOAD);
					break;
					
					case SpecialTools.FLOW_STOP:
					toolIcon = new SpecialTools(SpecialTools.FLOW_STOP);
					toolIcon.gotoAndStop("flowStop");
					if(!Variables.INTRODUCE_FLOW_STOP) introduce(IntroduceScreen.FLOW_STOP);
					break;
					
					case SpecialTools.SYS_DAMAGE_REDUCE:
					toolIcon = new SpecialTools(SpecialTools.SYS_DAMAGE_REDUCE);
					toolIcon.gotoAndStop("sysDamReduce");
					if(!Variables.INTRODUCE_SYS_DAMAGE_REDUCE) introduce(IntroduceScreen.SYS_DAMAGE_REDUCE);
					break;
					
					case SpecialTools.RELOCATE_TURRET:
					toolIcon = new SpecialTools(SpecialTools.RELOCATE_TURRET);
					toolIcon.gotoAndStop("relocateTurret");
					if(!Variables.INTRODUCE_RELOCATE_TURRET) introduce(IntroduceScreen.RELOCATE_TURRET);
					break;
					
					case SpecialTools.FALSE_TARGET:
						toolIcon = new SpecialTools(SpecialTools.FALSE_TARGET);
						toolIcon.gotoAndStop("falseTarget");
						if(!Variables.INTRODUCE_FALSE_TARGET) introduce(IntroduceScreen.FALSE_TARGET);
					break;
					
					case SpecialTools.MINES:
						toolIcon = new SpecialTools(SpecialTools.MINES);
						toolIcon.gotoAndStop("mines");
						if(!Variables.INTRODUCE_MINES) introduce(IntroduceScreen.MINES);
					break;
				}
				
				toolsScreen.addChild(toolIcon);
				toolIcon.x = s * 62;
				toolIcon.y = (-toolIcon.height - toolIconYOffset) + toolIcon.height * .5;
				toolIcon.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
				toolIcon.addEventListener(MouseEvent.MOUSE_OVER, showToolInfo, false, 0, true);
				toolIcon.addEventListener(MouseEvent.MOUSE_OUT, hideToolInfo, false, 0, true);
				toolIcon.addEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo, false, 0, true);
				toolIcon.mouseEnabled = true;
				specialToolsArray.push(toolIcon);
				
				specialToolDisableClip = new SpecialToolDisable();
				specialToolDisableClip.x = toolIcon.x;
				specialToolDisableClip.y = toolIcon.y;
				specialToolsDisablesArray.push(specialToolDisableClip);
				toolsScreen.addChild(specialToolDisableClip);
			}
			stage.addEventListener(MouseEvent.CLICK, unClick, false, 0, true);
			
			for(var st:int = 0; st < int(Variables.SPECIAL_TOOL_GAUGE); st++)
			{
				var toolGauge:SpecialToolsGauge = new SpecialToolsGauge();
				toolGaugeScreen.addChild(toolGauge);
				toolGauge.x = st * (toolGauge.width - 5) + 15;
				toolGauge.y = -65 - toolGauge.height;
				toolGauge.gotoAndStop(toolGauge.totalFrames);
				specialToolsGaugeArray.push(toolGauge);
			}
			toolsScreen.addChild(toolGaugeScreen);
			toolGaugeScreen.x = toolsScreen.width * .5 - toolGaugeScreen.width * .5;
			
			startLevelBtn = new StartLevelBtn();
			startLevelBtn.addEventListener(MouseEvent.CLICK, startLevel, false, 0, true);
			startLevelBtn.gotoAndStop(1);
			startLevelBtn.buttonMode = true;
			userInterface.addChild(startLevelBtn);
			
			startBanner = new Banner();
			startBanner.x = startLevelBtn.x + startLevelBtn.width * .7;
			startBanner.y = startLevelBtn.y + startLevelBtn.height * .7;
			startBanner.gotoAndStop("start");
			userInterface.addChild(startBanner);
			
			scoreBoard.x = startLevelBtn.width + 5;
			updateScoreBoard("txtWave");
			updateScoreBoard("txtEnemiesLeft");
			updateScoreBoard("txtMemory");
			updateScoreBoard("txtSymbols");
			updateScoreBoard("txtSymbols");
			scoreBoard.txtHackChance.text = "hack: */*";
			
			scoreSymbolsPoint = new Point(scoreBoard.txtSymbols.x + startLevelBtn.width + scoreBoard.txtSymbols.width * .5, scoreBoard.y - 20); 
			scoreMemoryPoint = new Point(scoreBoard.txtMemory.x + startLevelBtn.width + scoreBoard.txtMemory.width * .5, scoreBoard.y - 20); 
			scoreProtectPoint = new Point(scoreBoard.txtSystem.x + startLevelBtn.width + scoreBoard.txtSystem.width * .5, scoreBoard.y - 20);
			
			startWave();
			makeLevel();
			
			gameTimer = new Timer(50);
			gameTimer.addEventListener(TimerEvent.TIMER, gameLoop, false, 0, true);
			gameTimer.start();
			
			nextWaveTimer = new Timer(1000, int(Variables.WAVE_DELAY));
			nextWaveTimer.addEventListener(TimerEvent.TIMER, countWaveDelay, false, 0, true);
			nextWaveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, waveDelayComplete, false, 0, true);
		}
		
		public function startLevel(e:MouseEvent):void
		{
			startLevelBtn.removeEventListener(MouseEvent.CLICK, startLevel);
			startLevelBtn.gotoAndStop(2);				
			levelStarted = true;
			
			for(var i:int = specialToolsDisablesArray.length; --i >= 0;) removeObject(i, specialToolsDisablesArray);
		}
		
		private function startWave():void
		{
			if(currentWave <= enemyWaves.length)
			{
				for(var i:int = 0; i < enemyWaves[currentWave - 1].length; i++)
				{
					if(enemyWaves[currentWave - 1][i] != 0) enemiesLeft++;
				}
			}
			updateScoreBoard("txtWave");
			updateScoreBoard("txtEnemiesLeft");
		}
		
		private function makeLevel():void
		{
			var cols:int = mapCols;
			var rows:int = mapRows;
			var row:int = 0;
			var block:MovieClip;
			var roadTileID:int = 1;
						
			for(var i:int = 0; i < levelMap.length; i++)
			{
				if(levelMap[i] == G)
				{
					block = new GroundTile();
					block.x = (i - row * cols) * block.width;
					block.y = row * block.height;
					block.addEventListener(MouseEvent.CLICK, addMarkerCounter, false, 0, true);
					groundArray.push(block);
					blocksHolder.addChild(block);
					if(	levelMap[i-1] == P || levelMap[i-1] == S || levelMap[i-1] == F || levelMap[i-1] == U || levelMap[i-1] == D || levelMap[i-1] == R || levelMap[i-1] == L ||
					   	levelMap[i+1] == P || levelMap[i+1] == S || levelMap[i+1] == F || levelMap[i+1] == U || levelMap[i+1] == D || levelMap[i+1] == R || levelMap[i+1] == L ||
						levelMap[i-cols] == P || levelMap[i-cols] == S || levelMap[i-cols] == F || levelMap[i-cols] == U || levelMap[i-cols] == D || levelMap[i-cols] == R || levelMap[i-cols] == L ||
						levelMap[i+cols] == P || levelMap[i+cols] == S || levelMap[i+cols] == F || levelMap[i+cols] == U || levelMap[i+cols] == D || levelMap[i+cols] == R || levelMap[i+cols] == L) block.nearRoad = true;
				}
				else if(levelMap[i] == M)
				{
					block = new PlaceMarker();
					block.x = (i - row * cols) * block.width;
					block.y = row * block.height;
					block.addEventListener(MouseEvent.MOUSE_OVER, showRange, false, 0, true);
					block.addEventListener(MouseEvent.MOUSE_OUT, hideRange, false, 0, true);
					block.addEventListener(MouseEvent.CLICK, clickMarker, false, 0, true);
					markerArray.push(block);
					markerHolder.addChild(block);
				}
				else if(levelMap[i] == P)
				{
					block = new RoadTile("empty", (i - row * cols) * block.width, row * block.height);
					blocksHolder.addChild(block);
					roadArray.push(block);
				}
				else
				{
					block = new RoadTile(levelMap[i], (i - row * cols) * block.width, row * block.height)
					block.ID = roadTileID;
					roadTileID++;
					blocksHolder.addChild(block);
					directArray.push(block);
					roadArray.push(block);
										
					if(levelMap[i] == S)
					{
						if(block.x < 5 && block.x > -5)//starting from left of screen(direct to right)
						{
							roadStart = new Point(block.x, block.y + block.height * .5);
							Enemy.STARTING_DIRECTION = Enemy.DIR_RIGHT;
						}
						else if(block.x < (gameWidth - block.width + 5) && block.x > (gameWidth - block.width - 5))//starting from right(direct to left)
						{
							roadStart = new Point(block.x + block.width, block.y + block.height * .5);
							Enemy.STARTING_DIRECTION = Enemy.DIR_LEFT;
						}
						else if(block.y < 5 && block.y > -5)//starting from top(direct to down)
						{
							roadStart = new Point(block.x + block.width * .5, block.y);
							Enemy.STARTING_DIRECTION = Enemy.DIR_DOWN;
						}
						else if(block.y < (gameHeight - block.height + 5) && block.y > (gameHeight - block.height - 5))//starting from bottom(direct to up)
						{
							roadStart = new Point(block.x + block.width * .5, block.y + block.height);
							Enemy.STARTING_DIRECTION = Enemy.DIR_UP;
						}
					}
					else if(levelMap[i] == F)
					{
						block.tileNumber = 1;
						block.runID = runnerRoadID;
						runnerRoadID++;
						block.txtNum.text = String(block.tileNumber);
						enemyFinalTarget.x = block.x + block.width * .5;
						enemyFinalTarget.y = block.y + block.height * .5; 
						
						if(block.x < 5 && block.x > -5)//road ends at left
						{
							enemyFinalTarget.rotation = 0;
						}
						else if(block.x < (gameWidth - block.width + 5) && block.x > (gameWidth - block.width - 5))//road ends at right
						{
							enemyFinalTarget.rotation = 180;
						}
						else if(block.y < 5 && block.y > -5)//road ends at top
						{
							enemyFinalTarget.rotation = 90;
						}
						else if(block.y < (gameHeight - block.height + 5) && block.y > (gameHeight - block.height - 5))//road ends at bottom
						{
							enemyFinalTarget.rotation = -90;
						}
					}
				}
				
				for(var c:int = 1; c <= rows; c++)
				{
					if(i == c * cols - 1)
					row++;
				}
			}
			giveNumbersToRoad();
		}
		
		private function giveNumbersToRoad():void
		{
			var checkRoad:RoadTile;
			
			for each(var road:RoadTile in roadArray)
			{
				if(!road.tileNumber)
				{
					for(var r:int = 0; r <= roadArray.length-1; r++)
					{
						checkRoad = roadArray[r] as RoadTile;
						if(checkRoad.tileNumber)
						{
							if (checkRoad.hitTestPoint(road.x + road.width * 1.5, road.y + road.height *  .5) || 
								 checkRoad.hitTestPoint(road.x - road.width *  .5, road.y + road.height *  .5) ||
								 checkRoad.hitTestPoint(road.x + road.width *  .5, road.y - road.height *  .5) ||
								 checkRoad.hitTestPoint(road.x + road.width *  .5, road.y + road.height * 1.5))
							{
								road.tileNumber = roadCounter;
								road.txtNum.text = String(road.tileNumber);
								roadCounter++;
								if(road.direct != "empty"/* && road.direct != "Start"*/)
								{
									road.runID = runnerRoadID;
									runnerRoadID++;
								}
							}
						}
					}
				}
			}
			if(roadCounter <= roadArray.length) giveNumbersToRoad();
		}
		
		private function showOptions(e:MouseEvent):void
		{
			dispatchEvent(new CustomEvents(CustomEvents.SHOW_OPTIONS));
		}
		
		private function gameLoop(e:TimerEvent):void
		{
			stage.focus = this;
			checkBannersAndIntro();
			checkForEndLevel();
			if(Settings.SETTINGS_CHANGED) 																checkSettings();
			specialToolsInWork();
			if(installingArray.length > 0)																installTurrets();
			if(upgradingArray.length > 0)																	upgradeTurrets();
			if(uninstallingArray.length > 0) 															uninstallTurrets();
			if(addMarkerCounter.length > 0) 																checkMarkerCounter();
			if(currentWave <= enemyWaves.length && levelStarted) 									makeEnemies();
			checkEnemies();
			updateEnemies();
			if(particleArray.length > 0)																	updateExplosions();
			checkTurrets();
			updateBullets();
			if(enemiesLeft == 0 && !waveTimerInAction && currentWave < enemyWaves.length)	checkForNextWave();
			if(dropArray.length > 0) 																		checkDrop();
			if(placingFalseTarget) 																			checkRoadForFalseTarget();
		}
		
		private function checkBannersAndIntro():void
		{
			var intro:IntroduceScreen;
			var numIntros:int = (introScreensArray.length > 5)? 5: introScreensArray.length;;
			
			if(!levelStarted && startBanner)
			{
				if(startBanner.scaleX >= 1.04) startBanner.scaleBack = true;
				else if(startBanner.scaleX <=  .96) startBanner.scaleBack = false;
				if(startBanner.scaleBack)
				{
					startBanner.scaleX -= .02;
					startBanner.scaleY -= .02;
				}
				else
				{
					startBanner.scaleX += .02;
					startBanner.scaleY += .02;
				}
			}
			else if(levelStarted && startBanner)
			{
				userInterface.removeChild(startBanner);
				startBanner = null;
			}
						
			for(var i:int = numIntros; --i >= 0;)
			{
				intro = introScreensArray[i];
				intro.counter++;
				if(intro.y > (i * intro.height)) intro.y -= 5;
				else intro.y = i * intro.height;
				if(intro.comingOut) 
				{
					intro.x += intro.speed;
					if(intro.x >= intro.width * .5)
					{
						intro.comingOut = false;
						intro.x = intro.width * .5;
					}
				}
				else if(intro.leaving)
				{
					intro.x -= intro.speed;
					if(intro.x <= -intro.width * .5) removeObject(i, introScreensArray);
				}
				else if(intro.counter >= intro.timeToLeave) intro.leaving = true;
			}
		}
		
		private function clickIntro(e:MouseEvent):void
		{
			var intro:IntroduceScreen = e.currentTarget as IntroduceScreen;
			var frame:String = intro.introduceObject + "_Big";
			intro.removeEventListener(MouseEvent.CLICK, clickIntro);
			intro.gotoAndStop(frame);
			addChild(intro);
			introScreensArray.splice(introScreensArray.indexOf(intro), 1);
			checkBannersAndIntro();
			intro.addEventListener(MouseEvent.CLICK, closeIntro, false, 0, true);
			intro.x = gameWidth * .5;
			intro.y = gameHeight * .5;
			intro.buttonMode = false;
			introduceInWork = true;
			pauseGame();
		}
		
		private function closeIntro(e:MouseEvent):void
		{
			var intro:IntroduceScreen = e.currentTarget as IntroduceScreen;
			intro.removeEventListener(MouseEvent.CLICK, closeIntro);
			removeChild(intro);
			intro = null;
			introduceInWork = false;
			pauseGame(false);
		}
		
		public function pauseGame(pauseGame:Boolean = true)
		{
			var clip:MovieClip;
			var enemy:Enemy;
			
			switch(pauseGame)
			{
				case true:
				gameTimer.stop();
				for each(enemy in enemyArray)
				{
					clip = enemy.getChildByName("clip") as MovieClip;
					clip.gotoAndStop(clip.currentFrame);
				}
				break;
				
				case false:
				if(!introduceInWork)
				{
					gameTimer.start();
					for each(enemy in enemyArray)
					{
						if(!enemy.isStuned)
						{
							clip = enemy.getChildByName("clip") as MovieClip;
							clip.gotoAndPlay(clip.currentFrame);
						}
					}
				}
				break;
			}
		}
		
		private function checkSettings():void
		{
			for(var i:int = enemyArray.length; --i >=0;)
			{
				var enemy:Enemy = enemyArray[i];
				if(Settings.LIFEBAR_VISIBLE) enemy.lifeBar.visible = true;
				else if(!Settings.LIFEBAR_VISIBLE) enemy.lifeBar.visible = false;
			}
			
			Settings.SETTINGS_CHANGED = false;
		}
		
		private function specialToolsInWork():void
		{
			var cooldown:SpecialToolsCooldown;
			var gauge:MovieClip;
			var cFrame:int;
			var result:Number;
			
			specialToolsGauge = 0;
			for(var i:int = 0; i < specialToolsGaugeArray.length; i++)
			{
				gauge = specialToolsGaugeArray[i] as MovieClip;
				cFrame = gauge.currentFrame;
				if(cFrame < gauge.totalFrames) 
				{
					cFrame++;
					gauge.gotoAndStop(cFrame);
					break;
				}
				else specialToolsGauge++;
			}
			for(var k:int = specialToolsCooldownsArray.length; --k >= 0;)
			{
				cooldown = specialToolsCooldownsArray[k];
				cooldown.waitCounter++;
				//делим на два и после раунда на 10, чтобы получить десятые секунд и привести в соответсвие то, что считаем через gameTimer, а на выходе нужны секунды с десятыми
				result = Math.round((cooldown.timeToWait - cooldown.waitCounter) * .5) * .1;
				cooldown.txtCounter.text = String(result.toFixed(1));
				if((cooldown.timeToWait - cooldown.waitCounter) >= 200) cooldown.txtCounter.replaceText(2, cooldown.txtCounter.length, "");
				cooldown.gotoAndStop(Math.round((cooldown.timeToWait - cooldown.waitCounter) / cooldown.timeToWait * 100));
				if(cooldown.waitCounter >= cooldown.timeToWait) removeObject(k, specialToolsCooldownsArray);
			}
			
			if(falseTarget)
			{
				if(falseTarget.placed) falseTarget.lifeCounter++;
				result = Math.round((falseTarget.lifeTime - falseTarget.lifeCounter) * .5) * .1;
				falseTarget.txtLife.text = String(result.toFixed(1));
				if((falseTarget.lifeTime - falseTarget.lifeCounter) >= 200) falseTarget.txtLife.replaceText(2, falseTarget.txtLife.length, "");
				falseTarget.txtLife.appendText(" s");
				if(falseTarget.lifeCounter >= falseTarget.lifeTime || falseTarget.protectAmount <= 0)
				{
					falseTarget.parent.removeChild(falseTarget);
					falseTarget = null;
					for each(var enemy:Enemy in enemyArray) enemy.isFalseHacking = false;
				}
			}
			if(systemDamReduceInAction)
			{
				systemDamReduceTime++;
				if(systemDamReduceTime >= Variables.SPECIAL_SYS_DAMAGE_REDUCE_TIME)
				{
					systemDamReduceInAction = false;
					systemDamReduceTime = 0;
					Variables.SPECIAL_SYS_DAMAGE_MULTIPLY = 1;
					for each(enemy in enemyArray)
					{
						enemy.systemDamage = enemy.baseSystemDamage * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY;
						if(enemy is Enemy_Neirobot) enemy.systemDamage = enemy.baseSystemDamage * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY * Variables.NUM_NEIROBOTS;
						if(infoScreen && infoScreen.target == enemy) infoScreen.txtSystemDamage.text = String(enemy.systemDamage);
					}
				}
			}
		}
		
		private function makeEnemies():void
		{
			if(enemyTime < enemyLimit) enemyTime++;
			else
			{
				var id:int = enemyWaves[currentWave - 1][currentEnemy];
				var enemy:Enemy;
				switch(id)
				{
					case 1:
						enemy = new Enemy_Speeder();
						if(!Variables.INTRODUCE_SPEEDER) introduce(IntroduceScreen.SPEEDER);
					break;
					
					case 2:
						enemy = new Enemy_Worm();
						if(!Variables.INTRODUCE_WORM) introduce(IntroduceScreen.WORM);
					break;
					
					case 3:
						enemy = new Enemy_Recoder();
						if(!Variables.INTRODUCE_RECODER) introduce(IntroduceScreen.RECODER);
					break;
					
					case 4:
						enemy = new Enemy_Protector();
						if(!Variables.INTRODUCE_PROTECTOR) introduce(IntroduceScreen.PROTECTOR);
					break;
					
					case 5:
						enemy = new Enemy_Neirobot();
						if(!Variables.INTRODUCE_NEIROBOT) introduce(IntroduceScreen.NEIROBOT);
						Variables.NUM_NEIROBOTS++;
					break;
					
					case 6:
						enemy = new Enemy_Runner();
						if(!Variables.INTRODUCE_RUNNER) introduce(IntroduceScreen.RUNNER);
					break;
					
					case 7:
						enemy = new Enemy_Cycler();
						if(!Variables.INTRODUCE_CYCLER) introduce(IntroduceScreen.CYCLER);
					break;
					
					case 8:
						enemy = new Enemy_Emmiter();
						if(!Variables.INTRODUCE_EMMITER) introduce(IntroduceScreen.EMMITER);
					break;
					
					default:
						enemy = null;
					break;
				}
				if(enemy)
				{
					enemy.addEventListener(MouseEvent.CLICK, clickEnemy, false, 0, true);
					enemyArray.push(enemy);
					enemyHolder.addChild(enemy);
					enemy.direction = Enemy.STARTING_DIRECTION;
					switch(enemy.direction)
					{
						case Enemy.DIR_DOWN:
							enemy.x = roadStart.x;
							enemy.y = roadStart.y - enemy.width * .8;
						break;
							
						case Enemy.DIR_LEFT:
							enemy.x = roadStart.x + enemy.width * .8;
							enemy.y = roadStart.y;
						break;
							
						case Enemy.DIR_RIGHT:
							enemy.x = roadStart.x - enemy.width * .8;
							enemy.y = roadStart.y;
						break;
							
						case Enemy.DIR_UP:
							enemy.x = roadStart.x;
							enemy.y = roadStart.y + enemy.width * .8;
						break;
					}
					enemy.updateDirection(Enemy.STARTING_DIRECTION);
					enemy.updateLevel();
					currentEnemy++;
					enemyTime = 0;
					enemy.systemDamage = enemy.baseSystemDamage * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY;
					
					if(enemy is Enemy_Protector)
					{
						var tempEnemy:Enemy;
						for each(tempEnemy in enemyArray)
						{
							tempEnemy.health -= tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
							tempEnemy.maxHealth -= tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
						}
						Variables.NUM_PROTECTORS++;
						for each(tempEnemy in enemyArray)
						{
							tempEnemy.health += tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
							tempEnemy.maxHealth += tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
							if(infoScreen && infoScreen.target == tempEnemy) infoScreen.txtLife.text = String(tempEnemy.health);
						}
					}
					if(enemy is Enemy_Runner) enemy.runnerTargetID = runnerRoadID-1;
					if(enemy is Enemy_Neirobot)
					{
						for each(var neiro:Enemy_Neirobot in enemyArray)
						{
							neiro.systemDamage = neiro.baseSystemDamage * Variables.NUM_NEIROBOTS * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY;
							if(infoScreen && infoScreen.target == neiro) infoScreen.txtSystemDamage.text = String(neiro.systemDamage);
						}
					}
				}
			}
		}
		
		private function clickEnemy(e:MouseEvent):void
		{
			e.stopPropagation();
			unClick();
			var enemy:Enemy = e.currentTarget as Enemy;
			var clip:MovieClip = enemy.getChildByName("clip") as MovieClip;
			enemyFrame = new EnemyFrame();
			enemyFrame.width = clip.width + 10;
			enemyFrame.height = clip.height + 10;
			enemy.addChild(enemyFrame);
			enemyFrame.target = enemy;
			showEnemyInfo(e);
		}
		
		private function unClick(e:MouseEvent = null):void
		{
			//e.stopPropagation();
			if(enemyFrame)
			{
				enemyFrame.parent.removeChild(enemyFrame);
				enemyFrame = null;
			}
			if(chooseTurretCircle)
			{
				chooseTurretCircle.turret_gun.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_gun.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_gun.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				chooseTurretCircle.turret_launcher.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_launcher.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_launcher.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				chooseTurretCircle.turret_freeze.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_freeze.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_freeze.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				chooseTurretCircle.turret_swarm.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_swarm.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_swarm.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				turretHolder.removeChild(chooseTurretCircle);
				chooseTurretCircle = null;
			}
			if(confirmTurretCircle)
			{
				confirmTurretCircle.buyTurret.removeEventListener(MouseEvent.CLICK, confirmTurret);
				confirmTurretCircle.cancelTurret.removeEventListener(MouseEvent.CLICK, cancelTurret);
				turretHolder.removeChild(confirmTurretCircle);
				confirmTurretCircle = null;
			}
			if(charMenu)
			{
				charMenu.sellBtn.removeEventListener(MouseEvent.CLICK, startUninstallTurret);
				turretHolder.removeChild(charMenu);
				charMenu = null;
			}
			if(rangeCircle)
			{
				rangeCircle.graphics.clear();
				removeChild(rangeCircle);
				rangeCircle = null;
			}
			if(infoScreen) removeInfoScreen();
		}
				
		private function checkEnemies():void
		{
			for(var i:int = enemyArray.length; --i >= 0;)
			{
				var enemy:Enemy = enemyArray[i];
				if(enemy.health <= 0)
				{
					createExplosion(enemy.x, enemy.y, enemy.levelColor, "killed");
					if((Math.random() * 100) <= Variables.SYMBOLS_DROP_CHANCE) drop(enemy.x, enemy.y, enemy.symbolsDrop, Drop.DROP_SYMBOLS);
					if((Math.random() * 100) <= Variables.MEMORY_DROP_CHANCE) drop(enemy.x, enemy.y, enemy.memoryDrop, Drop.DROP_MEMORY);
					if((Math.random() * 100) <= Variables.PROTECT_DROP_CHANCE && systemProtection < 100) drop(enemy.x, enemy.y, enemy.protectDrop, Drop.DROP_PROTECT);
					enemy.removeEventListener(MouseEvent.CLICK, clickEnemy);
					removeObject(i, enemyArray);
					enemiesLeft--;
					updateScoreBoard("txtEnemiesLeft");
					if(enemy is Enemy_Neirobot)
					{
						Variables.NUM_NEIROBOTS--;
						for each(var neiro:Enemy_Neirobot in enemyArray)
						{
							neiro.systemDamage = neiro.baseSystemDamage * Variables.NUM_NEIROBOTS * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY;
							if(infoScreen && infoScreen.target == neiro) infoScreen.txtSystemDamage.text = String(neiro.systemDamage);
						}
					}
					if(enemy is Enemy_Protector)
					{
						var tempEnemy:Enemy;
						for each(tempEnemy in enemyArray)
						{
							tempEnemy.health -= tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
							tempEnemy.maxHealth -= tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
						}
						Variables.NUM_PROTECTORS--;
						for each(tempEnemy in enemyArray)
						{
							tempEnemy.health += tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
							tempEnemy.maxHealth += tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
							if(infoScreen && infoScreen.target == tempEnemy) infoScreen.txtLife.text = String(tempEnemy.health);
						}
					}
					if(infoScreen && infoScreen.target == enemy) removeInfoScreen();
				}
			}
		}
		
		private function updateEnemies():void
		{
			var enemy:Enemy;
			var road:RoadTile;
			var clip:MovieClip;
			var distance:Number;
			
			var enemyLength:int = enemyArray.length;
			
			for(var i:int = enemyLength; --i >= 0;)
			{
				enemy = enemyArray[i];
				enemy.graphPoint.graphics.clear();
				clip = enemy.getChildByName("clip") as MovieClip;
				clip.gotoAndPlay(clip.currentFrame);
				
				if(enemy.thisTurnCloudTouched) enemy.thisTurnCloudTouched = false;
				if(enemy.isHealing) enemy.removeStatus(Enemy.STATUS_HEAL);
				
				for(var r:int = 0; r < roadArray.length; r++)
				{
					road = roadArray[r];
					if(enemy.tileNumPoint.hitTestObject(road) && (road.tileNumber != enemy.tileNum)) enemy.tileNum = road.tileNumber;
				}
				
				for(var j:int = 0; j < directArray.length; j++)
				{
					var dirTile:MovieClip = directArray[j];
					if(enemy.hitPoint.hitTestObject(dirTile.hitPoint) && enemy.roadID != dirTile.ID)
					{
						enemy.updateDirection(dirTile.direct);
						enemy.roadID = dirTile.ID;
					}
				}
				
				if(enemy.stunProlonger)
				{
					for(var e:int = enemyArray.length; --e >= 0;)
					{
						var tempEnemy:Enemy = enemyArray[e];
						if(tempEnemy != enemy)
						{
							var xDest:Number = tempEnemy.x - enemy.x;
							var yDest:Number = tempEnemy.y - enemy.y;
							distance = Math.sqrt(xDest*xDest + yDest*yDest);
							if(distance <= Variables.FREEZE_MULTY_STUN_DISTANCE)
							{
 								tempEnemy.addStatus(Enemy.STATUS_STUN);
								
								enemy.graphPoint.rotation = -enemy.rotation;
								with(enemy.graphPoint.graphics)
								{
									lineStyle(2, 0xFF00FF);
									moveTo(0, 0);
									lineTo(tempEnemy.x - enemy.x, tempEnemy.y - enemy.y);
								}
								clip = tempEnemy.getChildByName("clip") as MovieClip;
								clip.gotoAndStop(clip.currentFrame);
								clip = null;
							}
						}
					}
					enemy.stunProlonger = false;
				}
				if(flowStopInAction && !enemy.isStuned) enemy.addStatus(Enemy.STATUS_STUN);
				if(enemy.isStuned)
				{
					if(enemy.speed > 0) enemy.speed -= enemy.stoppingSpeed;
					else enemy.speed = 0;
					
					clip.gotoAndStop(clip.currentFrame);
					
					if(enemy.underFreeze) enemy.removeStatus(Enemy.STATUS_FREEZE);
					if(!flowStopInAction) 
					{
						enemy.stunCounter++;
						if(enemy.stunCounter > enemy.maxTimeStuned) enemy.removeStatus(Enemy.STATUS_STUN);
					}
				}
				if(enemy.speedUP)
				{
					enemy.speed += enemy.stoppingSpeed;
					if(enemy.speed >= enemy.baseSpeed)
					{
						enemy.speed = enemy.baseSpeed;
						enemy.speedUP = false;
					}
				}
				if(enemy.underFreeze)
				{
					enemy.freezeCounter++;
					if(enemy.freezeCounter > enemy.maxTimeFreeze) 
					{
						enemy.removeStatus(Enemy.STATUS_FREEZE);
						enemy.speed = enemy.baseSpeed;
					}
				}
				
				switch(enemy.direction)
				{
					case Enemy.DIR_DOWN:
						enemy.xSpeed = 0;
						enemy.ySpeed = enemy.speed;
					break;
					
					case Enemy.DIR_LEFT:
						enemy.xSpeed = -enemy.speed;
						enemy.ySpeed = 0;
					break;
					
					case Enemy.DIR_RIGHT:
						enemy.xSpeed = enemy.speed;
						enemy.ySpeed = 0;
					break;
					
					case Enemy.DIR_UP:
						enemy.xSpeed = 0;
						enemy.ySpeed = -enemy.speed;
					break;
				}
				
				if(enemy.isPoisoned)
				{
					enemy.calcDamage(Variables.LAUNCHER_POISON_DAMAGE);
					if(infoScreen && infoScreen.target == enemy) infoScreen.txtLife.text = String(enemy.health);
					createExplosion(enemy.x, enemy.y, enemy.levelColor);
					enemy.poisonCounter++;
					if(enemy.poisonCounter > enemy.maxPoisonCounter) enemy.removeStatus(Enemy.STATUS_POISON);
				}
				if(enemy.touchCloud) enemy.removeStatus(Enemy.STATUS_CLOUD);
				
				if(clip.hitTestObject(enemyFinalTarget) && !enemy.isStuned)
				{
					enemy.speed = 0;
					enemy.xSpeed = enemy.ySpeed = 0;
					if(systemProtection > 0)
					{
						systemProtection -= enemy.systemDamage;
						if(systemProtection <= 0) systemProtection = 0;
						clip.gotoAndStop(clip.currentFrame);
						updateScoreBoard("txtSystem");
					}
					else if(systemProtection <= 0)
					{
						systemProtection = 0;
						checkForHack(enemy, i);
					}
				}
				if(falseTarget)
				{
					if(clip.hitTestObject(falseTarget) && falseTarget.placed) enemy.isFalseHacking = true; 
				}
				if(!enemy.isFalseHacking)
				{
					enemy.x += enemy.xSpeed;
					enemy.y += enemy.ySpeed;
				}
				if(enemy.isFalseHacking && falseTarget && !enemy.isStuned)
				{
					falseTarget.protectAmount -= enemy.systemDamage;
					clip.gotoAndStop(clip.currentFrame);
					falseTarget.txtProtection.text = String(Number(falseTarget.protectAmount).toFixed(1)) + " %";
					if(falseTarget.protectAmount <= 0) falseTarget.txtProtection.text = "0.0 %";
				}
				
				if(enemy is Enemy_Recoder && !enemy.isStuned)
				{
					for(var o:int = enemyArray.length; --o >= 0;)
					{
						var healTarget:Enemy = enemyArray[o];
						if(healTarget.health < healTarget.maxHealth)
						{
							distance = Math.sqrt(Math.pow(healTarget.x - enemy.x,2) + Math.pow(healTarget.y - enemy.y,2));
							if(distance <= enemy.healDistance)
							{
								healTarget.calcDamage(-enemy.healAmount);
								if(infoScreen && infoScreen.target == healTarget) infoScreen.txtLife.text = String(healTarget.health);
								healTarget.addStatus(Enemy.STATUS_HEAL);
								enemy.graphPoint.rotation = -enemy.rotation;
								with(enemy.graphPoint.graphics)
								{
									lineStyle(2, 0x00FF00);
									lineTo(healTarget.x - enemy.x, healTarget.y - enemy.y);
								}
							}
							break;
						}
					}
				}
				
				if(enemy is Enemy_Runner && !enemy.isStuned && !enemy.speedUP)
				{
					if(enemy.underFreeze) enemy.maxSpeed = 6;
					else enemy.maxSpeed = 12;
					
					for each(var roadTile:RoadTile in roadArray)
					{
						if(enemy.runnerTargetID == roadTile.runID)
						{
							var xDestin:int = roadTile.x + roadTile.width * .5;
							var yDestin:int = roadTile.y + roadTile.height * .5;
							distance = Math.sqrt(Math.pow(xDestin - enemy.x, 2) + Math.pow(yDestin - enemy.y, 2));
							
							if(distance > enemy.runnerBrakeDist) enemy.speed += enemy.stoppingSpeed;
							if(enemy.speed > enemy.maxSpeed) enemy.speed = enemy.maxSpeed;
							
							if(distance < enemy.runnerBrakeDist) enemy.speed -= enemy.stoppingSpeed;
							if(enemy.speed < enemy.baseSpeed) enemy.speed = enemy.baseSpeed;
						}
					}
				}
				
				if(enemy is Enemy_Emmiter && !enemy.isFalseHacking && !enemy.isStuned && !clip.hitTestObject(enemyFinalTarget))
				{
					enemy.bugsWaitTime++;
					if(enemy.bugsWaitTime >= enemy.bugsAppearTime)
					{
						var bug:Enemy = new Enemy_Bug();
						bug.x = enemy.x;
						bug.y = enemy.y;
						enemyHolder.addChildAt(bug, enemy.parent.getChildIndex(enemy));
						enemyArray.push(bug);
						bug.updateDirection(enemy.direction);
						enemy.bugsWaitTime = 0;
						enemiesLeft++;
					}
				}
				
				for(var m:int = minesArray.length; --m >= 0;)
				{
					if(enemy.hitTestObject(minesArray[m])) mineExplosion(m);
				}
			}
			if(flowStopInAction) flowStopCounter--;
			if(flowStopCounter <= 0  && flowStopInAction)
			{
				flowStopInAction = false;
				for each(enemy in enemyArray)
				{
					enemy.removeStatus(Enemy.STATUS_STUN);
					clip = enemy.getChildByName("clip") as MovieClip;
					clip.gotoAndPlay(clip.currentFrame);
					clip = null;
				}
			}
			
			for(var h:int = hackingEnemies.length; --h >= 0;)
			{
				enemy = hackingEnemies[h];
				enemy.alpha -= .2;
				if(enemy.alpha <= 0) removeObject(h, hackingEnemies);
			}
		}
		
		private function mineExplosion(m:int):void
		{
			var mine:Mine = minesArray[m];
			var mineExplode:MineExplode = new MineExplode();
			mineExplode.x = mine.x;
			mineExplode.y = mine.y;
			roadHolder.addChild(mineExplode);
			var enemy:Enemy;
			var distX:int;
			var distY:int;
			var distance:int;
			for(var i:int = enemyArray.length; --i >= 0;)
			{
				enemy = enemyArray[i];
				distX = enemy.x - mine.x;
				distY = enemy.y - mine.y;
				distance = Math.sqrt(distX*distX + distY*distY);
				if(distance < Variables.SPECIAL_MINES_DISTANCE)
				{
					enemy.calcDamage(Variables.SPECIAL_MINES_DAMAGE);
					createExplosion(enemy.x, enemy.y, enemy.levelColor);
				}
			}
			minesArray.splice(m, 1);
			mine.parent.removeChild(mine);
			mine = null;
		}
		
		private function introduce(target:String):void
		{
			introScreen = new IntroduceScreen(target);
			introScreen.addEventListener(MouseEvent.CLICK, clickIntro, false, 0, true);
			introScreen.gotoAndStop(target);
			introScreen.x = -introScreen.width * .5;
			introScreensArray.push(introScreen);
			introduceHolder.addChild(introScreen);
		}
				
		private function showBaseTurretInfo(e:MouseEvent):void
		{
			if(infoScreen) removeInfoScreen();
			
			var type:String;
			if(e.currentTarget.charType) type = e.currentTarget.charType;
			else type = e.currentTarget.name;
			
			switch(type)
			{
				case Turret.TURRET_GUN:
					tempChar = new GunTurret();
					if(Variables.UPGRADE_GUN_MASTERED) tempChar.level = 3;
				break;
					
				case Turret.TURRET_LAUNCHER:
					tempChar = new LauncherTurret();
					if(Variables.UPGRADE_LAUNCHER_MASTERED) tempChar.level = 3;
				break;
					
				case Turret.TURRET_SWARM:
					tempChar = new SwarmTurret();
					if(Variables.UPGRADE_SWARM_MASTERED) tempChar.level = 3;
				break;
					
				case Turret.TURRET_FREEZE:
					tempChar = new FreezeTurret();
					if(Variables.UPGRADE_FREEZE_MASTERED) tempChar.level = 3;
				break;
			}
				
			tempChar.updateLevel();
			
			infoScreen = new InfoScreen();
			infoScreen.target = tempChar;
			infoScreen.gotoAndStop("turret")
				
			if(type == Turret.TURRET_GUN) infoScreen.txtName.text 			= "Gun";
			else if(type == Turret.TURRET_LAUNCHER) infoScreen.txtName.text = "Launcher";
			else if(type == Turret.TURRET_SWARM) infoScreen.txtName.text 	= "Swarm";
			else if(type == Turret.TURRET_FREEZE) infoScreen.txtName.text 	= "Freeze";
				
			infoScreen.txtLevelOrCost.text 		= "$: " + tempChar.memoryUse;
			infoScreen.txtDamage.text			= tempChar.damage;
			infoScreen.txtRange.text 			= tempChar.range;
			infoScreen.txtReloadTime.text 		= String(Number(tempChar.reloadTime * .05).toFixed(2));
			if(tempChar is SwarmTurret) infoScreen.txtDamage.appendText("x" + tempChar.numMissiles);
				
			infoScreen.x = gameWidth;
			infoScreen.y = gameHeight;
			charHolder.addChild(infoScreen);
		}
		
		private function showTurretInfo(e:MouseEvent):void
		{
			if(infoScreen) removeInfoScreen();
			var char:Turret = e.currentTarget as Turret;
			
			infoScreen = new InfoScreen();
			infoScreen.target = char;
			infoScreen.gotoAndStop("turret")
				
			if(char.type == Turret.TURRET_GUN) infoScreen.txtName.text 				= "Gun";
			else if(char.type == Turret.TURRET_LAUNCHER) infoScreen.txtName.text 	= "Launcher";
			else if(char.type == Turret.TURRET_SWARM) infoScreen.txtName.text 		= "Swarm";
			else if(char.type == Turret.TURRET_FREEZE) infoScreen.txtName.text 		= "Freeze";
				
			infoScreen.txtLevelOrCost.text 		= "$: " + char.memoryUse;
			infoScreen.txtDamage.text			= String(char.damage);
			infoScreen.txtRange.text 			= String(char.range);
			infoScreen.txtReloadTime.text 		= String(Number(char.reloadTime * .05).toFixed(2));
			if(char is SwarmTurret) infoScreen.txtDamage.appendText("x" + char.numMissiles);
			
			infoScreen.x = gameWidth;
			infoScreen.y = gameHeight;
			charHolder.addChild(infoScreen);
		}
		
		private function showEnemyInfo(e:MouseEvent):void
		{
			if(infoScreen) removeInfoScreen();
			var char:Enemy = e.currentTarget as Enemy;
			
			infoScreen = new InfoScreen();
			infoScreen.target = char;
			infoScreen.gotoAndStop("enemy");
			
			infoScreen.txtName.text 		= char.type;
			infoScreen.txtLife.text 		= String(char.health);
			infoScreen.txtSpeed.text 		= String(char.baseSpeed);
			infoScreen.txtSystemDamage.text = String(char.systemDamage);
			infoScreen.txtHackChance.text 	= String(char.hackChance);
			
			infoScreen.setPriorityBtn.addEventListener(MouseEvent.CLICK, setPriorityEnemy, false, 0, true);
			
			infoScreen.x = gameWidth;
			infoScreen.y = gameHeight;
			charHolder.addChild(infoScreen);
		}
				
		private function removeInfoScreen(e:MouseEvent = null):void
		{
			if(infoScreen)
			{
				infoScreen.parent.removeChild(infoScreen);
				infoScreen = null;
			}
		}
		
		private function showChooseInfo(e:MouseEvent):void
		{
			if(infoScreen) removeInfoScreen();
			if(confirmTurretCircle)
			{
				switch(confirmTurretCircle.turretType)
				{
					case Turret.TURRET_GUN:
						tempChar = new GunTurret();
						if(Variables.UPGRADE_GUN_MASTERED) tempChar.level = 3;
					break;
					
					case Turret.TURRET_LAUNCHER:
						tempChar = new LauncherTurret();
						if(Variables.UPGRADE_LAUNCHER_MASTERED) tempChar.level = 3;
					break;
					
					case Turret.TURRET_SWARM:
						tempChar = new SwarmTurret();
						if(Variables.UPGRADE_SWARM_MASTERED) tempChar.level = 3;
					break;
					
					case Turret.TURRET_FREEZE:
						tempChar = new FreezeTurret();
						if(Variables.UPGRADE_FREEZE_MASTERED) tempChar.level = 3;
					break;
				}
				
				tempChar.updateLevel();
			
				infoScreen = new InfoScreen();
				infoScreen.target = tempChar;
				infoScreen.gotoAndStop("turret")
				
				if(confirmTurretCircle.turretType == Turret.TURRET_GUN) infoScreen.txtName.text 			= "Gun";
				else if(confirmTurretCircle.turretType == Turret.TURRET_LAUNCHER) infoScreen.txtName.text 	= "Launcher";
				else if(confirmTurretCircle.turretType == Turret.TURRET_SWARM) infoScreen.txtName.text 		= "Swarm";
				else if(confirmTurretCircle.turretType == Turret.TURRET_FREEZE) infoScreen.txtName.text 	= "Freeze";
				
				infoScreen.txtLevelOrCost.text 		= "$: " + tempChar.memoryUse;
				infoScreen.txtDamage.text			= tempChar.damage;
				infoScreen.txtRange.text 			= tempChar.range;
				infoScreen.txtReloadTime.text 		= String(Number(tempChar.reloadTime * .05).toFixed(2));
				if(tempChar is SwarmTurret) infoScreen.txtDamage.appendText("x" + tempChar.numMissiles);
				
				infoScreen.x = gameWidth;
				infoScreen.y = gameHeight;
				charHolder.addChild(infoScreen);
			}
			if(charMenu)
			{
				var char:Turret = charMenu.target;
			
				infoScreen = new InfoScreen();
				infoScreen.target = char;
				infoScreen.gotoAndStop("turret")
				
				if(char.type == Turret.TURRET_GUN) infoScreen.txtName.text 				= "Gun";
				else if(char.type == Turret.TURRET_LAUNCHER) infoScreen.txtName.text 	= "Launcher";
				else if(char.type == Turret.TURRET_SWARM) infoScreen.txtName.text 		= "Swarm";
				else if(char.type == Turret.TURRET_FREEZE) infoScreen.txtName.text 		= "Freeze";
				
				infoScreen.txtLevelOrCost.text 		= "$: " + char.memoryUse;
				infoScreen.txtDamage.text			= String(char.damage);
				infoScreen.txtRange.text 			= String(char.range);
				infoScreen.txtReloadTime.text 		= String(Number(char.reloadTime * .05).toFixed(2));
				if(char is SwarmTurret) infoScreen.txtDamage.appendText("x" + char.numMissiles);
				
				infoScreen.x = gameWidth;
				infoScreen.y = gameHeight;
				charHolder.addChild(infoScreen);
			}
			if(enemyFrame)
			{
				infoScreen = new InfoScreen();
				infoScreen.target = enemyFrame.target;
				infoScreen.gotoAndStop("enemy");
			
				infoScreen.txtName.text 		= enemyFrame.target.type;
				infoScreen.txtLife.text 		= String(enemyFrame.target.health);
				infoScreen.txtSpeed.text 		= String(enemyFrame.target.baseSpeed);
				infoScreen.txtSystemDamage.text = String(enemyFrame.target.systemDamage);
				infoScreen.txtHackChance.text 	= String(enemyFrame.target.hackChance);
				
				infoScreen.x = gameWidth;
				infoScreen.y = gameHeight;
				charHolder.addChild(infoScreen);
			}
		}
		
		public function setPriorityEnemy(e:MouseEvent):void
		{
			e.stopPropagation();
			if(e.currentTarget.parent.target.isPriority)
			{
				e.currentTarget.parent.target.isPriority = false;
				e.currentTarget.parent.target.removeChild(priorityMark);
			}
			else
			{
				for each(var enemy:Enemy in enemyArray)
				{
					if(enemy.isPriority)
					{
						enemy.isPriority = false;
						enemy.removeChild(priorityMark);
					}
				}
				e.currentTarget.parent.target.isPriority = true;
				e.currentTarget.parent.target.addChild(priorityMark);
			}
		}
		
		private function dragIcon(e:MouseEvent):void
		{
			if(addingMarker || placingFalseTarget || turretRelocatingON){}
			else
			{
				unClick(e);			
				var charCost:int = e.currentTarget.memoryUse;
				if(memoryTotal >= (memoryUsed + charCost))
				{
					dragCharIcon = new CharIcon(e.currentTarget.charType);
					dragCharIcon.memoryUse = charCost;
					dragCharIcon.range = e.currentTarget.range;
				
					switch(e.currentTarget.charType)
					{
						case Turret.TURRET_GUN:
							dragCharIcon.gotoAndStop("gunTurret");
						break;
				
						case Turret.TURRET_LAUNCHER:
							dragCharIcon.gotoAndStop("launcherTurret");
						break;
					
						case Turret.TURRET_SWARM:
							dragCharIcon.gotoAndStop("swarmTurret");
						break;
					
						case Turret.TURRET_FREEZE:
							dragCharIcon.gotoAndStop("freezeTurret");
						break;
					}
					dragCharIcon.x = stage.mouseX;
					dragCharIcon.y = stage.mouseY;
					dragCharIcon.mouseEnabled = false;
					dragCharIcon.mouseChildren = false;
					addChild(dragCharIcon);
					dragCharIcon.startDrag();
					dragging = true;
				}
				else trace("not enought memory");
			
				stage.addEventListener(MouseEvent.MOUSE_UP, dropIcon, false, 0, true);
			}
		}
		
		private function dropIcon(e:MouseEvent):void
		{
			dragging = false
			if(dragCharIcon)
			{
				for each(var marker:PlaceMarker in markerArray)
				{
					if(marker.free)
					{
						if(stage.mouseX > marker.x && stage.mouseX < marker.x + marker.width &&
						   stage.mouseY > marker.y && stage.mouseY < marker.y + marker.height)
						{
							switch(dragCharIcon.charType)
							{
								case "turret_gun": 		startInstallTurret(dragCharIcon.charType, Variables.GUN_START_LEVEL, marker.x, marker.y); 		break;
								case "turret_launcher": startInstallTurret(dragCharIcon.charType, Variables.LAUNCHER_START_LEVEL, marker.x, marker.y); 	break;
								case "turret_swarm": 	startInstallTurret(dragCharIcon.charType, Variables.SWARM_START_LEVEL, marker.x, marker.y); 	break;
								case "turret_freeze": 	startInstallTurret(dragCharIcon.charType, Variables.FREEZE_START_LEVEL, marker.x, marker.y); 	break;
							}
							marker.free = false;
						}
					}
				}
				stage.removeEventListener(MouseEvent.MOUSE_UP, dropIcon);
				dragCharIcon.stopDrag();
				dragCharIcon.parent.removeChild(dragCharIcon);
				dragCharIcon = null;
			}
		}
		
		private function showRange(e:MouseEvent):void
		{
			var marker:Object = e.currentTarget;
			if(dragging && dragCharIcon && marker.free)
			{
				var range:int = dragCharIcon.range;
				rangeCircle = new Shape();
				rangeCircle.graphics.beginFill(0x33FFFF, .2);
				rangeCircle.graphics.drawCircle(0, 0, range);
				rangeCircle.graphics.endFill();
				rangeCircle.x = marker.x + marker.width * .5;
				rangeCircle.y = marker.y + marker.height * .5;
				baseRangeCircle = true;
				addChild(rangeCircle);
			}
		}
		
		private function hideRange(e:MouseEvent):void
		{
			if(rangeCircle && baseRangeCircle) 
			{
				rangeCircle.graphics.clear();
				removeChild(rangeCircle);
				rangeCircle = null;
				baseRangeCircle = false;
			}
		}
		
		private function showBuyTurretInfo(e:MouseEvent):void
		{
			if(e.currentTarget.free)
			{
				e.stopPropagation();
				chooseTurretCircle = new ChooseTurretCircle();
				chooseTurretCircle.targetMarker = e.currentTarget;
				
				chooseTurretCircle.turret_gun.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				chooseTurretCircle.turret_gun.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
				chooseTurretCircle.turret_gun.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				
				chooseTurretCircle.turret_launcher.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				chooseTurretCircle.turret_launcher.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
				chooseTurretCircle.turret_launcher.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				
				chooseTurretCircle.turret_freeze.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				chooseTurretCircle.turret_freeze.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
				chooseTurretCircle.turret_freeze.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				
				chooseTurretCircle.turret_swarm.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				chooseTurretCircle.turret_swarm.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
				chooseTurretCircle.turret_swarm.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				
				
				chooseTurretCircle.x = e.currentTarget.x + e.currentTarget.width * .5;
				chooseTurretCircle.y = e.currentTarget.y + e.currentTarget.height * .5;
				turretHolder.addChild(chooseTurretCircle);
			}
		}
		
		private function buyTurret(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				
				case "turret_gun":
				if(memoryTotal < (memoryUsed + Variables.GUN_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
				
				case "turret_launcher":
				if(memoryTotal < (memoryUsed + Variables.LAUNCHER_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
				
				case "turret_swarm":
				if(memoryTotal < (memoryUsed + Variables.SWARM_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
				
				case "turret_freeze":
				if(memoryTotal < (memoryUsed + Variables.FREEZE_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
				
				default:
					trace("wrong name: " + e.currentTarget.name + " in buyTurret");
				break;
			}
			e.stopPropagation();
			
			confirmTurretCircle = new ConfirmTurretCircle();
			confirmTurretCircle.targetMarker = chooseTurretCircle.targetMarker;
			
			if(chooseTurretCircle)
			{
				chooseTurretCircle.turret_gun.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_gun.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_gun.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				chooseTurretCircle.turret_launcher.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_launcher.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_launcher.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				chooseTurretCircle.turret_freeze.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_freeze.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_freeze.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				chooseTurretCircle.turret_swarm.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.turret_swarm.removeEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo);
				chooseTurretCircle.turret_swarm.removeEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen);
				
				turretHolder.removeChild(chooseTurretCircle);
				chooseTurretCircle = null;
			}
			
			confirmTurretCircle.buyTurret.addEventListener(MouseEvent.CLICK, confirmTurret, false, 0, true);
			confirmTurretCircle.cancelTurret.addEventListener(MouseEvent.CLICK, cancelTurret, false, 0, true);
			confirmTurretCircle.x = e.currentTarget.parent.x;
			confirmTurretCircle.y = e.currentTarget.parent.y;
			turretHolder.addChild(confirmTurretCircle);
			
			switch(e.currentTarget.name)
			{
				case "turret_gun":
				tempChar = new GunTurret();
				if(Variables.UPGRADE_GUN_MASTERED) tempChar.level = 3;
				confirmTurretCircle.turretType = Turret.TURRET_GUN;
				break;
				
				case "turret_launcher":
				tempChar = new LauncherTurret();
				confirmTurretCircle.abilityTxt.text = "Splash";
				if(Variables.UPGRADE_LAUNCHER_MASTERED) tempChar.level = 3;
				confirmTurretCircle.turretType = Turret.TURRET_LAUNCHER;
				break;
				
				case "turret_swarm":
				tempChar = new SwarmTurret();
				confirmTurretCircle.abilityTxt.text = "Swarm";
				if(Variables.UPGRADE_SWARM_MASTERED) tempChar.level = 3;
				confirmTurretCircle.turretType = Turret.TURRET_SWARM;
				break;
				
				case "turret_freeze":
				tempChar = new FreezeTurret();
				confirmTurretCircle.abilityTxt.text = "Freeze";
				if(Variables.UPGRADE_FREEZE_MASTERED) tempChar.level = 3;
				confirmTurretCircle.turretType = Turret.TURRET_FREEZE;
				break;
			}
			
			tempChar.updateLevel();
			
			confirmTurretCircle.damageTxt.text = tempChar.damage;
			if(tempChar is SwarmTurret) confirmTurretCircle.damageTxt.appendText("x" + tempChar.numMissiles);
			var range:int = tempChar.range;
			rangeCircle = new Shape();
			rangeCircle.graphics.beginFill(0x00FF00, .3);
			rangeCircle.graphics.drawCircle(0, 0, range);
			rangeCircle.graphics.endFill();
			rangeCircle.x = confirmTurretCircle.x;
			rangeCircle.y = confirmTurretCircle.y;
			addChild(rangeCircle);
		}
		
		private function confirmTurret(e:MouseEvent):void
		{
			if(tempChar) tempChar = null;
						
			var marker:MovieClip = confirmTurretCircle.targetMarker;
			switch(confirmTurretCircle.turretType)
			{
				case "turret_gun":		startInstallTurret(confirmTurretCircle.turretType, Variables.GUN_START_LEVEL, marker.x, marker.y); 		break;
				case "turret_launcher":	startInstallTurret(confirmTurretCircle.turretType, Variables.LAUNCHER_START_LEVEL, marker.x, marker.y);	break;
				case "turret_swarm":	startInstallTurret(confirmTurretCircle.turretType, Variables.SWARM_START_LEVEL, marker.x, marker.y);	break;
				case "turret_freeze":	startInstallTurret(confirmTurretCircle.turretType, Variables.FREEZE_START_LEVEL, marker.x, marker.y);	break;
			}
			
			for each(var mark:PlaceMarker in markerArray)
			{
				if(marker == mark) marker.free = false;
			}
		}
		
		private function cancelTurret(e:MouseEvent):void
		{
			e.stopPropagation();
			
			chooseTurretCircle = new ChooseTurretCircle();
			chooseTurretCircle.targetMarker = confirmTurretCircle.targetMarker;
			
			if(confirmTurretCircle)
			{
				confirmTurretCircle.buyTurret.removeEventListener(MouseEvent.CLICK, confirmTurret);
				confirmTurretCircle.cancelTurret.removeEventListener(MouseEvent.CLICK, cancelTurret);
				turretHolder.removeChild(confirmTurretCircle);
				confirmTurretCircle = null;
			}
			
			chooseTurretCircle.turret_gun.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
			chooseTurretCircle.turret_gun.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
			chooseTurretCircle.turret_gun.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				
			chooseTurretCircle.turret_launcher.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
			chooseTurretCircle.turret_launcher.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
			chooseTurretCircle.turret_launcher.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				
			chooseTurretCircle.turret_freeze.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
			chooseTurretCircle.turret_freeze.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
			chooseTurretCircle.turret_freeze.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
			
			chooseTurretCircle.turret_swarm.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
			chooseTurretCircle.turret_swarm.addEventListener(MouseEvent.MOUSE_OVER, showBaseTurretInfo, false, 0, true);
			chooseTurretCircle.turret_swarm.addEventListener(MouseEvent.MOUSE_OUT, removeInfoScreen, false, 0, true);
				
			chooseTurretCircle.x = e.currentTarget.parent.x;
			chooseTurretCircle.y = e.currentTarget.parent.y;
			turretHolder.addChild(chooseTurretCircle);
			
			if(rangeCircle)
			{
				rangeCircle.graphics.clear();
				removeChild(rangeCircle);
				rangeCircle = null;
			}
		}
		
		private function startInstallTurret(turretType:String, turLevel:int, xVal:int, yVal:int):void
		{
			if(rangeCircle)
			{
				rangeCircle.graphics.clear();
				removeChild(rangeCircle);
				rangeCircle = null;
			}
			var turret:Turret;
			switch(turretType)
			{
				
				case Turret.TURRET_GUN:
				turret = new GunTurret();
				break;
				
				case Turret.TURRET_LAUNCHER:
				turret = new LauncherTurret();
				break;
				
				case Turret.TURRET_SWARM:
				turret = new SwarmTurret();
				break;
				
				case Turret.TURRET_FREEZE:
				turret = new FreezeTurret();
				break;
			}
			
			var counter = new InstallingCounter();
			counter.gotoAndStop(100);
			counter.txtCount.text = "0 %";
			counter.txtProcess.text = "install";
			
			turret.level = turLevel;
			turret.updateLevel();
			counter.turretInAction = turret;
			counter.installTime = turret.installingTime;
			counter.passTime = 0;
			
			memoryUsed += turret.memoryUse;
			updateScoreBoard("txtMemory");
			
			turretHolder.addChild(turret);
			turretHolder.addChild(counter);
			turret.x = xVal + turret.width * .5;
			turret.y = yVal + turret.height * .5;
			counter.x = turret.x;
			counter.y = turret.y;
			installingArray.push(counter);
			
		}
		
		private function installTurrets():void
		{
			var installLength:int = installingArray.length;
			for(var i:int = installLength; --i >= 0;)
			{
				var counter:InstallingCounter = installingArray[i];
				if(counter.passTime < counter.installTime)
				{
					counter.passTime++;
					var percent:int = Math.floor(counter.passTime / counter.installTime * 100);
					counter.txtCount.text = String(percent) + " %";
					counter.gotoAndStop(percent);
				}
				else
				{
					var turret:Turret = counter.turretInAction;
					turret.addEventListener(MouseEvent.CLICK, clickTurret, false, 0, true);
					turretArray.push(turret);
					removeObject(i, installingArray);
				}
			}
		}
		
		private function startUpgradeTurret(e:MouseEvent):void
		{
			var turret:Turret = charMenu.target;
			if(turret is FreezeTurret) turret.gun.graphics.clear();
			turret.graphics.clear();
			
			for(var i:int = turretArray.length; --i >= 0;)
			{
				var tempTurret:Turret = turretArray[i];
				if(turret == tempTurret) 
				{
					turret.removeEventListener(MouseEvent.CLICK, clickTurret);
					turretArray.splice(i, 1);
				}
			}
			
			var counter = new InstallingCounter();
			counter.gotoAndStop(100);
			counter.txtCount.text = "0 %";
			counter.txtProcess.text = "upgrade";
			counter.turretInAction = turret;
			counter.upgradeTime = turret.upgradingTime;
			counter.passTime = 0;
			counter.x = turret.x;
			counter.y = turret.y;
			
			memoryUsed += turret.upgradeCost;
			updateScoreBoard("txtMemory");
			upgradingArray.push(counter);
			turretHolder.addChild(counter);
		}
		
		private function upgradeTurrets():void
		{
			var upgradeLength:int = upgradingArray.length;
			for(var i:int = upgradeLength; --i >= 0;)
			{
				var counter:InstallingCounter = upgradingArray[i];
				if(counter.passTime  < counter.upgradeTime)
				{
					counter.passTime++;
					var percent:int = Math.floor(counter.passTime / counter.upgradeTime * 100);
					counter.txtCount.text = String(percent) + " %";
					counter.gotoAndStop(percent);
				}
				else
				{
					var turret:Turret = counter.turretInAction;
					turret.addEventListener(MouseEvent.CLICK, clickTurret, false, 0, true);
					turretArray.push(turret);
					removeObject(i, upgradingArray);
					
					turret.level++;
					turret.updateLevel();
				}
			}
		}
		
		private function startUninstallTurret(e:MouseEvent):void
		{
			var turret:Turret;
			
			if(charMenu) turret = charMenu.target;
			if(relocationTurretClip)
			{
				turret = relocationTurretClip.turretInAction;
				turretHolder.removeChild(relocationTurretClip);
				relocationTurretClip = null;
				turretRelocatingON = false;
				relocatingTurretChoosen = false;
				if(cancelToolClip)
				{
					toolsScreen.removeChild(cancelToolClip);
					cancelToolClip = null;
					for each(var tool:SpecialTools in specialToolsArray)
					{
						tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
						tool.addEventListener(MouseEvent.MOUSE_OVER, showToolInfo, false, 0, true);
						tool.addEventListener(MouseEvent.MOUSE_OUT, hideToolInfo, false, 0, true);
						tool.addEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo, false, 0, true);
					}
				}
			}
			for(var i:int = turretArray.length; --i >= 0;)
			{
				var tempTurret:Turret = turretArray[i];
				if(turret == tempTurret)
				{
					turret.removeEventListener(MouseEvent.CLICK, clickTurret);
					turretArray.splice(i, 1);
				}
			}
			var counter:InstallingCounter = new InstallingCounter();
			counter.gotoAndStop(1);
			counter.txtCount.text = "100 %";
			counter.txtProcess.text = "uninstall";
			counter.turretInAction = turret;
			counter.uninstallTime = counter.passTime = turret.uninstallingTime;
			counter.x = turret.x;
			counter.y = turret.y;
			
			uninstallingArray.push(counter);
			turretHolder.addChild(counter);
			
		}
		
		private function uninstallTurrets():void
		{
			for(var i:int = uninstallingArray.length; --i >= 0;)
			{
				var counter:InstallingCounter = uninstallingArray[i];
				if(counter.passTime > 0)
				{
					counter.passTime--;
					var percent = Math.floor(counter.passTime / counter.uninstallTime * 100);
					counter.txtCount.text = String(percent) + " %";
					counter.gotoAndStop(percent);
				}
				else
				{
					var turret:Turret = counter.turretInAction;
					memoryUsed -= turret.memoryUse;
					updateScoreBoard("txtMemory");
					
					for each(var marker:PlaceMarker in markerArray)
					{
						if(turret.x > marker.x && turret.x < marker.x + marker.width && 
						   turret.y > marker.y && turret.y < marker.y + marker.height) marker.free = true;
					}
					
					turretHolder.removeChild(turret);
					turret = null;
					removeObject(i, uninstallingArray);
				}
			}
		}
		
		private function clickTurret(e:MouseEvent):void
		{
			unClick();
			if(addingMarker || placingFalseTarget || relocatingTurretChoosen){}
			else if(turretRelocatingON)
			{
				relocationTurretClip = new RelocationTurretClip();
				relocationTurretClip.turretLevel = e.currentTarget.level;
				relocationTurretClip.turretType = e.currentTarget.type;
				relocationTurretClip.turretInAction = e.currentTarget;
				relocationTurretClip.x = e.currentTarget.x;
				relocationTurretClip.y = e.currentTarget.y;
				turretHolder.addChild(relocationTurretClip);
				relocatingTurretChoosen = true;
				
				for(var i:int = availableActionFlagsArray.length; --i >= 0;) removeObject(i, availableActionFlagsArray);
				
				for each(var marker:PlaceMarker in markerArray)
				{
					if(marker.free)
					{
						var flag:AvailableActionFlag = new AvailableActionFlag();
						flag.x = marker.x + marker.width * .5;
						flag.y = marker.y + marker.height * .5;
						markerHolder.addChild(flag);
						availableActionFlagsArray.push(flag);
					}
					
				}
			}
			else
			{
				var target:Object = e.currentTarget;
				e.stopPropagation();
			
				target.updateLevel();
			
				charMenu = new CharMenu();
				charMenu.x = target.x;
				charMenu.y = target.y;
				charMenu.target = target;
				charMenu.txtSellCost.text = target.memoryUse;
				charMenu.txtUpgradeCost.text = target.upgradeCost;
			
				if((target.level < target.maxLevel) && (memoryTotal >= memoryUsed + target.upgradeCost))
				{
					charMenu.upgradeBtn.addEventListener(MouseEvent.CLICK, startUpgradeTurret, false, 0, true);
					charMenu.upgradeBtn.addEventListener(MouseEvent.MOUSE_OVER, showTurretUP, false, 0, true);
					charMenu.upgradeBtn.addEventListener(MouseEvent.MOUSE_OUT, hideTurretUP, false, 0, true);
				}
				else if(target.level == target.maxLevel)
				{
					charMenu.upgradeBtn.visible = false;
					charMenu.upgradeBtn.mouseEnabled = false;
					charMenu.txtUpgradeCost.text = "";
				}
				else if(memoryTotal < memoryUsed + target.upgradeCost)
				{
					charMenu.upgradeBtn.filters = [new ColorMatrixFilter(Variables.GRAY_MATRIX)];
					charMenu.upgradeBtn.mouseEnabled = false;
				}
			
				charMenu.sellBtn.addEventListener(MouseEvent.CLICK, startUninstallTurret, false, 0, true);
				turretHolder.addChild(charMenu);
				
				showTurretInfo(e);
				infoScreen.txtLevelOrCost.text = "lvl " + target.level;
				
				showTurretRange(target.range, target.x, target.y);
			}
		}
		
		private function showTurretUP(e:MouseEvent):void
		{
			var target:Turret = charMenu.target;
			if(target.additionalDamage != 0)
			{
				infoScreen.txtDamage.textColor = 0xFFFF00;
				infoScreen.txtDamage.text = String(target.damage + target.additionalDamage);
				if(target is SwarmTurret) infoScreen.txtDamage.appendText("x" + (target.numMissiles + target.additionalMissiles));
			}
			if(target.additionalRange != 0)
			{
				infoScreen.txtRange.textColor = 0xFFFF00;
				infoScreen.txtRange.text = String(target.range + target.additionalRange);
			}
			if(target.additionalReloadTime != 0)
			{
				infoScreen.txtReloadTime.textColor = 0xFFFF00;
				infoScreen.txtReloadTime.text = String(Number((target.reloadTime - target.additionalReloadTime) * .05).toFixed(2));
			}
			if((target.range + target.additionalRange) > target.range)
			{
				var diametr:int = target.range + target.additionalRange;
				target.graphics.lineStyle(1, 0xFFFFFF);
				target.graphics.drawCircle(0, 0, diametr);
			}
		}
		
		private function hideTurretUP(e:MouseEvent):void
		{
			if(infoScreen)
			{
				var target:Turret = charMenu.target;
				infoScreen.txtDamage.text 			= String(target.damage);
				infoScreen.txtRange.text 			= String(target.range);
				infoScreen.txtReloadTime.text 		= String(Number(target.reloadTime * .05).toFixed(2));
				if(target is SwarmTurret) infoScreen.txtDamage.appendText("x" + target.numMissiles);
				infoScreen.txtDamage.textColor 		= 0xFFFFFF;
				infoScreen.txtRange.textColor 		= 0xFFFFFF;
				infoScreen.txtReloadTime.textColor 	= 0xFFFFFF;
				target.graphics.clear();
			}
		}
		
		private function showTurretRange(range:int, xVal:int, yVal:int):void
		{
			if(!rangeCircle) rangeCircle = new Shape();
			rangeCircle.graphics.clear();
			rangeCircle.graphics.beginFill(0x33FFFF, .2);
			rangeCircle.graphics.drawCircle(0, 0, range);
			rangeCircle.graphics.endFill();
			rangeCircle.x = xVal;
			rangeCircle.y = yVal;
			addChild(rangeCircle);
		}
				
		private function checkTurrets():void
		{
			var enemy:Enemy;
			
			if(charMenu)
			{
				var target:MovieClip = charMenu.target as MovieClip;
				if((target.level < target.maxLevel) && (memoryTotal >= memoryUsed + target.upgradeCost) && !charMenu.upgradeBtn.mouseEnabled)
				{
					charMenu.upgradeBtn.filters = [];
					charMenu.upgradeBtn.mouseEnabled = true;
					if(!charMenu.upgradeBtn.hasEventListener(MouseEvent.CLICK)) charMenu.upgradeBtn.addEventListener(MouseEvent.CLICK, startUpgradeTurret, false, 0, true);
				}
			}
			
			for(var i:int = turretArray.length; --i >= 0;)
			{
				var turret:Turret = turretArray[i];
				var targetEnemy:Enemy = null;
				var distance = turret.range;
				
				if(turret is FreezeTurret)
				{
					turret.gun.graphics.clear();
					turret.gun.gotoAndStop(1);
				}
				
				for(var j:int = enemyArray.length; --j >= 0;)
				{
					enemy = enemyArray[j];
					var targetDistance:Number = Math.sqrt((turret.x - enemy.x) * (turret.x - enemy.x) + (turret.y - enemy.y) * (turret.y - enemy.y));
					
					if(targetDistance < distance)
					{
						if(turret is FreezeTurret && (enemy.underFreeze || enemy.isStuned || enemy.speedUP)){/*freezeTurret skip this enemy*/}
						else distEnemyArray.push(enemy);
						
						if(enemy.isPriority)
						{
							distEnemyArray = [];
							distEnemyArray.push(enemy);
							break;
						}
					}
				}
								
				if(distEnemyArray.length > 1)
				{
					distEnemyArray.sort(sortEnemies);
					targetEnemy = distEnemyArray[0];
				}
				else if(distEnemyArray[0]) targetEnemy = distEnemyArray[0];
				
				for(var a:int = distEnemyArray.length; --a >= 0;) distEnemyArray.splice(a, 1);
				
				if(targetEnemy)
				{
					if(turret.gun.currentFrame == 1) turret.gun.rotation = Math.atan2((targetEnemy.y - turret.y), (targetEnemy.x - turret.x)) / Math.PI * 180;
					
					if(turret.loaded)
					{
						turret.loaded = false;
						
						if(turret is GunTurret)
						{
							turret.gun.gotoAndPlay("shot");
							
							if(Variables.UPGRADE_ACC_DAMAGE)
							{
								if(turret.gunEnemyID == targetEnemy.ID) turret.gunAccDamage += Variables.GUN_ACC_DAMAGE;
								else
								{
									turret.gunEnemyID = targetEnemy.ID;
									turret.gunAccDamage = 0;
								}
							}
							if(turret.level >= 3  && (Math.random() * 100 < Variables.GUN_CRIT_CHANCE))
							{
								targetEnemy.calcDamage(turret.damage * Variables.GUN_CRIT_DAMAGE_MULTIPLY + turret.gunAccDamage);
								if(infoScreen && infoScreen.target == targetEnemy) infoScreen.txtLife.text = String(targetEnemy.health);
								createExplosion(targetEnemy.x, targetEnemy.y, targetEnemy.levelColor, "critical");
							}
							else
							{
								targetEnemy.calcDamage(turret.damage + turret.gunAccDamage);
								if(infoScreen && infoScreen.target == targetEnemy) infoScreen.txtLife.text = String(targetEnemy.health);
								createExplosion(targetEnemy.x, targetEnemy.y, targetEnemy.levelColor);
							}
						}
						else if(turret is LauncherTurret)
						{
							turret.gun.gotoAndPlay("shot");
							var rocket:Rocket = new Rocket(targetEnemy.x, targetEnemy.y);
							rocket.turretLevel = turret.level;
							rocket.damage = turret.damage;
							rocket.x = turret.x;
							rocket.y = turret.y;
							rocket.rotation = turret.gun.rotation;
							rocketArray.push(rocket);
							bulletHolder.addChild(rocket);
						}
						else if(turret is SwarmTurret)
						{
							turret.gun.gotoAndPlay("shot");
							for(var t:int = 0; t < turret.numMissiles; t++)
							{
								var swarm:Swarm = new Swarm();
								swarm.turretLevel = turret.level;
								swarm.damage = turret.damage;
								swarm.numBombs = turret.numSwarmBombs;
								swarm.x = turret.x;
								swarm.y = turret.y;
								swarm.orbiterPoint = new Point(turret.x, turret.y);
								var minAngle:int = -(turret.numMissiles - 1) * 25;
								swarm.rotation = turret.gun.rotation + minAngle + (t * 50);
								swarm.target = targetEnemy;
								swarmArray.push(swarm);
								bulletHolder.addChild(swarm);
							}
						}
						else if(turret is FreezeTurret)
						{
							turret.gun.gotoAndStop("shot");
							turret.gun.rotation = 0;
							
							turret.gun.graphics.clear();
							turret.gun.graphics.lineStyle(2, 0xFF0000);
							turret.gun.graphics.lineTo(targetEnemy.x - turret.x, targetEnemy.y - turret.y);
							if(turret.level >= 3 && (Math.random() * 100 < Variables.FREEZE_STUN_CHANCE))
							{
								if(Variables.UPGRADE_MULTY_STUN) targetEnemy.stunProlonger = true;
								targetEnemy.addStatus(Enemy.STATUS_STUN);
								targetEnemy.maxTimeStuned = Variables.FREEZE_STUN_DURATION;
								var clip:MovieClip = targetEnemy.getChildByName("clip") as MovieClip;
								clip.gotoAndStop(clip.currentFrame);
								clip = null;
							}
							else targetEnemy.addStatus(Enemy.STATUS_FREEZE);
						}
					}
					if(!turret.loaded)
					{
						turret.cTime++;
						if(turret.cTime >= turret.reloadTime)
						{
							turret.loaded = true;
							turret.cTime = 0;
						}
					}
				}
			}
		}
		
		private function sortEnemies(a, b):int
		{
			var enemy1:int = a.tileNum;
			var enemy2:int = b.tileNum;
			
			if(enemy1 < enemy2) return -1;
			else if(enemy1 > enemy2) return 1;
			else return 0;
		}
		
		private function updateBullets():void
		{
			var enemy:Enemy;
			var xDest:Number;
			var yDest:Number;
			var angle:Number;
			var radian:Number;
			var distance:Number;
			
			for(var i:int = rocketArray.length; --i >= 0;)
			{
				var rocket:Rocket = rocketArray[i];
				xDest = rocket.destX - rocket.x;
				yDest = rocket.destY - rocket.y;
				radian = Math.atan2(yDest, xDest);
				rocket.xSpeed = Math.cos(radian) * rocket.speed;
				rocket.ySpeed = Math.sin(radian) * rocket.speed;
				
				rocket.x += rocket.xSpeed;
				rocket.y += rocket.ySpeed;
				
				if(rocket.hitTestPoint(rocket.destX, rocket.destY))	createRocketSplash(i, rocket.damage, rocket.turretLevel, rocket.destX, rocket.destY);
			}
			
			for(var s:int = splashArray.length; --s >= 0;)
			{
				var splash:LauncherSplash = splashArray[s];
				
				for(var e:int = enemyArray.length; --e >= 0;)
				{
					enemy = enemyArray[e];
					
					if(splash.splashHitZone)
					{
						if(splash.splashHitZone.hitTestObject(enemy))
						{
							if(splash.turretLevel >= 3 && (Math.random() * 100 < Variables.LAUNCHER_POISON_CHANCE))
							{
								if(Variables.UPGRADE_POISON_CLOUD && !enemy.poisonCloudOnBoard)
								{
									createPoisonCloud(enemy);
									enemy.poisonCloudOnBoard = true;
								}
								else if(!enemy.isPoisoned) enemy.addStatus(Enemy.STATUS_POISON);
							}
							enemy.calcDamage(splash.damage);
							if(infoScreen && infoScreen.target == enemy) infoScreen.txtLife.text = String(enemy.health);
							createExplosion(enemy.x, enemy.y, enemy.levelColor);
						}
					}
				}
				if(splash.currentFrame >= 10) removeObject(s, splashArray);
			}
			
			for(var m:int = swarmArray.length; --m >= 0;)
			{
				var swarm:Swarm = swarmArray[m];
				swarm.lifeTime++;
				
				if((swarm.target.health <= 0 || swarm.target.alpha < 1) && enemyArray.length > 0)
				{
					if(swarm.lostTarget) !swarm.lostTarget;
					for(var ne:int = enemyArray.length; --ne >= 0;)
					{
						enemy = enemyArray[ne];
						
						if(enemy.isPriority)
						{
							swarm.target = enemy;
							break;
						}
						distance = Math.sqrt(Math.pow(enemy.x - swarm.x,2) + Math.pow(enemy.y - swarm.y, 2));
						enemy.distToMissile = distance;
						distEnemyArray.push(enemy);
						if(distEnemyArray.length > 1)
						{
							distEnemyArray.sort(sortForMissiles);
							swarm.target = distEnemyArray[0];
						}
						else swarm.target = distEnemyArray[0];
					}
				}
				if(swarm.target.health > 0 && swarm.target.alpha == 1)
				{
					if(swarm.lostTarget) !swarm.lostTarget;
					var target:MovieClip = swarm.target;
				
					xDest = target.x - swarm.x;
					yDest = target.y - swarm.y;					
					angle = Math.atan2(yDest, xDest) * 180 / Math.PI;
					if(Math.abs(angle - swarm.rotation) > 180)
					{
						if(angle > 0 && swarm.rotation < 0) swarm.rotation -= (360 - angle + swarm.rotation) / swarm.ease;
						else if(angle < 0 && swarm.rotation > 0) swarm.rotation += (360 - angle + swarm.rotation) / swarm.ease;
					}
					else if(angle < swarm.rotation) swarm.rotation -= Math.abs(swarm.rotation - angle) / swarm.ease;
					else swarm.rotation += Math.abs(angle - swarm.rotation) / swarm.ease;
				
					swarm.xSpeed = swarm.speed * (90 - Math.abs(swarm.rotation)) / 90;
				
					if(swarm.rotation < 0) swarm.ySpeed = -swarm.speed + Math.abs(swarm.xSpeed);
					else swarm.ySpeed = swarm.speed - Math.abs(swarm.xSpeed);
				
					swarm.x += swarm.xSpeed;
					swarm.y += swarm.ySpeed;
					
					if(swarm.hitTestObject(target.hitPoint)) 
					{
						if(swarm.turretLevel >= 3 && (Math.random() * 100 < Variables.SWARM_SPLASH_CHANCE))
						{
							if(Variables.UPGRADE_BOMB_CASCADE) createCascadeBombs(swarm.x, swarm.y, swarm.rotation, swarm.numBombs);
							else createSwarmSplash(swarm.x, swarm.y, "swarmSplash", Variables.SWARM_SPLASH_DAMAGE);
						}
						else
						{
							target.calcDamage(swarm.damage);
							if(infoScreen && infoScreen.target == target) infoScreen.txtLife.text = target.health;
							createExplosion(target.x, target.y, target.levelColor);
						}
						removeObject(m, swarmArray);
					}
					if(swarm.ease > 1) swarm.ease--;
				}
				else if(swarm.target.health <= 0 || swarm.target.alpha < 1)
				{
					if(!swarm.lostTarget)
					{
						swarm.lostTarget = true;
						swarm.ease = 10;
					}
					
					xDest = swarm.orbiterPoint.x - swarm.x;
					yDest = swarm.orbiterPoint.y - swarm.y;
					
					distance = Math.sqrt(xDest*xDest + yDest*yDest);
					if(distance > 30)
					{
						radian = Math.atan2(yDest, xDest);
						angle = radian * 180 / Math.PI;
						swarm.xSpeed = Math.cos(radian) * swarm.speed;
						swarm.ySpeed = Math.sin(radian) * swarm.speed;
						swarm.rotation  = angle;
						
						swarm.x += swarm.xSpeed;
						swarm.y += swarm.ySpeed;
					}
					else if(swarm.lifeTime > 10)
					{
						swarm.orbiterAngle += swarm.orbiterSpeed;
						radian = swarm.orbiterAngle * (Math.PI / 180);
						swarm.rotation = (Math.atan2(yDest, xDest) * 180 / Math.PI) - 90;
						swarm.x = swarm.orbiterPoint.x + swarm.orbiterRadius * Math.cos(radian);
						swarm.y = swarm.orbiterPoint.y + swarm.orbiterRadius * Math.sin(radian);
					}
					else
					{				
						angle = Math.atan2(yDest, xDest) * 180 / Math.PI;
						if(Math.abs(angle - swarm.rotation) > 180)
						{
							if(angle > 0 && swarm.rotation < 0) swarm.rotation -= (360 - angle + swarm.rotation) / swarm.ease;
							else if(angle < 0 && swarm.rotation > 0) swarm.rotation += (360 - angle + swarm.rotation) / swarm.ease;
						}
						else if(angle < swarm.rotation) swarm.rotation -= Math.abs(swarm.rotation - angle) / swarm.ease;
						else swarm.rotation += Math.abs(angle - swarm.rotation) / swarm.ease;
				
						swarm.xSpeed = swarm.speed * (90 - Math.abs(swarm.rotation)) / 90;
					
						if(swarm.rotation < 0) swarm.ySpeed = -swarm.speed + Math.abs(swarm.xSpeed);
						else swarm.ySpeed = swarm.speed - Math.abs(swarm.xSpeed);
				
						swarm.x += swarm.xSpeed;
						swarm.y += swarm.ySpeed;
					}
				}
				else removeObject(m, swarmArray);
				for(var a:int = distEnemyArray.length; --a >= 0;) distEnemyArray.splice(a, 1);
			}
			
			for(var k:int = swarmSplashArray.length; --k >= 0;)
			{
				var swSplash:SwarmSplash = swarmSplashArray[k];
				if(swSplash.firstRun)
				{
					swSplash.gotoAndPlay(1);
					swSplash.firstRun = false;
				}
				for(var n:int = enemyArray.length; --n >= 0;)
				{
					enemy = enemyArray[n];
					if(swSplash.hitZone)
					{
						if(swSplash.hitZone.hitTestObject(enemy))
						{
							enemy.calcDamage(swSplash.damage);
							if(infoScreen && infoScreen.target == enemy) infoScreen.txtLife.text = String(enemy.health);
							createExplosion(enemy.x, enemy.y, enemy.levelColor);
						}
					}
				}
				if(swSplash.currentFrame >= 10) removeObject(k, swarmSplashArray);
			}
			
			for(var b:int = swarmBombsArray.length; --b >= 0;)
			{
				var bomb:SwarmBomb = swarmBombsArray[b];
				xDest = bomb.destX - bomb.x;
				yDest = bomb.destY - bomb.y;
				angle = Math.atan2(yDest, xDest);
				bomb.xSpeed = Math.cos(angle) * bomb.speed;
				bomb.ySpeed = Math.sin(angle) * bomb.speed;
				
				bomb.x += bomb.xSpeed;
				bomb.y += bomb.ySpeed;
				
				if(bomb.hitTestPoint(bomb.destX, bomb.destY))
				{
					createSwarmSplash(bomb.x, bomb.y, "bombSplash", SwarmBomb.DAMAGE);
					removeObject(b, swarmBombsArray);
				}
			}
			
			for(var c:int = poisonCloudsArray.length; --c >= 0;)
			{
				var cloud:PoisonCloud = poisonCloudsArray[c];
				
				if(cloud.target.health > 0)
				{
					cloud.x = cloud.target.x;
					cloud.y = cloud.target.y;
				}
				for(var ee:int = enemyArray.length; --ee >= 0;)
				{
					enemy = enemyArray[ee];
					if(cloud.hitTestObject(enemy) && !enemy.thisTurnCloudTouched && !enemy.isPoisoned)
					{
						enemy.addStatus(Enemy.STATUS_CLOUD);
						enemy.calcDamage(Variables.LAUNCHER_POISON_CLOUD_DAMAGE);
						if(infoScreen && infoScreen.target == enemy) infoScreen.txtLife.text = String(enemy.health);
						createExplosion(enemy.x, enemy.y, enemy.levelColor, "poison");
						enemy.thisTurnCloudTouched = true;
					}
				}
				cloud.lifeTime--;
				if(cloud.lifeTime <= 0)
				{
					if(cloud.target.health > 0) cloud.target.poisonCloudOnBoard = false;
					removeObject(c, poisonCloudsArray);
				}
			}
		}
		
		private function sortForMissiles(a, b):int
		{
			var numA:Number = a.distToMissile;
			var numB:Number = b.distToMissile;
			if(numA < numB) return -1;
			else if(numA > numB) return  1;
			else return  0;
		}
		
		private function createPoisonCloud(target:MovieClip):void
		{
			var cloud:PoisonCloud = new PoisonCloud();
			cloud.x = target.x;
			cloud.y = target.y;
			cloud.target = target;
			poisonCloudsArray.push(cloud);
			bulletHolder.addChild(cloud);
		}
		
		private function createCascadeBombs(xVal:int, yVal:int, rotate:Number, numBombs:int)
		{
			for(var i:int = 0; i < numBombs; i++)
			{
				var bomb:SwarmBomb = new SwarmBomb();
				bomb.x = xVal;
				bomb.y = yVal;
				bomb.rotation = rotate;
				bomb.angle = (360/numBombs * i);
				bomb.rads = bomb.angle * Math.PI / 180;
				bomb.destX = bomb.x - (Math.cos(bomb.rads) * bomb.flyDist);
				bomb.destY = bomb.y - (Math.sin(bomb.rads) * bomb.flyDist);
				swarmBombsArray.push(bomb);
				bulletHolder.addChild(bomb);
			}
		}
		
		private function createSwarmSplash(xVal:int, yVal:int, splashType:String, dam:int):void
		{
			var splash:SwarmSplash = new SwarmSplash();
			splash.x = xVal;
			splash.y = yVal;
			splash.damage = dam;
			if(Variables.UPGRADE_WIDE_SPLASH && splashType == "swarmSplash")
			{
				splash.scaleX *= 1.5;
				splash.scaleY *= 1.5;
			}
			if(splashType == "bombSplash")
			{
				splash.scaleX *= .6;
				splash.scaleY *= .6;
			}
			swarmSplashArray.push(splash);
			addChild(splash);
		}
		
		private function createRocketSplash(index:int, splashDamage:int, turretLevel:int, xPos:int, yPos:int):void
		{
			var splash:LauncherSplash = new LauncherSplash();
			splash.turretLevel = turretLevel;
			
			splash.x = xPos;
			splash.y = yPos;
			splash.damage = splashDamage;
			splashArray.push(splash);
			addChild(splash);
			removeObject(index, rocketArray);
		}
				
		private function drop(xVal:int, yVal:int, dropAmaunt:int, dropType:String):void
		{
			var drop:Drop = new Drop();
			drop.x = drop.destX = xVal;
			drop.y = drop.destY = yVal;
			drop.destX += Math.round(Math.cos(Math.random() * 360) * Drop.DISTANCE);
			drop.destY += Math.round(Math.sin(Math.random() * 360) * Drop.DISTANCE);
			drop.dropType = dropType;
			drop.dropAmaunt = dropAmaunt;
			drop.addEventListener(MouseEvent.CLICK, pickUpDrop, false, 0, true);
			dropArray.push(drop);
			userInterface.addChild(drop);
			
			switch(drop.dropType)
			{
				case Drop.DROP_SYMBOLS:
					drop.gotoScorePoint = scoreSymbolsPoint;
					drop.gotoAndStop("symbols");
				break;
				
				case Drop.DROP_MEMORY:
					drop.gotoScorePoint = scoreMemoryPoint;
					drop.gotoAndStop("memory");
				break;
				
				case Drop.DROP_PROTECT:
					drop.gotoScorePoint = scoreProtectPoint;
					drop.gotoAndStop("protect");
				break;
			}
		}
		
		private function checkDrop():void
		{
			for each(var drop:Drop in dropArray)
			{
				var xDist:Number;
				var yDist:Number;
				var dist:Number;
				var angle:Number;
				
				if(!drop.gotoScoreBoard)
				{
					xDist = drop.destX - drop.x;
					yDist = drop.destY - drop.y;
					dist = Math.sqrt(xDist*xDist + yDist*yDist);
					if(dist > 5)
					{
						angle = Math.atan2(yDist, xDist);
						drop.xSpeed = Math.cos(angle) * drop.speed;
						drop.ySpeed = Math.sin(angle) * drop.speed;
				
						drop.x += drop.xSpeed;
						drop.y += drop.ySpeed;
					}
					else drop.gotoScoreBoard = true;
				}
				if(drop.gotoScoreBoard && drop.waitCounter >= drop.waitTime)
				{
					xDist = drop.gotoScorePoint.x - drop.x;
					yDist = drop.gotoScorePoint.y - drop.y;
					dist = Math.sqrt(xDist*xDist + yDist*yDist);
						
					angle = Math.atan2(yDist, xDist);
					drop.xSpeed = Math.cos(angle) * drop.gotoScoreSpeed;
					drop.ySpeed = Math.sin(angle) * drop.gotoScoreSpeed;
				
					drop.x += drop.xSpeed;
					drop.y += drop.ySpeed;
				}
				else if(drop.gotoScoreBoard && drop.waitCounter < drop.waitTime) drop.waitCounter++;
				if(drop.y < scoreBoard.y) getDrop(drop);
			}
		}
		
		private function pickUpDrop(e:MouseEvent):void
		{
			var drop:Drop = e.currentTarget as Drop;
			drop.gotoScoreBoard = true;
			drop.waitCounter = drop.waitTime;
		}
		
		private function getDrop(drop:Drop):void
		{
			if(drop.hasEventListener(MouseEvent.CLICK)) drop.removeEventListener(MouseEvent.CLICK, pickUpDrop);
			
			switch(drop.dropType)
			{
				case Drop.DROP_SYMBOLS:
					Variables.SYMBOLS += drop.dropAmaunt;
					updateScoreBoard("txtSymbols");
				break;
				
				case Drop.DROP_MEMORY:
					memoryTotal += drop.dropAmaunt;
					updateScoreBoard("txtMemory");
				break;
				
				case Drop.DROP_PROTECT:
					systemProtection += drop.dropAmaunt;
					if(systemProtection >= 100) systemProtection = 100;
					updateScoreBoard("txtSystem");
				break;
			}
			drop.parent.removeChild(drop);
			for(var d:int = dropArray.length; --d >= 0;)
			{
				var disposeDrop:Drop = dropArray[d];
				if(disposeDrop == drop) dropArray.splice(d, 1);
			}
		}
		
		private function createExplosion(xVal:int, yVal:int, color:uint, type:String = "standart"):void
		{
			var numParticles:int = 10;
			switch(type)
			{
				case "standart":
					numParticles = 10;
				break;
				
				case "killed":
					numParticles = 50;
				break;
				
				case "critical":
					numParticles = 20;
				break;
				
				case "poison":
					numParticles = 2;
				break;
				
				default:
					trace("wrong type in createExplosion: " + type);
				break;
			}
			
			for(var i:int = 0; i < numParticles; i++)
			{
				var particle:Particle = new Particle(color);
				particle.rotation = Math.random() * 360;
				particle.speed = Math.random() * 10 + 5;
				if(type == "killed")
				{
					particle.x = xVal;
					particle.y = yVal;
				}
				else
				{
					particle.x = xVal + Math.random() * 30 - 15;
					particle.y = yVal + Math.random() * 30 - 15;
				}
				particleArray.push(particle);
				addChild(particle);
			}
		}
		
		private function updateExplosions():void
		{
			for(var i:int = particleArray.length; --i >= 0;)
			{
				var particle:Particle = particleArray[i];
				var angle = particle.rotation;
				particle.speed -= .5;
				particle.x += Math.cos(angle) * particle.speed;
				particle.y += Math.sin(angle) * particle.speed;
				particle.alpha -= .05;
				if(particle.alpha <= 0) removeObject(i, particleArray);
			}
		}
		
		private function checkForNextWave():void
		{
			startWaveBtn = new StartWaveBtn();
			startWaveBtn.x = roadStart.x + 50;
			startWaveBtn.y = roadStart.y;
			startWaveBtn.buttonMode = true;
			startWaveBtn.timeCounter.mouseEnabled = false;
			startWaveBtn.addEventListener(MouseEvent.CLICK, onClickNextWave, false, 0, true);
			startWaveBtn.timeCounter.text = Variables.WAVE_DELAY;
			userInterface.addChild(startWaveBtn);
			
			startWaveBtnArrow = new StartWaveBtnArrow();
			startWaveBtnArrow.x = startWaveBtn.x - startWaveBtn.width + 5;
			startWaveBtnArrow.y = startWaveBtn.y;
			userInterface.addChild(startWaveBtnArrow);
		
			waveTimerInAction = true;
			nextWaveTimer.start();
		}
		
		private function countWaveDelay(e:TimerEvent):void
		{
			if((nextWaveTimer.repeatCount - nextWaveTimer.currentCount) < 10) startWaveBtn.timeCounter.text = "0" + (int(nextWaveTimer.repeatCount) - int(nextWaveTimer.currentCount));
			else startWaveBtn.timeCounter.text = int(nextWaveTimer.repeatCount) - int(nextWaveTimer.currentCount);
		}
		
		private function onClickNextWave(e:MouseEvent):void
		{
			nextWaveTimer.stop();
			
			nextWaveTimer.reset();
			waveTimerInAction = false;
			
			startWaveBtn.removeEventListener(MouseEvent.CLICK, onClickNextWave);
			userInterface.removeChild(startWaveBtn);
			startWaveBtn = null;
			
			userInterface.removeChild(startWaveBtnArrow);
			startWaveBtnArrow = null;
			
			currentWave++;
			currentEnemy = 0;
			startWave();
		}
		
		private function waveDelayComplete(e:TimerEvent):void
		{
			nextWaveTimer.stop();
			
			nextWaveTimer.reset();
			waveTimerInAction = false;
			
			startWaveBtn.removeEventListener(MouseEvent.CLICK, onClickNextWave);
			userInterface.removeChild(startWaveBtn);
			startWaveBtn = null;
			
			userInterface.removeChild(startWaveBtnArrow);
			startWaveBtnArrow = null;
			
			currentWave++;
			currentEnemy = 0;
			startWave();
		}
		
		private function checkForEndLevel():void
		{
			if(gameOver)
			{
				gameTimer.stop();
				
				for(var a:int = enemyArray.length; --a >= 0;) removeObject(a, enemyArray);
				for(var b:int = turretArray.length; --b >= 0;) removeObject(b, turretArray);
				for(var c:int = rocketArray.length; --c >= 0;) removeObject(c, rocketArray);
				for(var d:int = splashArray.length; --d >= 0;) removeObject(d, splashArray);
				
				dispatchEvent(new CustomEvents(CustomEvents.LEVEL_LOSE));
			}
						
			if(currentWave == enemyWaves.length && enemiesLeft == 0 && particleArray.length == 0 && dropArray.length == 0)
			{
				if(dragging)
				{
					dragging = false
					if(dragCharIcon)
					{
						stage.removeEventListener(MouseEvent.MOUSE_UP, dropIcon);
						dragCharIcon.stopDrag();
						dragCharIcon.parent.removeChild(dragCharIcon);
						dragCharIcon = null;
					}
				}
				gameTimer.stop();
				
				for(var e:int = enemyArray.length; --e >= 0;) removeObject(e, enemyArray);
				for(var t:int = turretArray.length; --t >= 0;) removeObject(t, turretArray);
				for(var r:int = rocketArray.length; --r >= 0;) removeObject(r, rocketArray);
				for(var s:int = splashArray.length; --s >= 0;) removeObject(s, splashArray);
				
				dispatchEvent(new CustomEvents(CustomEvents.LEVEL_WIN));
			}
		}
		
		private function checkForHack(enemy:Enemy, i:int):void
		{
			enemiesLeft--;
			enemy.removeEventListener(MouseEvent.CLICK, clickEnemy);
			updateScoreBoard("txtEnemiesLeft");
			if(enemy is Enemy_Neirobot)
			{
				Variables.NUM_NEIROBOTS--;
				for each(var neiro:Enemy_Neirobot in enemyArray)
				{
					neiro.systemDamage = neiro.baseSystemDamage * Variables.NUM_NEIROBOTS * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY;
					if(infoScreen && infoScreen.target == neiro) infoScreen.txtSystemDamage.text = String(neiro.systemDamage);
				}
			}
			if(enemy is Enemy_Protector)
			{
				var tempEnemy:Enemy;
				for each(tempEnemy in enemyArray)
				{
					tempEnemy.health -= tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
					tempEnemy.maxHealth -= tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
				}
				Variables.NUM_PROTECTORS--;
				for each(tempEnemy in enemyArray)
				{
					tempEnemy.health += tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
					tempEnemy.maxHealth += tempEnemy.baseMaxHealth * Variables.NUM_PROTECTORS * .1;
					if(infoScreen && infoScreen.target == tempEnemy) infoScreen.txtLife.text = String(tempEnemy.health);
				}
			}
			if(infoScreen && infoScreen.target == enemy) removeInfoScreen();
			enemyArray.splice(i, 1);
			hackingEnemies.push(enemy);
			var clip:MovieClip = enemy.getChildByName("clip") as MovieClip;
			clip.gotoAndStop(currentFrame);
			clip = null;
			
			var res:Number = Math.round(Math.random() * 100);
			
			if(res < enemy.hackChance) gameOver = true;
			else scoreBoard.txtHackChance.text = "hack: " + enemy.hackChance + "/" + res;
		}
		
		private function updateScoreBoard(field:String):void
		{
			switch(field)
			{
				case "txtWave":
					scoreBoard.txtWave.text = "Wave: " + currentWave + "/" + int(enemyWaves.length);
				break;
				
				case "txtMemory":
					scoreBoard.txtMemory.text = "Memory: " + memoryUsed + "/" + memoryTotal;
				break;
				
				case "txtEnemiesLeft":
					scoreBoard.txtEnemiesLeft.text = "Enemies Left: " + enemiesLeft;
				break;
				
				case "txtSymbols":
					scoreBoard.txtSymbols.text = "Symbols: " + String(Variables.SYMBOLS);
				break;
				
				case "txtSystem":
					//var result:Number;
					//var string:String;
					//result = Math.round(systemProtection * 10) * .1;
					//if(result <= 0) result = 0;
					//else if(result >= 100) result = 100;
					//if((result % 1) == 0) string = result + ".0";
					//else string = result.toString();
					//string = string.slice(0, Number(string.indexOf(".")+2));
					//scoreBoard.txtSystem.text = "System: " + string + " %";
					scoreBoard.txtSystem.text = "System: "+ String(Number(Math.round(systemProtection * 10) * .1).toFixed(1)) + " %";
					
				break;
				
				case "txtHackChance":
				break;
				
				default:
					trace("wrong field name", field);
				break;
			}
		}
		
		private function clickTool(e:MouseEvent):void
		{
			if(specialToolsGauge > 0 && levelStarted)
			{
				var enemy:Enemy;
				var cFrame:int = 1;
				var gauge:MovieClip;
				var specTool:SpecialTools;
				var i:int = 0;
				
				switch(e.currentTarget.type)
				{
					case SpecialTools.SYS_DAMAGE_REDUCE:
						Variables.SPECIAL_SYS_DAMAGE_MULTIPLY = .5;
						for each(enemy in enemyArray)
						{
							enemy.systemDamage = enemy.baseSystemDamage * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY;
							if(enemy is Enemy_Neirobot) enemy.systemDamage = enemy.baseSystemDamage * Variables.SPECIAL_SYS_DAMAGE_MULTIPLY * Variables.NUM_NEIROBOTS;
						}
						systemDamReduceInAction = true;
						if(infoScreen && infoScreen.target == enemy) infoScreen.txtSystemDamage.text = String(enemy.systemDamage);
						specialToolCooldown = new SpecialToolsCooldown();
						specialToolCooldown.x = e.currentTarget.x;
						specialToolCooldown.y = e.currentTarget.y;
						specialToolCooldown.gotoAndStop(1);
						specialToolCooldown.timeToWait = Variables.SPECIAL_SYS_DAMAGE_REDUCE_COOLTIME;
						if(Variables.SPECIAL_SYS_DAMAGE_REDUCE_COOLTIME < 200) specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05) + ".0";
						else specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05);
						toolsScreen.addChild(specialToolCooldown);
						specialToolsCooldownsArray.push(specialToolCooldown);
						
						specialToolsGauge--;
						for(i = specialToolsGaugeArray.length; --i >= 0;)
						{
							gauge = specialToolsGaugeArray[i] as MovieClip;
							if(gauge.currentFrame < gauge.totalFrames)
							{
								cFrame = gauge.currentFrame;
								gauge.gotoAndStop(1);
							}
							else if(gauge.currentFrame >= gauge.totalFrames)
							{
								gauge.gotoAndStop(cFrame);
								break;
							}
						}
					break;
				
					case SpecialTools.FLOW_STOP:
						flowStopInAction = true;
						flowStopCounter = Variables.SPECIAL_FLOW_STOP_DURATION;
						specialToolCooldown = new SpecialToolsCooldown();
						specialToolCooldown.x = e.currentTarget.x;
						specialToolCooldown.y = e.currentTarget.y;
						specialToolCooldown.gotoAndStop(1);
						specialToolCooldown.timeToWait = Variables.SPECIAL_FLOW_STOP_COOLTIME;
						if(Variables.SPECIAL_FLOW_STOP_COOLTIME < 200) specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05) + ".0";
						else specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05);
						toolsScreen.addChild(specialToolCooldown);
						specialToolsCooldownsArray.push(specialToolCooldown);
						
						for each(enemy in enemyArray)
						{
							var clip:MovieClip = enemy.getChildByName("clip") as MovieClip;
							clip.gotoAndStop(clip.currentFrame);
							clip = null;
						}
						specialToolsGauge--;
						for(i = specialToolsGaugeArray.length; --i >= 0;)
						{
							gauge = specialToolsGaugeArray[i] as MovieClip;
							if(gauge.currentFrame < gauge.totalFrames)
							{
								cFrame = gauge.currentFrame;
								gauge.gotoAndStop(1);
							}
							else if(gauge.currentFrame >= gauge.totalFrames)
							{
								gauge.gotoAndStop(cFrame);
								break;
							}
						}
					break;
				
					case SpecialTools.FLOW_OVERLOAD:
						for(var k:int = enemyArray.length; --k >= 0;)
						{
							enemy = enemyArray[k];
							enemy.calcDamage(Variables.SPECIAL_FLOW_OVERLOAD_DAMAGE);
							if(infoScreen && infoScreen.target == enemy) infoScreen.txtLife.text = String(enemy.health);
							createExplosion(enemy.x, enemy.y, enemy.levelColor);
						}
						specialToolCooldown = new SpecialToolsCooldown();
						specialToolCooldown.x = e.currentTarget.x;
						specialToolCooldown.y = e.currentTarget.y;
						specialToolCooldown.gotoAndStop(1);
						specialToolCooldown.timeToWait = Variables.SPECIAL_FLOW_OVERLOAD_COOLTIME;
						if(Variables.SPECIAL_FLOW_OVERLOAD_COOLTIME < 200) specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05) + ".0";
						else specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05);
						toolsScreen.addChild(specialToolCooldown);
						specialToolsCooldownsArray.push(specialToolCooldown);
						
						specialToolsGauge--;
						for(i = specialToolsGaugeArray.length; --i >= 0;)
						{
							gauge = specialToolsGaugeArray[i] as MovieClip;
							if(gauge.currentFrame < gauge.totalFrames)
							{
								cFrame = gauge.currentFrame;
								gauge.gotoAndStop(1);
							}
							else if(gauge.currentFrame >= gauge.totalFrames)
							{
								gauge.gotoAndStop(cFrame);
								break;
							}
						}
					break;
				
					case SpecialTools.RELOCATE_TURRET:
						for each(specTool in specialToolsArray)
						{
							specialToolDisableClip = new SpecialToolDisable();
							specialToolDisableClip.x = specTool.x;
							specialToolDisableClip.y = specTool.y;
							specialToolsDisablesArray.push(specialToolDisableClip);
							toolsScreen.addChild(specialToolDisableClip);
						}
						turretRelocatingON = true;
						cancelToolClip = new CancelSpecialTool();
						cancelToolClip.x = e.currentTarget.x;
						cancelToolClip.y = e.currentTarget.y;
						cancelToolClip.addEventListener(MouseEvent.CLICK, cancelTool, false, 0, true);
						toolsScreen.addChild(cancelToolClip);
						for each(specTool in specialToolsArray)
						{
							specTool.removeEventListener(MouseEvent.CLICK, clickTool);
							specTool.removeEventListener(MouseEvent.MOUSE_OVER, showToolInfo);
							specTool.removeEventListener(MouseEvent.MOUSE_OUT, hideToolInfo);
							specTool.removeEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo);
						}
						
						for each(var turret:Turret in turretArray)
						{
							var tempFlag:AvailableActionFlag = new AvailableActionFlag();
							tempFlag.x = turret.x;
							tempFlag.y = turret.y;
							availableActionFlagsArray.push(tempFlag);
							turretHolder.addChild(tempFlag);
						}
						hideToolInfo();
					break;
				
					case SpecialTools.ADDITIONAL_MARKER:
						for each(specTool in specialToolsArray)
						{
							specialToolDisableClip = new SpecialToolDisable();
							specialToolDisableClip.x = specTool.x;
							specialToolDisableClip.y = specTool.y;
							specialToolsDisablesArray.push(specialToolDisableClip);
							toolsScreen.addChild(specialToolDisableClip);
						}
						addingMarker = true;
						cancelToolClip = new CancelSpecialTool();
						cancelToolClip.x = e.currentTarget.x;
						cancelToolClip.y = e.currentTarget.y;
						cancelToolClip.addEventListener(MouseEvent.CLICK, cancelTool, false, 0, true);
						toolsScreen.addChild(cancelToolClip);
						for each(specTool in specialToolsArray)
						{
							specTool.removeEventListener(MouseEvent.CLICK, clickTool);
							specTool.removeEventListener(MouseEvent.MOUSE_OVER, showToolInfo);
							specTool.removeEventListener(MouseEvent.MOUSE_OUT, hideToolInfo);
							specTool.removeEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo);
						}
						
						for each(var ground:GroundTile in groundArray)
						{
							if(ground.nearRoad)
							{
								var flag:AvailableActionFlag = new AvailableActionFlag();
								flag.x = ground.x + ground.width * .5;
								flag.y = ground.y + ground.height * .5;
								availableActionFlagsArray.push(flag);
								groundHolder.addChild(flag);
							}
						}
						hideToolInfo();
					break;
					
					case SpecialTools.FALSE_TARGET:
						for each(specTool in specialToolsArray)
						{
							specialToolDisableClip = new SpecialToolDisable();
							specialToolDisableClip.x = specTool.x;
							specialToolDisableClip.y = specTool.y;
							specialToolsDisablesArray.push(specialToolDisableClip);
							toolsScreen.addChild(specialToolDisableClip);
						}
						placingFalseTarget = true;
						cancelToolClip = new CancelSpecialTool();
						cancelToolClip.x = e.currentTarget.x;
						cancelToolClip.y = e.currentTarget.y;
						cancelToolClip.addEventListener(MouseEvent.CLICK, cancelTool, false, 0, true);
						toolsScreen.addChild(cancelToolClip);
						for each(specTool in specialToolsArray)
						{
							specTool.removeEventListener(MouseEvent.CLICK, clickTool);
							specTool.addEventListener(MouseEvent.MOUSE_OVER, showToolInfo);
							specTool.addEventListener(MouseEvent.MOUSE_OUT, hideToolInfo);
							specTool.addEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo);
						}
						
						falseTarget = new EnemyFalseTarget();
						falseTarget.alpha = 0;
						falseTarget.txtProtection.text = String(falseTarget.protectAmount) + ".0 %";
						falseTarget.txtLife.text = String(falseTarget.lifeTime) + ".0 s";
						turretHolder.addChild(falseTarget);
						falseTarget.addEventListener(MouseEvent.CLICK, placeFalseTarget, false, 0, true);
						hideToolInfo();
					break;
					
					case SpecialTools.MINES:
						var emptyRoadsArray:Array = [];
						var road:RoadTile;
						var numMines:int;
						var mine:Mine;
						var rand:int;
						for each(road in roadArray)
						{
							if(!road.mineOccupied) emptyRoadsArray.push(road);
						}
						numMines = Math.min(emptyRoadsArray.length, Variables.SPECIAL_MINES_NUMBER);
						for(i = 0; i < numMines; i++)
						{
							rand = Math.floor(Math.random() * emptyRoadsArray.length);
							mine = new Mine();
							mine.x = emptyRoadsArray[rand].x + emptyRoadsArray[rand].width * .5;
							mine.y = emptyRoadsArray[rand].y + emptyRoadsArray[rand].height * .5;
							roadHolder.addChild(mine);
							emptyRoadsArray[rand].mineOccupied = true;
							emptyRoadsArray.splice(rand, 1);
							minesArray.push(mine);
						}
						specialToolCooldown = new SpecialToolsCooldown();
						specialToolCooldown.x = e.currentTarget.x;
						specialToolCooldown.y = e.currentTarget.y;
						specialToolCooldown.gotoAndStop(1);
						specialToolCooldown.timeToWait = Variables.SPECIAL_MINES_COOLTIME;
						if(Variables.SPECIAL_MINES_COOLTIME < 200) specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05) + ".0";
						else specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05);
						toolsScreen.addChild(specialToolCooldown);
						specialToolsCooldownsArray.push(specialToolCooldown);
						
						specialToolsGauge--;
						for(i = specialToolsGaugeArray.length; --i >= 0;)
						{
							gauge = specialToolsGaugeArray[i] as MovieClip;
							if(gauge.currentFrame < gauge.totalFrames)
							{
								cFrame = gauge.currentFrame;
								gauge.gotoAndStop(1);
							}
							else if(gauge.currentFrame >= gauge.totalFrames)
							{
								gauge.gotoAndStop(cFrame);
								break;
							}
						}
					break;
				}
				enemy = null;
			}
		}
		
		private function showToolInfo(e:MouseEvent):void
		{
			if(levelStarted)
			{
				toolInfo = new SpecialToolInfo(e.currentTarget.type);
				toolInfo.x = stage.mouseX;
				toolInfo.y = stage.mouseY;
				addChild(toolInfo);
			}
		}
		
		private function hideToolInfo(e:MouseEvent = null):void
		{
			if(toolInfo)
			{
				removeChild(toolInfo);
				toolInfo = null;
			}
		}
		
		private function moveToolInfo(e:MouseEvent):void
		{
			if(toolInfo)
			{
				toolInfo.x = stage.mouseX;
				toolInfo.y = stage.mouseY;
			}
		}
		
		private function placeFalseTarget(e:MouseEvent):void
		{
			if(falseTarget.canBePlaced)
			{				
				falseTarget.removeEventListener(MouseEvent.CLICK, placeFalseTarget);
				falseTarget.alpha = 1;
				falseTarget.placed = true;
				placingFalseTarget = false;
				if(cancelToolClip)
				{
					toolsScreen.removeChild(cancelToolClip);
					cancelToolClip = null;
				}
				
				for(var i:int = specialToolsDisablesArray.length; --i >= 0;) removeObject(i, specialToolsDisablesArray);
				
				specialToolsGauge--;
				var frame:int = 1;
				for(var g:int = specialToolsGaugeArray.length; --g >= 0;)
				{
					var gauge:MovieClip = specialToolsGaugeArray[g] as MovieClip;
					if(gauge.currentFrame < gauge.totalFrames)
					{
						frame = gauge.currentFrame;
						gauge.gotoAndStop(1);
					}
					else if(gauge.currentFrame >= gauge.totalFrames)
					{
						gauge.gotoAndStop(frame);
						break;
					}
				}
				
				
				for each(var tool:SpecialTools in specialToolsArray)
				{ 
					if(tool.type == SpecialTools.FALSE_TARGET)
					{
						specialToolCooldown = new SpecialToolsCooldown();
						specialToolCooldown.x = tool.x;
						specialToolCooldown.y = tool.y;
						specialToolCooldown.gotoAndStop(1);
						specialToolCooldown.timeToWait = Variables.SPECIAL_FALSE_TARGET_COOLTIME;
						if(Variables.SPECIAL_FALSE_TARGET_COOLTIME >= 200) specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05);
						else specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05) + ".0";
						toolsScreen.addChild(specialToolCooldown);
						specialToolsCooldownsArray.push(specialToolCooldown);
					} 
					tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_OVER, showToolInfo, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_OUT, hideToolInfo, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo, false, 0, true);
				}
			}
		}
		
		private function checkRoadForFalseTarget():void
		{
			falseTarget.alpha = 0;
			falseTarget.canBePlaced = false;
			for each(var road:RoadTile in roadArray)
			{
				road.collideWithEnemy = false;
				for each(var enemy:Enemy in enemyArray)
				{
					if(enemy.hitTestObject(road)) road.collideWithEnemy = true;
				}
				if(!road.collideWithEnemy)
				{
					if(mouseX > road.x && mouseX < road.x + road.width && mouseY > road.y && mouseY < road.y + road.height)
					{
						falseTarget.x = road.x + road.width * .5;
						falseTarget.y = road.y + road.height * .5;
						falseTarget.alpha = .5;
						falseTarget.canBePlaced = true;
					}
				}
			}
		}
		
		private function cancelTool(e:MouseEvent):void
		{
			cancelToolClip.parent.removeChild(cancelToolClip);
			cancelToolClip = null;
			for each(var tool:SpecialTools in specialToolsArray)
			{
				tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
				tool.addEventListener(MouseEvent.MOUSE_OVER, showToolInfo, false, 0, true);
				tool.addEventListener(MouseEvent.MOUSE_OUT, hideToolInfo, false, 0, true);
				tool.addEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo, false, 0, true);
			}
			addingMarker = false;
			turretRelocatingON = false;
			relocatingTurretChoosen = false;
			placingFalseTarget = false;
			
			for(var i:int = specialToolsDisablesArray.length; --i >= 0;) removeObject(i, specialToolsDisablesArray);
			
			if(relocationTurretClip)
			{
				relocationTurretClip.parent.removeChild(relocationTurretClip);
				relocationTurretClip = null;
			}
			for(var f:int = availableActionFlagsArray.length; --f >= 0;) removeObject(f, availableActionFlagsArray);
			
			if(falseTarget)
			{
				falseTarget.parent.removeChild(falseTarget);
				falseTarget = null;
			}
		}
		
		private function addMarkerCounter(e:MouseEvent):void
		{
			var ground:GroundTile = e.currentTarget as GroundTile;
			if(addingMarker && ground.nearRoad)
			{
				var counter:MovieClip = new AddMarkerCounter();
				counter.gotoAndStop(1);
				counter.x = ground.x + ground.width * .5;
				counter.y = ground.y + ground.height * .5;
				counter.txtCount.text = "0 %";
				counter.groundInAction = ground;
				markerHolder.addChild(counter);
				addMarkerCounterArray.push(counter);
				for each(var tool:SpecialTools in specialToolsArray)
				{ 
					if(tool.type == SpecialTools.ADDITIONAL_MARKER)
					{
						specialToolCooldown = new SpecialToolsCooldown();
						specialToolCooldown.x = tool.x;
						specialToolCooldown.y = tool.y;
						specialToolCooldown.gotoAndStop(1);
						specialToolCooldown.timeToWait = Variables.SPECIAL_ADDITIONAL_MARKER_COOLTIME;
						if(Variables.SPECIAL_ADDITIONAL_MARKER_COOLTIME < 200) specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05) + ".0";
						else specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05);
						toolsScreen.addChild(specialToolCooldown);
						specialToolsCooldownsArray.push(specialToolCooldown);
					} 
					tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_OVER, showToolInfo, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_OUT, hideToolInfo, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo, false, 0, true);
				}
				addingMarker = false;
				ground.nearRoad = false;
				ground.removeEventListener(MouseEvent.CLICK, addMarker);
				if(cancelToolClip)
				{
					toolsScreen.removeChild(cancelToolClip);
					cancelToolClip = null;
				}
				
				for(var i:int = specialToolsDisablesArray.length; --i >= 0;) removeObject(i, specialToolsDisablesArray);
				for(var f:int = availableActionFlagsArray.length; --f >= 0;) removeObject(f, availableActionFlagsArray);
				
				specialToolsGauge--;
				var frame:int = 1;
				for(var g:int = specialToolsGaugeArray.length; --g >= 0;)
				{
					var gauge:MovieClip = specialToolsGaugeArray[g] as MovieClip;
					if(gauge.currentFrame < gauge.totalFrames)
					{
						frame = gauge.currentFrame;
						gauge.gotoAndStop(1);
					}
					else if(gauge.currentFrame >= gauge.totalFrames)
					{
						gauge.gotoAndStop(frame);
						break;
					}
				}
			}
		}
		
		private function checkMarkerCounter():void
		{
			for(var i:int = addMarkerCounterArray.length; --i >= 0;)
			{
				var counter:MovieClip = addMarkerCounterArray[i] as MovieClip;
				counter.passTime++;
				var cTime:int = Math.floor(counter.passTime / counter.addingTime * 100)
				counter.txtCount.text = String(cTime) + " %";
				counter.gotoAndStop(cTime);
				if(counter.currentFrame > 99)
				{
					addMarker(counter.groundInAction);
					removeObject(i, addMarkerCounterArray);
				}
			}
		}
		
		private function addMarker(targetGround:GroundTile):void
		{
			var ground:GroundTile = targetGround;
			var marker:PlaceMarker = new PlaceMarker();
			marker.x = ground.x;
			marker.y = ground.y;
			marker.addEventListener(MouseEvent.MOUSE_OVER, showRange, false, 0, true);
			marker.addEventListener(MouseEvent.MOUSE_OUT, hideRange, false, 0, true);
			marker.addEventListener(MouseEvent.CLICK, clickMarker, false, 0, true);
			markerHolder.addChild(marker);
			markerArray.push(marker);
			ground.parent.removeChild(ground);
			ground = null;
		}
		
		private function clickMarker(e:MouseEvent):void
		{
			unClick();
			if(addingMarker || placingFalseTarget){}
			else if(turretRelocatingON && !relocatingTurretChoosen){}
			else if(turretRelocatingON && relocatingTurretChoosen)
			{
				startInstallTurret(relocationTurretClip.turretType, relocationTurretClip.turretLevel, e.currentTarget.x, e.currentTarget.y);
				startUninstallTurret(e);
				e.currentTarget.free = false;
				
				for(var i:int = specialToolsDisablesArray.length; --i >= 0;) removeObject(i, specialToolsDisablesArray);
				for(var f:int = availableActionFlagsArray.length; --f >= 0;) removeObject(f, availableActionFlagsArray);
				
				specialToolsGauge--;
				var frame:int = 1;
				for(var g:int = specialToolsGaugeArray.length; --g >= 0;)
				{
					var gauge:MovieClip = specialToolsGaugeArray[g] as MovieClip;
					if(gauge.currentFrame < gauge.totalFrames)
					{
						frame = gauge.currentFrame;
						gauge.gotoAndStop(1);
					}
					else if(gauge.currentFrame >= gauge.totalFrames)
					{
						gauge.gotoAndStop(frame);
						break;
					}
				}
				
				for each(var tool:SpecialTools in specialToolsArray)
				{ 
					if(tool.type == SpecialTools.RELOCATE_TURRET)
					{
						specialToolCooldown = new SpecialToolsCooldown();
						specialToolCooldown.x = tool.x;
						specialToolCooldown.y = tool.y;
						specialToolCooldown.gotoAndStop(1);
						specialToolCooldown.timeToWait = Variables.SPECIAL_RELOCATE_TURRET_COOLTIME;
						if(Variables.SPECIAL_RELOCATE_TURRET_COOLTIME < 200) specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05) + ".0";
						else specialToolCooldown.txtCounter.text = String(specialToolCooldown.timeToWait * .05);
						toolsScreen.addChild(specialToolCooldown);
						specialToolsCooldownsArray.push(specialToolCooldown);
					} 
					tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_OVER, showToolInfo, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_OUT, hideToolInfo, false, 0, true);
					tool.addEventListener(MouseEvent.MOUSE_MOVE, moveToolInfo, false, 0, true);
				}
			}
			else showBuyTurretInfo(e);
		}
		
		private function removeObject(index:int, group:Array):void
		{
			var obj:* = group[index];
			var par:* = obj.parent;
			par.removeChild(obj);
			group.splice(index, 1);
			obj = null;
		}
	}
}

/*

*/