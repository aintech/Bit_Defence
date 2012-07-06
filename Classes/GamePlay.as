//TODO: Всем gotoAndStop пусть указывают на кадр с названием а не номером
//TODO: Оптимизировать MapScreen, чтобы тамошний код не повторялся для каждого уровня
//TODO: Каждый вид врага взрывается по-своему
//TODO: MissileTurret - целью ракет желательно делать врага, который ближе всех к концу пути
//TODO: сделать прелоадер
//TODO: Экраны должны плавно переходить друг в друга
//TODO: Графические обозначения того, что враг отравлен или заторможен или по нему нанесен крит
//HELP: ||

//TODO: СпецТехника:
//Дополнительный контур защиты - снижает вероятность взлома системы
//Остановка потока - все враги на время замирают
//Перегрузка потока - наносятся повреждения всем врагам
//Переустановка - перестановка турели со всеми апгрейдами на другой маркер
//Подключение дополнительного маркера - можно создать новый маркер, на который можно установить турель
//Мина - устанавлвается на дороге и наносит и взрывается при прикосновении противника

//TODO: Сделать куллтаймы спецтехник в привязке к Variables
//TODO: спецтехники работают только когда levelStarted

//TODO: ИЗ врагов должны выпадать символы
//TODO: нажатии кнопки не исчезают, а уменьшаются - для создания анимации
//TODO: проработать систему символов

