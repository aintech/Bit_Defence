package 
{
	public class LevelData
	{				
		public static function makeLevel(level:int):Array
		{
			var P:String = "Road";
			var G:String = "Ground";
			var M:String = "PlaceMarker";
		
			var S:String = "Start";
			var F:String = "Finish";
			var U:String = Enemy.DIR_UP;
			var D:String = Enemy.DIR_DOWN;
			var R:String = Enemy.DIR_RIGHT;
			var L:String = Enemy.DIR_LEFT;
		
			var levelMapArray:Array;
			switch(level)
			{
				case 1:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, R, P, P, P, P, D, G, G, G, G, G, G, G, G,
								 G, P, M, G, G, M, P, G, G, G, G, G, G, G, G,
								 G, P, M, G, G, G, P, G, G, G, M, G, G, M, G,
								 G, U, P, L, G, G, P, G, G, G, R, P, P, P, F,
								 G, G, M, P, G, M, P, M, G, M, P, M, G, G, G,
								 S, P, P, U, G, G, R, P, P, P, U, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;
				
				case 2:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, R, P, P, D, G, G, G, G, G, G, G,
								 G, G, G, G, P, G, M, P, G, G, G, G, G, G, G,
								 G, G, G, M, P, M, G, P, G, G, G, M, G, G, M,
								 S, P, P, P, U, G, G, P, G, G, G, R, P, P, F,
								 G, G, M, G, G, G, M, P, M, G, M, P, M, G, G,
								 G, G, G, G, G, G, G, R, P, P, P, U, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;
				
				case 3:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, R, P, P, D, G, G, G, G, G, G, G,
								 G, G, G, G, P, G, M, P, G, G, G, G, G, G, G,
								 G, G, G, M, P, M, G, P, G, G, G, M, G, G, M,
								 S, P, P, P, U, G, G, P, G, G, G, R, P, P, F,
								 G, G, M, G, G, G, M, P, M, G, M, P, M, G, G,
								 G, G, G, G, G, G, G, R, P, P, P, U, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;		
				
				default:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, R, P, P, D, G, G, G, G, G, G, G,
								 G, G, G, G, P, G, M, P, G, G, G, G, G, G, G,
								 G, G, G, M, P, M, G, P, G, G, G, M, G, G, M,
								 S, P, P, P, U, G, G, P, G, G, G, R, P, P, F,
								 G, G, M, G, G, G, M, P, M, G, M, P, M, G, G,
								 G, G, G, G, G, G, G, R, P, P, P, U, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;
			}
			return levelMapArray;
		}
		
		public static function makeEnemies(level:int):Array
		{
			// 1 - Speeder
			// 2 - Worm
			// 3 - Recoder
			// 4 - Protector
			// 5 - Neirobot
			// 6 - Runner
			// 7 - Cycler
			// 8 - Emmiter (Emmiter creates Bugs enemies, so here no number for Bug)
			
			var levelEnemyWaves:Array;
			switch(level)
			{
				case 1:
				levelEnemyWaves = [
									[6, 4, 2, 3, 8, 6, 4],
								   	[1, 2],
								   	[1, 2, 1, 2, 1, 1], 
								   	[1, 1, 1, 2, 1, 1, 2, 1],
								   	[1, 1, 1, 1, 1, 1, 1, 1]
								  	];
				break;
				
				case 2:
				levelEnemyWaves = [
								   	[1, 1, 1, 1], 
								   	[1, 1, 1, 1, 1, 1],
								   	[1, 1, 1, 1, 1, 1, 1, 1]
								   	];
				break;
				
				case 3:
				levelEnemyWaves = [
								   	[1, 1, 1, 1], 
								   	[1, 1, 1, 1, 1, 1],
								   	[1, 1, 1, 1, 1, 1, 1, 1]
								   	];
				break;
				
				default:
				levelEnemyWaves = [
								   	[1, 1, 1, 1], 
								   	[1, 1, 1, 1, 1, 1],
								   	[1, 1, 1, 1, 1, 1, 1, 1]
								   	];
				break;
			}
			
			return levelEnemyWaves;
		}
		
		public static function levelChars(level:int):Array
		{
			var openChars:Array;
			switch(level)
			{
				case 1:
				openChars = [Turret.TURRET_GUN, Turret.TURRET_LAUNCHER, Turret.TURRET_SWARM, Turret.TURRET_FREEZE];
				break;
				
				case 2:
				openChars = [Turret.TURRET_GUN, Turret.TURRET_LAUNCHER, Turret.TURRET_SWARM, Turret.TURRET_FREEZE];
				break;
				
				case 3:
				openChars = [Turret.TURRET_GUN, Turret.TURRET_LAUNCHER, Turret.TURRET_SWARM, Turret.TURRET_FREEZE];
				break;
				
				default:
				openChars = [Turret.TURRET_GUN, Turret.TURRET_LAUNCHER, Turret.TURRET_SWARM, Turret.TURRET_FREEZE];
				break;
			}
			return openChars;
		}
		
		public static function levelTools(level:int):Array
		{
			var openTools:Array;
			switch(level)
			{
				case 1:
					openTools = [SpecialTools.SYS_DAMAGE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER, SpecialTools.FALSE_TARGET, SpecialTools.MINES];
				break;
				
				case 2:
					openTools = [SpecialTools.SYS_DAMAGE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER, SpecialTools.FALSE_TARGET, SpecialTools.MINES];
				break;
				
				case 3:
					openTools = [SpecialTools.SYS_DAMAGE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER, SpecialTools.FALSE_TARGET, SpecialTools.MINES];
				break;
				
				default:
					openTools = [SpecialTools.SYS_DAMAGE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER, SpecialTools.FALSE_TARGET, SpecialTools.MINES];
				break;
			}
			return openTools;
		}
		
		public static function levelMemory(level:int):int
		{
			var memory:int;
			switch(level)
			{
				case 1:
					memory = 800;
				break;
				
				case 2:
					memory = 400;
				break;
				
				case 3:
					memory = 500;
				break;
				
				default:
					memory = 300;
				break;
			}
			return memory;
		}
		
		public static function levelColors(level:int):uint
		{
			var color:uint;
			switch(level)
			{
				case 1:
					color = 0x0066FF;
				break;
				
				case 2:
					color = 0x0000FF;
				break;
				
				case 3:
					color = 0x000066;
				break;
				
				case 4:
					color = 0x00FF66;
				break;
				
				case 5:
					color = 0x00FF00;
				break;
				
				case 6:
					color = 0xFFFF00;
				break;
				
				case 7:
					color = 0xFF00FF;
				break;
				
				case 8:
					color = 0x00FFFF;
				break;
				
				case 9:
					color = 0xFF9900;
				break;
				
				case 10:
					color = 0xFF0000;
				break;
			}
			return color;
		}
	}
}