//TODO: Делаем апгрейды, в одном клипе собираем все иконки и выкладываем вручную на сцену, добавляем в массив
//		все серое - апгрейд невозможен
//		серая рамка, цветной символ - апгрейд возможен
//		все цветное - апгрейд уже произведен
//		при наведении - желтый shadowFilter, при нажатии - белый///////////////////////////////////////////////////////////////////////////////////
package 
{
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.filters.GlowFilter;
	import flash.filters.BlurFilter;

	public class GamePlay extends MovieClip
	{
		public static const P:String = "Road";
		public static const G:String = "Ground";
		public static const M:String = "PlaceMarker";
		
		public static const S:String = "Start";
		public static const F:String = "Finish";
		public static const U:String = "Up";
		public static const D:String = "Down";
		public static const R:String = "Right";
		public static const L:String = "Left";
		
		public var currentLevel:int;
		public var currentWave:int = 1;
		public var levelData:LevelData = new LevelData();
		
		public var levelMap:Array = [];
		public var enemyWaves:Array = [];
		
		public var roadStart:Point = new Point();
		public var roadEnd:Point 	= new Point();
		
		public var scoreBoard:ScoreBoard = new ScoreBoard();
		public var background:MovieClip;
		public var road:MovieClip;
		
		public var backgroundHolder:Sprite 		= new Sprite();
		public var blocksHolder:Sprite			= new Sprite();
		public var groundHolder:Sprite 			= new Sprite();
		public var roadHolder:Sprite				= new Sprite();
		public var markerHolder:Sprite 			= new Sprite();
		public var enemyHolder:Sprite 			= new Sprite();
		public var turretHolder:Sprite 			= new Sprite();
		public var bulletHolder:Sprite 			= new Sprite();
		public var charHolder:Sprite 				= new Sprite();
		public var userInterface:Sprite			= new Sprite();
		public var toolGaugeScreen:Sprite		= new Sprite();
		
		public var charScreen:MovieClip;
		public var availableCharArray:Array = [];
		public var charIconXOffset:int = 3;
		public var charIconYOffset:int = 3;
		public var charIcon:MovieClip;
		public var dragCharIcon:MovieClip;
		public var dragging:Boolean = false;
		public var charInfo:MovieClip;
		
		public var toolsScreen:MovieClip;
		public var availableToolsArray:Array = [];
		public var toolIconXOffset:int = 3;
		public var toolIconYOffset:int = 3;
		public var toolIcon:MovieClip;
		public var toolInfo:MovieClip;
		
		public var tempChar:MovieClip;
		public var baseCharInfo:MovieClip;
		
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
		
		public var enemyArray:Array 						= [];
		public var groundArray:Array						= [];
		public var directArray:Array 						= [];
		public var markerArray:Array 						= [];
		public var turretArray:Array 						= [];
		public var rocketArray:Array 						= [];
		public var splashArray:Array 						= [];
		public var swarmSplashArray:Array				= [];
		public var missileArray:Array 					= [];
		public var particleArray:Array 					= [];
		public var installingArray:Array					= [];
		public var upgradingArray:Array					= [];
		public var uninstallingArray:Array				= [];
		public var specialToolsArray:Array				= [];
		public var specialToolsGaugeArray:Array		= [];
		public var specialToolsCooldownsArray:Array	= [];
		public var specialToolsDisablesArray:Array	= [];
		public var addMarkerCounterArray:Array			= [];
		public var availableActionFlagsArray:Array	= [];
		
		public var mapCols:int = 15;
		public var mapRows:int = 10;
		
		public var memoryTotal:int = 300;
		public var memoryUsed:int 	= 0;
		
		public var gameOver:Boolean = false;
		public var gamePaused:Boolean = false;
		
		public var optionsGearBtn:SimpleButton;
		
		public var specialToolsGauge:int = Variables.SPECIAL_TOOL_GAUGE;
		public var addingMarker:Boolean = false;
		public var specialToolCooldownClip:MovieClip;
		public var specialToolDisableClip:Sprite;
		
		public var cancelToolClip:MovieClip;
		
		public var turretRelocatingON:Boolean = false;
		public var relocatingTurretChoosen:Boolean = false;
		public var relocationTurretClip:MovieClip;
		
		public var toolStunInAction:Boolean = false;
		public var toolStunCounter:int;
		
		public var startLevelBtn:MovieClip;
		public var levelStarted:Boolean = false;
		
		public var startBanner:Banner;
		public var startWaveBtn:MovieClip;
		public var startWaveBtnArrow:MovieClip;
		public var nextWaveTimer:Timer;
		public var waveTimerInAction:Boolean = false;
				
		public function GamePlay(level:int, gameWidth:int, gameHeight:int)
		{
			currentLevel = level;
			this.gameWidth = gameWidth;
			this.gameHeight = gameHeight;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			levelMap = levelData.makeLevel(currentLevel);
			enemyWaves = levelData.makeEnemies(currentLevel);
			availableCharArray = levelData.levelChars(currentLevel);
			availableToolsArray = levelData.levelTools(currentLevel);
			
			addChild(backgroundHolder);
			addChild(roadHolder);
			addChild(blocksHolder);
			blocksHolder.alpha = 0;
			addChild(groundHolder);
			addChild(markerHolder);
			addChild(enemyHolder);
			addChild(turretHolder);
			addChild(bulletHolder);
			addChild(charHolder);
			addChild(userInterface);
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
					break;
					
					case Turret.TURRET_LAUNCHER:
					character = new LauncherTurret();
					charIcon = new CharIcon(Turret.TURRET_LAUNCHER);
					charIcon.gotoAndStop("launcherTurret");
					break;
					
					case Turret.TURRET_SWARM:
					character = new MissileTurret();
					charIcon = new CharIcon(Turret.TURRET_SWARM);
					charIcon.gotoAndStop("missileTurret");
					break;
					
					case Turret.TURRET_FREEZE:
					character = new FreezeTurret();
					charIcon = new CharIcon(Turret.TURRET_FREEZE);
					charIcon.gotoAndStop("freezeTurret");
					break;
				}
				
				charScreen.addChild(charIcon);
				charIcon.x = i * charIcon.width + charIconXOffset;
				charIcon.y = -charIcon.height - charIconYOffset;
				character.updateLevel();
				charIcon.range = character.range;
				charIcon.memoryUse = character.memoryUse;
				character = null;
				charIcon.addEventListener(MouseEvent.MOUSE_OVER, showBaseCharInfo, false, 0, true);
				charIcon.addEventListener(MouseEvent.MOUSE_OUT, hideBaseCharInfo, false, 0, true);
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
					break;
					
					case SpecialTools.FLOW_OVERLOAD:
					toolIcon = new SpecialTools(SpecialTools.FLOW_OVERLOAD);
					toolIcon.gotoAndStop("flowOverload");
					break;
					
					case SpecialTools.FLOW_STOP:
					toolIcon = new SpecialTools(SpecialTools.FLOW_STOP);
					toolIcon.gotoAndStop("flowStop");
					break;
					
					case SpecialTools.HACK_CHANCE_REDUCE:
					toolIcon = new SpecialTools(SpecialTools.HACK_CHANCE_REDUCE);
					toolIcon.gotoAndStop("hackChanceReduce");
					break;
					
					case SpecialTools.RELOCATE_TURRET:
					toolIcon = new SpecialTools(SpecialTools.RELOCATE_TURRET);
					toolIcon.gotoAndStop("relocateTurret");
					break;
				}
				
				toolsScreen.addChild(toolIcon);
				toolIcon.x = (s * toolIcon.width + toolIconXOffset) + toolIcon.width * .5;
				toolIcon.y = (-toolIcon.height - toolIconYOffset) + toolIcon.height * .5;
				toolIcon.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
				toolIcon.mouseEnabled = true;
				specialToolsArray.push(toolIcon);
				
				specialToolDisableClip = new SpecialToolDisable();
				specialToolDisableClip.x = toolIcon.x;
				specialToolDisableClip.y = toolIcon.y;
				specialToolsDisablesArray.push(specialToolDisableClip);
				toolsScreen.addChild(specialToolDisableClip);
			}
			stage.addEventListener(MouseEvent.CLICK, unClickMarker, false, 0, true);					
			stage.addEventListener(MouseEvent.CLICK, unClickTurret, false, 0, true);
			
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
			scoreBoard.txtHackChance.text = "hack: */*";
			
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
					if(levelMap[i-1] == P || levelMap[i-1] == S || levelMap[i-1] == F || levelMap[i-1] == U || levelMap[i-1] == D || levelMap[i-1] == R || levelMap[i-1] == L ||
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
					block = new EmptyRoadTile();
					block.x = (i - row * cols) * block.width;
					block.y = row * block.height;
					blocksHolder.addChild(block);
				}
				else
				{
					block = new RoadTile(levelMap[i], (i - row * cols) * block.width, row * block.height)
					block.ID = roadTileID;
					roadTileID++;
					blocksHolder.addChild(block);
					directArray.push(block);
					
					if(levelMap[i] == S) roadStart = new Point(((i - row * cols) * block.width) - block.width, row * block.height + block.height * .5);
					else if(levelMap[i] == F) roadEnd = new Point(((i - row * cols) * block.width) + block.width, row * block.height + block.height * .5);
				}
				
				for(var c:int = 1; c <= rows; c++)
				{
					if(i == c * cols - 1)
					row++;
				}
			}
		}
		
		private function showOptions(e:MouseEvent):void
		{
			dispatchEvent(new CustomEvents(CustomEvents.SHOW_OPTIONS));
		}
		
		private function gameLoop(e:TimerEvent):void
		{
			stage.focus = this;
			checkBanners();
			checkForEndLevel();
			checkSettings();
			fillSpecialGauge();
			installTurrets();
			upgradeTurrets();
			uninstallTurrets();
			checkMarkerCounter();
			makeEnemies();
			checkEnemies();
			updateEnemies();
			updateExplosions();
			checkTurrets();
			updateBullets();
			checkForNextWave();
			updateScoreBoard();
		}
		
		private function checkBanners():void
		{
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
		}
		
		private function checkSettings():void
		{
			if(Settings.SETTINGS_CHANGED)
			{
				for(var i:int = enemyArray.length; --i >=0;)
				{
					var enemy:Enemy = enemyArray[i];
					if(Settings.LIFEBAR_VISIBLE) enemy.lifeBar.visible = true;
					else if(!Settings.LIFEBAR_VISIBLE) enemy.lifeBar.visible = false;
				}
			}
			
			Settings.SETTINGS_CHANGED = false;
		}
		
		private function fillSpecialGauge():void
		{
			specialToolsGauge = 0;
			for(var i:int = 0; i < specialToolsGaugeArray.length; i++)
			{
				var gauge:MovieClip = specialToolsGaugeArray[i] as MovieClip;
				var cFrame:int = gauge.currentFrame;
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
				var cooldown:MovieClip = specialToolsCooldownsArray[k] as MovieClip;
				if(cooldown.currentFrame >= 100) removeObject(k, specialToolsCooldownsArray);
			}
		}
		
		private function makeEnemies():void
		{
			if(currentWave <= enemyWaves.length && levelStarted)
			{
				if(enemyTime < enemyLimit) enemyTime++;
				else
				{
					var id:int = enemyWaves[currentWave - 1][currentEnemy];
					var tempEnemy:MovieClip;
					switch(id)
					{
						case 1:
						tempEnemy = new Enemy_Speeder();
						break;
						
						case 2:
						tempEnemy = new Enemy_Worm();
						break;
						
						default:
						tempEnemy = null;
						break;
					}
					if(tempEnemy)
					{
						enemyArray.push(tempEnemy);
						enemyHolder.addChild(tempEnemy);
						currentEnemy++;
						enemyTime = 0;
					}
				}
			}
		}
		
		private function updateEnemies():void
		{
			var enemyLength:int = enemyArray.length;
			for(var i:int = enemyLength; --i >= 0;)
			{
				var tempEnemy:MovieClip = enemyArray[i];
				for(var j:int = 0; j < directArray.length; j++)
				{
					var dirTile:MovieClip = directArray[j];
					if(tempEnemy.hitPoint.hitTestObject(dirTile.hitPoint) && tempEnemy.roadID != dirTile.ID)
					{
						switch(dirTile.direct)
						{
							case "Up":
								tempEnemy.rotation = -90;
								if(toolStunInAction || tempEnemy.speedUP) tempEnemy.ySpeed = -Math.abs(tempEnemy.xSpeed);
								else tempEnemy.ySpeed = -tempEnemy.speed;
								tempEnemy.xSpeed = 0;
								tempEnemy.lifeBar.rotation = 90;
								tempEnemy.lifeBar.x = tempEnemy.lifeBarUP.x;
								tempEnemy.lifeBar.y = tempEnemy.lifeBarUP.y;
							break;
							
							case "Down":
								tempEnemy.rotation = 90;
								if(toolStunInAction || tempEnemy.speedUP) tempEnemy.ySpeed = Math.abs(tempEnemy.xSpeed);
								else tempEnemy.ySpeed = tempEnemy.speed;
								tempEnemy.xSpeed = 0;
								tempEnemy.lifeBar.rotation = -90;
								tempEnemy.lifeBar.x = tempEnemy.lifeBarDOWN.x;
								tempEnemy.lifeBar.y = tempEnemy.lifeBarDOWN.y;
							break;
							
							case "Right":
								tempEnemy.rotation = 0;
								if(toolStunInAction || tempEnemy.speedUP) tempEnemy.xSpeed = Math.abs(tempEnemy.ySpeed);
								else tempEnemy.xSpeed = tempEnemy.speed;
								tempEnemy.ySpeed = 0;
								tempEnemy.lifeBar.rotation = 0;
								tempEnemy.lifeBar.x = tempEnemy.lifeBarRIGHT.x;
								tempEnemy.lifeBar.y = tempEnemy.lifeBarRIGHT.y;
							break;
							
							case "Left":
								tempEnemy.rotation = -180;
								if(toolStunInAction || tempEnemy.speedUP) tempEnemy.xSpeed = -Math.abs(tempEnemy.ySpeed);
								else tempEnemy.xSpeed = -tempEnemy.speed;
								tempEnemy.ySpeed = 0;
								tempEnemy.lifeBar.rotation = 180;
								tempEnemy.lifeBar.x = tempEnemy.lifeBarLEFT.x;
								tempEnemy.lifeBar.y = tempEnemy.lifeBarLEFT.y;
							break;
						}
						tempEnemy.roadID = dirTile.ID;
					}
				}
				
				if(toolStunInAction)
				{
					if(!tempEnemy.firstStun)
					{
						tempEnemy.previusXSpeed = tempEnemy.xSpeed;
						tempEnemy.previusYSpeed = tempEnemy.ySpeed;
						tempEnemy.firstStun = true;
					}
					if(tempEnemy.xSpeed > 0) tempEnemy.xSpeed -= .5;
					else if(tempEnemy.xSpeed < 0) tempEnemy.xSpeed += .5;
					else if(tempEnemy.ySpeed > 0) tempEnemy.ySpeed -= .5;
					else if(tempEnemy.ySpeed < 0) tempEnemy.ySpeed += .5;
					
					tempEnemy.x += tempEnemy.xSpeed;
					tempEnemy.y += tempEnemy.ySpeed;
				}
				else if(tempEnemy.speedUP)
				{
					switch(tempEnemy.rotation)
					{
						case 0://Right
							if(tempEnemy.xSpeed < tempEnemy.speed) tempEnemy.xSpeed += .5;
							tempEnemy.ySpeed = 0;
						break;
							
						case 90://Down
							tempEnemy.xSpeed = 0;
							if(tempEnemy.ySpeed < tempEnemy.speed) tempEnemy.ySpeed += .5;
						break;
							
						case -90://Up
							tempEnemy.xSpeed = 0;
							if(tempEnemy.ySpeed > -tempEnemy.speed) tempEnemy.ySpeed -= .5;
						break;
							
						case -180://Left
							if(tempEnemy.xSpeed > -tempEnemy.speed) tempEnemy.xSpeed -= .5;
							tempEnemy.ySpeed = 0;
						break;
					}
					tempEnemy.x += tempEnemy.xSpeed;
					tempEnemy.y += tempEnemy.ySpeed;
					
					if(tempEnemy.xSpeed == tempEnemy.previusXSpeed && tempEnemy.ySpeed == tempEnemy.previusYSpeed) tempEnemy.speedUP = false;
				}
				else if(tempEnemy.isStuned)
				{
					tempEnemy.x += 0;
					tempEnemy.y += 0;
					
					tempEnemy.stunCounter++;
					if(tempEnemy.stunCounter > tempEnemy.maxTimeStuned)
					{
						tempEnemy.isStuned = false;
						tempEnemy.stunCounter = 0;
						var clip:* = tempEnemy.getChildByName("clip");
						clip.gotoAndPlay(clip.currentFrame);
						clip = null;
					}
				}
				else if(tempEnemy.underFreeze)
				{
					tempEnemy.x += tempEnemy.xSpeed * Variables.FREEZE_SPEED_REDUCE_MULTIPLY;
					tempEnemy.y += tempEnemy.ySpeed * Variables.FREEZE_SPEED_REDUCE_MULTIPLY;
					
					tempEnemy.freezeCounter++;
					if(tempEnemy.freezeCounter > tempEnemy.maxTimeFreeze) 
					{
						tempEnemy.underFreeze = false;
						tempEnemy.freezeCounter = 0;
					}
				}
				else
				{
					tempEnemy.x += tempEnemy.xSpeed;
					tempEnemy.y += tempEnemy.ySpeed;
				}
				
				if(tempEnemy.isPoisoned)
				{
					tempEnemy.health -= Variables.LAUNCHER_POISON_DAMAGE;
					tempEnemy.lifeBar.gotoAndStop(Math.floor(tempEnemy.health / tempEnemy.maxHealth * 100));
					tempEnemy.poisonCounter++;
					if(tempEnemy.poisonCounter > tempEnemy.maxPoisonCounter)
					{
						tempEnemy.isPoisoned = false;
						tempEnemy.poisonCounter = 0;
					}
				}
				
				if(tempEnemy.x >= roadEnd.x)
				{
					checkForHack(tempEnemy.hackChance);
					removeObject(i, enemyArray);
					enemiesLeft--;
				}
			}
			if(toolStunInAction) toolStunCounter--;
			if(toolStunCounter <= 0  && toolStunInAction)
			{
				toolStunInAction = false;
				for each(var enemy:Enemy in enemyArray)
				{
					enemy.speedUP = true;
					enemy.firstStun = false;
					var eClip:* = enemy.getChildByName("clip");
					eClip.gotoAndPlay(eClip.currentFrame);
					eClip = null;
				}
			}
		}
		
		private function showBaseCharInfo(e:MouseEvent):void
		{
			if(!charInfo)
			{
				switch(e.currentTarget.charType)
				{
					case Turret.TURRET_GUN:
					tempChar = new GunTurret();
					break;
					
					case Turret.TURRET_LAUNCHER:
					tempChar = new LauncherTurret();
					break;
					
					case Turret.TURRET_SWARM:
					tempChar = new MissileTurret();
					break;
					
					case Turret.TURRET_FREEZE:
					tempChar = new FreezeTurret();
					break;
				}
				
				tempChar.updateLevel();
				
				baseCharInfo = new BaseCharInfo();
				
				if(e.currentTarget.charType == Turret.TURRET_GUN) baseCharInfo.txtCharType.text = "Gun";
				else if(e.currentTarget.charType == Turret.TURRET_LAUNCHER) baseCharInfo.txtCharType.text = "Launcher";
				else if(e.currentTarget.charType == Turret.TURRET_SWARM) baseCharInfo.txtCharType.text = "Swarm";
				else if(e.currentTarget.charType == Turret.TURRET_FREEZE) baseCharInfo.txtCharType.text = "Freeze";
				
				baseCharInfo.txtMemoryUse.text 		= "$: " + tempChar.memoryUse;
				baseCharInfo.txtDamage.text			= "Damage: " + tempChar.damage;
				baseCharInfo.txtRange.text 			= "Range: " + tempChar.range;
				baseCharInfo.txtReloadTime.text 		= "Reload Time: " + tempChar.reloadTime;
				baseCharInfo.txtAbility.text 			= tempChar.abilityDescription;
				
				baseCharInfo.x = gameWidth;
				baseCharInfo.y = gameHeight;
				charHolder.addChild(baseCharInfo);
			}
		}
		
		private function hideBaseCharInfo(e:MouseEvent):void
		{
			if(baseCharInfo)
			{
				charHolder.removeChild(baseCharInfo);
				baseCharInfo = null;
				tempChar = null;
			}
		}
		
		private function dragIcon(e:MouseEvent):void
		{
			if(charMenu) unClickTurret(e);
			
			if(chooseTurretCircle)
			{
				chooseTurretCircle.gunBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.launcherBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.freezeBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.swarmBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				turretHolder.removeChild(chooseTurretCircle);
				chooseTurretCircle = null;
			}
						
			if(confirmTurretCircle)
			{
				confirmTurretCircle.buyTurret.addEventListener(MouseEvent.CLICK, confirmTurret, false, 0, true);
				confirmTurretCircle.cancelTurret.addEventListener(MouseEvent.CLICK, cancelTurret, false, 0, true);
				turretHolder.removeChild(confirmTurretCircle);
				confirmTurretCircle = null;
			}
			
			if(rangeCircle)
			{
				rangeCircle.graphics.clear();
				removeChild(rangeCircle);
				rangeCircle = null;
			}
			
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
					dragCharIcon.gotoAndStop("missileTurret");
					break;
					
					case Turret.TURRET_FREEZE:
					dragCharIcon.gotoAndStop("freezeTurret");
					break;
				}
				dragCharIcon.x = stage.mouseX;
				dragCharIcon.y = stage.mouseY;
				addChild(dragCharIcon);
				dragCharIcon.startDrag();
				dragging = true;
			}
			else trace("not enought memory");
			
			stage.addEventListener(MouseEvent.MOUSE_UP, dropIcon, false, 0, true);
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
							startInstallTurret(dragCharIcon.charType, 1, marker.x, marker.y);
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
				unClickMarker(e);
				chooseTurretCircle = new ChooseTurretCircle();
				chooseTurretCircle.targetMarker = e.currentTarget;
				
				chooseTurretCircle.gunBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				chooseTurretCircle.launcherBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				chooseTurretCircle.freezeBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				chooseTurretCircle.swarmBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
				
				
				chooseTurretCircle.x = e.currentTarget.x + e.currentTarget.width * .5;
				chooseTurretCircle.y = e.currentTarget.y + e.currentTarget.height * .5;
				turretHolder.addChild(chooseTurretCircle);
			
				if(rangeCircle)
				{
					rangeCircle.graphics.clear();
					removeChild(rangeCircle);
					rangeCircle = null;
				}
			}
		}
		
		private function buyTurret(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				
				case "gunBtn":
				if(memoryTotal < (memoryUsed + Variables.GUN_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
				
				case "launcherBtn":
				if(memoryTotal < (memoryUsed + Variables.LAUNCHER_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
				
				case "swarmBtn":
				if(memoryTotal < (memoryUsed + Variables.SWARM_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
				
				case "freezeBtn":
				if(memoryTotal < (memoryUsed + Variables.FREEZE_TURRET_COST))
				{
					e.stopPropagation();
					trace("not enought memory");
					return;
				}
				break;
			}
			e.stopPropagation();
			
			confirmTurretCircle = new ConfirmTurretCircle();
			confirmTurretCircle.targetMarker = chooseTurretCircle.targetMarker;
			
			if(chooseTurretCircle)
			{
				chooseTurretCircle.gunBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.launcherBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.freezeBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.swarmBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
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
				case "gunBtn":
				tempChar = new GunTurret();
				confirmTurretCircle.turretType = Turret.TURRET_GUN;
				break;
				
				case "launcherBtn":
				tempChar = new LauncherTurret();
				confirmTurretCircle.abilityTxt.text = "Splash";
				confirmTurretCircle.turretType = Turret.TURRET_LAUNCHER;
				break;
				
				case "swarmBtn":
				tempChar = new MissileTurret();
				confirmTurretCircle.abilityTxt.text = "Missiles";
				confirmTurretCircle.turretType = Turret.TURRET_SWARM;
				break;
				
				case "freezeBtn":
				tempChar = new FreezeTurret();
				confirmTurretCircle.abilityTxt.text = "Freeze";
				confirmTurretCircle.turretType = Turret.TURRET_FREEZE;
				break;
			}
			
			tempChar.updateLevel();
			
			confirmTurretCircle.damageTxt.text = tempChar.damage;
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
			startInstallTurret(confirmTurretCircle.turretType, 1, marker.x, marker.y);
			
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
				confirmTurretCircle.buyTurret.addEventListener(MouseEvent.CLICK, confirmTurret, false, 0, true);
				confirmTurretCircle.cancelTurret.addEventListener(MouseEvent.CLICK, cancelTurret, false, 0, true);
				turretHolder.removeChild(confirmTurretCircle);
				confirmTurretCircle = null;
			}
			
			chooseTurretCircle.gunBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
			chooseTurretCircle.launcherBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
			chooseTurretCircle.freezeBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
			chooseTurretCircle.swarmBtn.addEventListener(MouseEvent.CLICK, buyTurret, false, 0, true);
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
		
		private function unClickMarker(e:MouseEvent):void
		{
			e.stopPropagation();
			if(chooseTurretCircle)
			{
				chooseTurretCircle.gunBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.launcherBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.freezeBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				chooseTurretCircle.swarmBtn.removeEventListener(MouseEvent.CLICK, buyTurret);
				turretHolder.removeChild(chooseTurretCircle);
				chooseTurretCircle = null;
			}
			if(confirmTurretCircle)
			{
				confirmTurretCircle.buyTurret.addEventListener(MouseEvent.CLICK, confirmTurret, false, 0, true);
				confirmTurretCircle.cancelTurret.addEventListener(MouseEvent.CLICK, cancelTurret, false, 0, true);
				turretHolder.removeChild(confirmTurretCircle);
				confirmTurretCircle = null;
			}
		}
		
		private function startInstallTurret(turretType:String, turLevel:int, xVal:int, yVal:int):void
		{
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
				turret = new MissileTurret();
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
			
			turret.x = xVal + turret.width * .5;
			turret.y = yVal + turret.height * .5;
			counter.x = turret.x;
			counter.y = turret.y;
			installingArray.push(counter);
			turretHolder.addChild(turret);
			turretHolder.addChild(counter);
			
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
					for each(var tool:SpecialTools in specialToolsArray) tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
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
			if(addingMarker){}
			else if(relocatingTurretChoosen){}
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
				if(charMenu) unClickTurret(e);
				
				var target:Object = e.currentTarget;
				e.stopPropagation();
			
				target.updateLevel();
			
				charMenu = new CharMenu();
				charMenu.x = target.x;
				charMenu.y = target.y;
				charMenu.target = target;
				charMenu.txtSellCost.text = target.memoryUse;
				charMenu.txtUpgradeCost.text = target.upgradeCost;
			
				if((target.level < target.maxLevel) && (memoryTotal >= memoryUsed + target.upgradeCost)) charMenu.upgradeBtn.addEventListener(MouseEvent.CLICK, startUpgradeTurret, false, 0, true);
				else if(target.level == target.maxLevel)
				{
					charMenu.upgradeBtn.visible = false;
					charMenu.upgradeBtn.mouseEnabled = false;
					charMenu.txtUpgradeCost.text = "";
				}
			
				charMenu.sellBtn.addEventListener(MouseEvent.CLICK, startUninstallTurret, false, 0, true);
				turretHolder.addChild(charMenu);
			
				charInfo = new CharInfo();
			
				if(target is GunTurret) charInfo.txtCharType.text = "Gun";
				else if(target is LauncherTurret) charInfo.txtCharType.text = "Launcher";
				else if(target is MissileTurret) charInfo.txtCharType.text = "Swarm";
				else if(target is FreezeTurret) charInfo.txtCharType.text = "Freeze";
			
				if(target.level < target.maxLevel)
				{
					charInfo.txtUpgradeCost.text	= "UpgradeCost $: " + target.upgradeCost;
				
					if(target.additionalDamage != 0) charInfo.txtDamageUP.text 			= "+ " + target.additionalDamage;
					else charInfo.txtDamageUP.text 												= "";
					if(target.additionalRange != 0) charInfo.txtRangeUP.text 			= "+ " + target.additionalRange;
					else charInfo.txtRangeUP.text 												= "";
					if(target.additionalReloadTime != 0) charInfo.txtReloadUP.text		= "- " + target.additionalReloadTime;
					else charInfo.txtReloadUP.text 												= "";
				}
				else 
				{
					charInfo.txtUpgradeCost.text	= "Upgrade Maximum";
					charInfo.txtDamageUP.text		= "";
					charInfo.txtRangeUP.text		= "";
					charInfo.txtReloadUP.text		= "";
				}
			
				charInfo.txtCharLevel.text 	= " lvl " + target.level;
				charInfo.txtDamage.text			= "Damage: " + target.damage;
				charInfo.txtRange.text			= "Range: " + target.range;
				charInfo.txtReloadTime.text	= "ReloadTime: " + target.reloadTime;
				charInfo.txtSellCost.text		= "SellCost $: " + target.memoryUse;
				charInfo.x = gameWidth;
				charInfo.y = gameHeight;
				charHolder.addChild(charInfo);
			
				showTurretRange(target.range, target.x, target.y);
			}
			unClickMarker(e);
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
		
		private function unClickTurret(e:MouseEvent):void
		{
			if(charMenu)
			{
				charMenu.sellBtn.removeEventListener(MouseEvent.CLICK, startUninstallTurret);
				turretHolder.removeChild(charMenu);
				charMenu = null;
				charHolder.removeChild(charInfo);
				charInfo = null;
			}
			if(rangeCircle)
			{
				rangeCircle.graphics.clear();
				removeChild(rangeCircle);
				rangeCircle = null;
			}
		}
				
		private function checkTurrets():void
		{
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
					var tempEnemy:Enemy = enemyArray[j];
					var targetDistance:Number = Math.sqrt((turret.x - tempEnemy.x) * (turret.x - tempEnemy.x) + (turret.y - tempEnemy.y) * (turret.y - tempEnemy.y));
					
					if(targetDistance < distance)
					{
						if(turret is FreezeTurret && (tempEnemy.underFreeze || tempEnemy.isStuned)){/*freezeTurret skip this enemy*/}
						else targetEnemy = tempEnemy;
					}
				}
				
				if(targetEnemy)
				{
					if(turret.gun.currentFrame == 1) turret.gun.rotation = Math.atan2((targetEnemy.y - turret.y), (targetEnemy.x - turret.x)) / Math.PI * 180;
					
					if(turret.loaded)
					{
						turret.loaded = false;
						
						if(turret is GunTurret)
						{
							turret.gun.gotoAndPlay("shot");
							
							if(turret.level >= 3  && (Math.random() * 100 < turret.gunCritChance)) targetEnemy.health -= turret.damage * turret.gunCritMultiply;
							else targetEnemy.health -= turret.damage;
							
							targetEnemy.lifeBar.gotoAndStop(Math.floor(targetEnemy.health / targetEnemy.maxHealth * 100));
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
						else if(turret is MissileTurret)
						{
							turret.gun.gotoAndPlay("shot");
							for(var t:int = 0; t < turret.numMissiles; t++)
							{
								var missile:Missile = new Missile();
								missile.turretLevel = turret.level;
								missile.damage = turret.damage;
								missile.x = turret.x;
								missile.y = turret.y;
								var minAngle:int = -(turret.numMissiles - 1) * 25;
								missile.rotation = turret.gun.rotation + minAngle + (t * 50);
								missile.target = targetEnemy;
								missileArray.push(missile);
								bulletHolder.addChild(missile);
							}
						}
						else if(turret is FreezeTurret)
						{
							if(!targetEnemy.underFreeze && !targetEnemy.isStuned && !toolStunInAction)
							{
								turret.gun.gotoAndStop("shot");
								turret.gun.rotation = 0;
							
								turret.gun.graphics.clear();
								turret.gun.graphics.lineStyle(2, 0xFF0000);
								turret.gun.graphics.moveTo(0, 0);
								turret.gun.graphics.lineTo(targetEnemy.x - turret.x, targetEnemy.y - turret.y);
								if(turret.level >= 3 && (Math.random() * 100 < turret.freezeStunChance))
								{
									targetEnemy.isStuned = true;
									var clip:* = targetEnemy.getChildByName("clip");
									clip.gotoAndStop(clip.currentFrame);
									clip = null;
								}
								else targetEnemy.underFreeze = true;
							}
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
		
		private function updateBullets():void
		{
			for(var i:int = rocketArray.length; --i >= 0;)
			{
				var rocket:Rocket = rocketArray[i];
				var xDist:Number = rocket.destX - rocket.x;
				var yDist:Number = rocket.destY - rocket.y;
				var rocketAngle:Number = Math.atan2(yDist, xDist);
				rocket.xSpeed = Math.cos(rocketAngle) * rocket.speed;
				rocket.ySpeed = Math.sin(rocketAngle) * rocket.speed;
				
				rocket.x += rocket.xSpeed;
				rocket.y += rocket.ySpeed;
				
				if(rocket.hitTestPoint(rocket.destX, rocket.destY))
				{
					createRocketSplash(i, rocket.damage, rocket.turretLevel, rocket.destX, rocket.destY);
				}
			}
			
			for(var s:int = splashArray.length; --s >= 0;)
			{
				var splash:LauncherSplash = splashArray[s];
				
				for(var e:int = enemyArray.length; --e >= 0;)
				{
					var enemy:Enemy = enemyArray[e];
					
					if(splash.splashHitZone)
					{
						if(splash.splashHitZone.hitTestObject(enemy))
						{
							if(splash.turretLevel >= 3 && (Math.random() * 100 < Variables.LAUNCHER_POISON_CHANCE)) enemy.isPoisoned = true;
							enemy.health -= splash.damage;
							enemy.lifeBar.gotoAndStop(Math.floor(enemy.health / enemy.maxHealth * 100));
						}
					}
				}
				if(splash.currentFrame >= 10) removeObject(s, splashArray);
			}
			
			for(var m:int = missileArray.length; --m >= 0;)
			{
				var missile:Missile = missileArray[m];
				
				if(missile.target.health < 0 && enemyArray.length > 0)
				{
					for(var ne:int = enemyArray.length; --ne >= 0;)
					{
						var newEnemy:Enemy = enemyArray[ne];
						missile.target = newEnemy;
					}
				}
				if(missile.target.health > 0)
				{
					var target:MovieClip = missile.target;
				
					var targetX:int = target.x - missile.x;
					var targetY:int = target.y - missile.y;					
					var rotation:int = Math.atan2(targetY, targetX) * 180 / Math.PI;
					if(Math.abs(rotation - missile.rotation) > 180)
					{
						if(rotation > 0 && missile.rotation < 0) missile.rotation -= (360 - rotation + missile.rotation) / missile.ease;
						else if(rotation < 0 && missile.rotation > 0) missile.rotation += (360 - rotation + missile.rotation) / missile.ease;
					}
					else if(rotation < missile.rotation) missile.rotation -= Math.abs(missile.rotation - rotation) / missile.ease;
					else missile.rotation += Math.abs(rotation - missile.rotation) / missile.ease;
				
					missile.xSpeed = missile.speed * (90 - Math.abs(missile.rotation)) / 90;
				
					if(missile.rotation < 0) missile.ySpeed = -missile.speed + Math.abs(missile.xSpeed);
					else missile.ySpeed = missile.speed - Math.abs(missile.xSpeed);
				
					missile.x += missile.xSpeed;
					missile.y += missile.ySpeed;
				
					if(missile.hitTestObject(target.clip.hitPoint)) 
					{
						if(missile.turretLevel >= 3 && (Math.random() * 100 < Variables.SWARM_SPLASH_CHANCE)) createSwarmSplash(missile.x, missile.y);
						target.health -= missile.damage;
						target.lifeBar.gotoAndStop(Math.floor(target.health / target.maxHealth * 100));
						removeObject(m, missileArray);
					}
					
					if(missile.ease > 1) missile.ease--;
					
				}
				else 
				{
					removeObject(m, missileArray);
				}
			}
			
			for(var k:int = swarmSplashArray.length; --k >= 0;)
			{
				var swSplash:SwarmSplash = swarmSplashArray[k];
				for(var n:int = enemyArray.length; --n >= 0;)
				{
					var sEnemy:Enemy = enemyArray[n];
					if(swSplash.hitZone)
					{
						if(swSplash.hitZone.hitTestObject(sEnemy))
						{
							sEnemy.health -= Variables.SWARM_SPLASH_DAMAGE;
							sEnemy.lifeBar.gotoAndStop(Math.floor(sEnemy.health / sEnemy.maxHealth * 100));
						}
					}
				}
				if(swSplash.currentFrame >= 10) removeObject(k, swarmSplashArray);
			}
		}
		
		private function createSwarmSplash(xVal:int, yVal:int):void
		{
			var splash:SwarmSplash = new SwarmSplash();
			splash.x = xVal;
			splash.y = yVal;
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
		
		private function checkEnemies():void
		{
			for(var i:int = enemyArray.length; --i >= 0;)
			{
				var enemy:Enemy = enemyArray[i];
				if(enemy.health <= 0)
				{
					createExplosion(enemy.x, enemy.y, enemy.levelColor);
					removeObject(i, enemyArray);
					enemiesLeft--;
				}
			}
		}
		
		private function createExplosion(xVal:int, yVal:int, color:uint):void
		{
			for(var i:int = 0; i < 50; i++)
			{
				var particle:Particle = new Particle(color);
				particle.rotation = Math.random() * 360;
				particle.speed = Math.random() * 10 + 5;
				particle.x = xVal;
				particle.y = yVal;
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
			if(enemiesLeft == 0 && !waveTimerInAction && currentWave < enemyWaves.length)
			{
				startWaveBtn = new StartWaveBtn();
				startWaveBtn.x = roadStart.x + 100;
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
		}
		
		private function countWaveDelay(e:TimerEvent):void
		{
			startWaveBtn.timeCounter.text = int(nextWaveTimer.repeatCount) - int(nextWaveTimer.currentCount);
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
						
			if(currentWave == enemyWaves.length && enemiesLeft == 0 && particleArray.length == 0)
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
		
		private function checkForHack(hackChance:int):void
		{
			var res:Number = Math.floor(Math.random() * 100);
			
			if(res < hackChance) gameOver = true;
			else scoreBoard.txtHackChance.text = "hack: " + hackChance + "/" + res;
		}
		
		private function updateScoreBoard():void
		{
			scoreBoard.txtWave.text 			= "Wave: " + currentWave + "/" + int(enemyWaves.length);
			scoreBoard.txtMemory.text 			= "Memory: " + memoryUsed + "/" + memoryTotal;
			scoreBoard.txtEnemiesLeft.text 	= "Enemies Left: " + enemiesLeft;
			scoreBoard.txtSymbols.text			= "Symbols: " + String(Variables.SYMBOLS);
			scoreBoard.txtSpecialTools.text	= "Special: " + specialToolsGauge;
		}
		
		private function clickTool(e:MouseEvent):void
		{
			if(specialToolsGauge > 0 && levelStarted)
			{
				var enemy:Enemy;
				var cFrame:int = 1;
				var gauge:MovieClip;
				var specTool:SpecialTools;
				
				switch(e.currentTarget.type)
				{
					case SpecialTools.HACK_CHANCE_REDUCE:
						for(var b:int = enemyArray.length; --b >= 0;)
						{
							enemy = enemyArray[b];
							if(!enemy.hackChanceDecreased)
							{
								enemy.hackChance *= Variables.SPECIAL_HACK_CHANCE_REDUCE_MULTIPLY;
								enemy.hackChanceDecreased = true;
							}
						}
						specialToolCooldownClip = new SpecialToolsCooldown();
						specialToolCooldownClip.x = e.currentTarget.x;
						specialToolCooldownClip.y = e.currentTarget.y;
						toolsScreen.addChild(specialToolCooldownClip);
						specialToolsCooldownsArray.push(specialToolCooldownClip);
						
						specialToolsGauge--;
						for(var ghc:int = specialToolsGaugeArray.length; --ghc >= 0;)
						{
							gauge = specialToolsGaugeArray[ghc] as MovieClip;
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
						toolStunInAction = true;
						toolStunCounter = Variables.SPECIAL_FLOW_STOP_DURATION;
						specialToolCooldownClip = new SpecialToolsCooldown();
						specialToolCooldownClip.x = e.currentTarget.x;
						specialToolCooldownClip.y = e.currentTarget.y;
						toolsScreen.addChild(specialToolCooldownClip);
						specialToolsCooldownsArray.push(specialToolCooldownClip);
						
						for each(enemy in enemyArray)
						{
							var clip:* = enemy.getChildByName("clip");
							clip.gotoAndStop(clip.currentFrame);
							clip = null;
						}
						specialToolsGauge--;
						for(var gfs:int = specialToolsGaugeArray.length; --gfs >= 0;)
						{
							gauge = specialToolsGaugeArray[gfs] as MovieClip;
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
						for(var i:int = enemyArray.length; --i >= 0;)
						{
							enemy = enemyArray[i];
							enemy.health -= Variables.SPECIAL_FLOW_OVERLOAD_DAMAGE;
							enemy.lifeBar.gotoAndStop(Math.floor(enemy.health / enemy.maxHealth * 100));
						}
						specialToolCooldownClip = new SpecialToolsCooldown();
						specialToolCooldownClip.x = e.currentTarget.x;
						specialToolCooldownClip.y = e.currentTarget.y;
						toolsScreen.addChild(specialToolCooldownClip);
						specialToolsCooldownsArray.push(specialToolCooldownClip);
						
						specialToolsGauge--;
						for(var gfo:int = specialToolsGaugeArray.length; --gfo >= 0;)
						{
							gauge = specialToolsGaugeArray[gfo] as MovieClip;
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
						for each(var toolA:SpecialTools in specialToolsArray) toolA.removeEventListener(MouseEvent.CLICK, clickTool);
						
						for each(var turret:Turret in turretArray)
						{
							var tempFlag:AvailableActionFlag = new AvailableActionFlag();
							tempFlag.x = turret.x;
							tempFlag.y = turret.y;
							availableActionFlagsArray.push(tempFlag);
							turretHolder.addChild(tempFlag);
						}
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
						for each(var toolB:SpecialTools in specialToolsArray) toolB.removeEventListener(MouseEvent.CLICK, clickTool);
						
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
					break;
				}
				enemy = null;
			}
		}
		
		private function cancelTool(e:MouseEvent):void
		{
			cancelToolClip.parent.removeChild(cancelToolClip);
			cancelToolClip = null;
			for each(var tool:SpecialTools in specialToolsArray) tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
			addingMarker = false;
			turretRelocatingON = false;
			relocatingTurretChoosen = false;
			
			for(var i:int = specialToolsDisablesArray.length; --i >= 0;) removeObject(i, specialToolsDisablesArray);
			
			if(relocationTurretClip)
			{
				relocationTurretClip.parent.removeChild(relocationTurretClip);
				relocationTurretClip = null;
			}
			for(var f:int = availableActionFlagsArray.length; --f >= 0;) removeObject(f, availableActionFlagsArray);
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
						specialToolCooldownClip = new SpecialToolsCooldown();
						specialToolCooldownClip.x = tool.x;
						specialToolCooldownClip.y = tool.y;
						toolsScreen.addChild(specialToolCooldownClip);
						specialToolsCooldownsArray.push(specialToolCooldownClip);
					} 
					tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
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
			if(addingMarker){}
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
						specialToolCooldownClip = new SpecialToolsCooldown();
						specialToolCooldownClip.x = tool.x;
						specialToolCooldownClip.y = tool.y;
						toolsScreen.addChild(specialToolCooldownClip);
						specialToolsCooldownsArray.push(specialToolCooldownClip);
					} 
					tool.addEventListener(MouseEvent.CLICK, clickTool, false, 0, true);
				}
			}
			else showBuyTurretInfo(e);
			unClickTurret(e);
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