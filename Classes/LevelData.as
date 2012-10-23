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
								 G, G, G, G, G, G, G, S, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, P, G, G, G, G, G, G, G,
								 G, G, D, P, P, P, P, L, G, R, P, P, D, G, G,
								 G, G, P, M, G, G, G, M, G, P, M, G, P, G, G,
								 G, G, P, M, G, G, G, G, M, P, G, G, P, G, G,
								 G, G, R, P, P, P, P, P, P, U, G, M, P, G, G,
								 G, G, G, M, G, M, G, M, G, G, G, G, P, G, G,
								 F, P, P, P, P, P, P, P, P, P, P, P, L, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;
				
				case 2:
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
				
				case 3:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, D, P, P, P, L, G, G,
								 G, G, G, G, G, G, G, M, P, M, G, M, P, G, G,
								 G, G, G, D, P, P, P, P, L, G, G, G, P, G, G,
								 G, G, G, P, M, G, G, G, G, G, G, G, P, M, G,
								 G, G, G, R, P, P, P, P, D, G, G, G, U, P, S,
								 G, G, G, M, G, G, G, M, P, G, G, G, G, G, G,
								 F, P, P, P, P, P, P, P, L, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;		
				
				case 4:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, R, P, P, D, G, G, R, P, P, D, G, G, G,
								 G, G, P, M, M, P, G, G, P, M, G, P, G, G, G,
								 G, G, P, G, G, P, G, G, P, G, G, P, G, G, G,
								 S, P, U, M, M, P, G, G, P, G, M, P, G, G, G,
								 G, G, G, D, P, L, G, G, P, G, G, P, M, G, G,
								 G, G, G, P, M, G, G, M, P, M, G, R, P, P, F,
								 G, G, G, R, P, P, P, P, U, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;
				
				case 5:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, R, P, P, P, P, P, P, P, D, G, G, G, G,
								 G, G, P, M, G, G, G, G, G, M, P, G, G, G, G,
								 G, G, P, G, G, G, G, G, G, M, P, G, G, G, G,
								 G, G, P, G, G, D, P, P, P, P, L, G, G, G, G,
								 G, G, P, G, G, P, M, G, G, G, G, G, G, G, G,
								 G, G, P, G, G, P, M, G, G, M, G, G, M, G, G,
								 S, P, U, M, G, R, P, P, P, P, P, P, P, P, F,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;
				
				case 6:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, R, P, P, D, G, R, P, P, P, D, G, G,
								 G, G, G, P, M, M, P, M, P, M, G, M, P, G, G,
								 G, G, G, P, G, G, P, G, P, G, G, G, P, G, G,
								 G, G, G, P, G, G, P, M, P, G, G, G, P, G, G,
								 G, G, M, P, G, G, P, G, P, G, G, M, P, M, G,
								 S, P, P, U, G, G, P, M, P, G, G, G, R, P, F,
								 G, G, G, G, G, G, R, P, U, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;		
				
				case 7:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, S, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, M, P, G, G, G, G,
								 G, G, D, P, P, P, P, P, P, P, L, G, G, G, G,
								 G, M, P, G, G, M, G, M, G, G, G, G, G, G, G,
								 G, G, P, G, G, R, P, P, D, G, G, G, G, G, G,
								 G, G, P, G, G, P, M, G, P, M, G, G, G, G, G,
								 G, M, P, M, G, P, G, G, R, P, P, P, P, P, F,
								 G, G, R, P, P, U, G, G, G, G, G, M, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;		
				
				case 8:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, D, P, P, P, P, L, G, G, G, G, G,
								 F, L, G, G, P, M, G, G, M, P, G, G, G, G, G,
								 G, P, M, G, P, G, G, G, G, P, M, D, P, P, S,
								 G, P, G, G, P, G, G, G, M, P, G, P, G, G, G,
								 G, P, G, M, P, G, R, P, P, U, G, P, G, G, G,
								 G, U, P, P, L, G, P, M, G, M, G, P, M, G, G,
								 G, G, G, M, G, G, U, P, P, P, P, L, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;		
				
				case 9:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 S, P, P, P, P, P, P, P, P, P, P, P, D, G, G,
								 G, G, G, M, G, G, M, G, G, M, G, M, P, G, G,
								 G, G, D, P, P, P, P, P, P, P, P, P, L, G, G,
								 G, G, P, M, G, G, M, G, G, G, G, G, G, G, G,
								 G, G, R, P, P, P, P, D, G, G, M, G, M, G, G,
								 G, G, G, G, M, G, M, R, P, P, P, P, P, P, F,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;		
				
				case 10:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, R, P, P, P, P, P, D, G, G,
								 G, R, P, P, D, G, P, M, G, G, G, M, P, G, G,
								 G, P, M, M, P, M, P, G, G, G, G, G, P, G, G,
								 G, P, G, G, P, G, P, G, G, G, G, M, P, G, G,
								 G, P, G, G, P, M, P, G, D, P, P, P, L, G, G,
								 G, P, M, M, R, P, U, G, P, M, G, G, M, G, G,
								 S, U, G, G, G, M, G, G, R, P, P, P, P, P, F,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 ];
				break;
				
				default:
					trace("wrong level in LevelData, map" + level);
				break;
			}
			return levelMapArray;
		}
		
		public static function makeEnemies(level:int):Array
		{
			// 1 - Speeder
			// 2 - Worm
			// 3 - Recoder
			// 4 - Neirobot
			// 5 - Runner
			// 6 - Protector
			// 7 - Cycler
			// 8 - Emmiter (Emmiter creates Bugs enemies, so here no number for Bug)
			
			var levelEnemyWaves:Array;
			switch(level)
			{
				case 1:
				levelEnemyWaves = [
									[1, 1, 1, 1, 1, 1, 1, 1],
								   	[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
								   	[1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1], 
								   	[1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1],
								   	[1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2]
								  	];
				break;
				
				case 2:
				levelEnemyWaves = [
								   	[1, 3, 1, 1, 1, 3, 1, 1], 
								   	[1, 1, 2, 1, 1, 3, 2, 1, 1, 1, 1, 3, 2, 1, 1, 2, 1, 1, 1],
								   	[1, 3, 1, 1, 2, 1, 2, 3, 1, 2, 1, 3, 1, 2, 1, 2, 1, 1, 3, 1, 1, 1],
									[1, 1, 1, 3, 2, 2, 3, 1, 1, 1, 1, 1, 1, 3, 2, 3, 3, 2, 1, 1, 1, 1, 1, 2, 3, 2],
									[2, 1, 1, 1, 3, 2, 3, 1, 1, 1, 1, 2, 2, 3, 3, 1, 1, 1, 2, 1, 3, 2, 1, 1, 2, 3]
								   	];
				break;
				
				case 3:
				levelEnemyWaves = [
								   	[1, 3, 2, 1, 1, 4, 2, 1, 4, 3, 1, 1, 1], 
								   	[1, 2, 2, 3, 4, 4, 4, 2, 1, 1, 3, 2, 1, 1, 1, 1, 2, 3, 1, 1],
								   	[1, 3, 3, 2, 1, 3, 4, 3, 2, 4, 4, 2, 3, 4, 2, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 1, 1, 1],
									[2, 3, 2, 2, 1, 1, 1, 1, 4, 4, 2, 3, 2, 2, 3, 1, 1, 1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 1, 1, 1, 1, 2, 2, 3],
									[1, 1, 1, 4, 4, 4, 4, 4, 2, 2, 2, 3, 3, 3, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 2, 2, 4, 4, 4, 4, 3, 3]
								   	];
				break;
				
				case 4:
				levelEnemyWaves = [
								   [1, 1, 1, 3, 3, 2, 1, 1, 1, 1, 5, 5, 5, 5, 2, 3],
								   [1, 1, 5, 5, 5, 1, 1, 3, 3, 3, 2, 2, 5, 5, 1, 1, 1, 1, 1, 3, 3, 2, 2, 3, 4, 4, 4, 4],
								   [1, 1, 1, 2, 2, 2, 5, 5, 5, 5, 5, 2, 3, 3, 4, 4, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 5, 5, 5, 5],
								   [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 2, 1, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 1, 5, 1, 5, 1, 5],
								   [2, 2, 3, 3, 4, 4, 4, 4, 1, 1, 1, 5, 5, 5, 1, 1, 1, 1, 4, 4, 4, 4, 5, 5, 5, 5, 5, 3, 3, 5, 5, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1]
								   ];
				break;
				
				case 5:
				levelEnemyWaves = [
								   [1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 3, 3, 2, 2, 2, 2],
								   [1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 4, 4, 4, 4, 1, 1, 1, 1, 3, 3, 3, 2, 2, 2, 2],
								   [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 2, 2, 2, 2],
								   [1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 4, 4, 4],
								   [5, 5, 5, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 2, 2, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4]
								   ];
				break;
				
				case 6:
				levelEnemyWaves = [
								   [5, 5, 5, 5, 5, 5, 5, 6, 6, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5],
								   [1, 1, 1, 1, 6, 6, 1, 1, 1, 1, 6, 6, 5, 5, 5, 5, 5, 6, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 6, 6, 6, 1, 1, 1, 1, 1, 1, 1],
								   [2, 2, 2, 3, 3, 6, 6, 6, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 4, 4, 4, 4, 4, 4, 5, 5, 2, 2, 2, 2, 5, 5, 5, 6, 6, 6],
								   [1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, 3, 5, 5, 5, 5, 5, 6, 6, 6, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 2, 6, 6],
								   [5, 5, 5, 6, 6, 6, 6, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1, 1, 4, 4, 4, 1, 1, 1, 1, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 5, 4, 4, 4, 4, 6, 6, 6, 6, 6]
								   ];
				break;
				
				case 7:
				levelEnemyWaves = [
								   [5, 5, 5, 5, 5, 2, 2, 2, 3, 3, 3, 3, 6, 6, 6, 7, 7, 7, 7, 1, 1, 1, 1, 1, 1],
								   [1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 6, 6, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 7, 3, 3, 3, 2, 2, 2, 2, 3, 3, 2],
								   [5, 5, 5, 5, 5, 3, 3, 5, 5, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 6, 6, 6, 3, 3, 3],
								   [2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 7, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 2, 7, 7, 7, 7, 7, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1],
								   [7, 7, 7, 7, 6, 6, 6, 6, 3, 3, 3, 3, 2, 2, 2, 2, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 6, 6, 6, 6, 6]
								   ];
				break;
				
				case 8:
				levelEnemyWaves = [
								   [1, 1, 1, 1, 1, ,1 ,1, 1, 3, 3, 3, 3, 2, 2, 2, 2, 8, 7, 7, 7, 7, 5, 5, 5, 5],
								   [5, 5, 5, 5, 5, 6, 6, 6, 8, 7, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 8, 5, 5, 5, 5, 5, 1, 6, 6, 6, 1, 1, 1, 1, 1, 1],
								   [1, 1, 1, 1, 1, 1, 1, 8, 7, 7, 7, 6, 6, 6, 3, 3, 3, 8, 3, 3, 7, 7, 6, 6, 6, 6, 2, 2, 2, 2, 2, 2, 3, 3, 3, 1, 1, 1, 5, 5, 5, 5, 5],
								   [5, 5, 5, 5, 7, 7, 7, 7,  8, 6, 6, 6, 5, 5, 5, 5, 5, 3, 3, 3, 8, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3],
								   [7, 7, 7, 6, 6, 6, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 1, 8, 7, 7, 7, 7, 7, 8, 5, 5, 5, 5, 5, 5, 8, 6, 6, 6, 3, 3, 3, 7, 7, 7, 7, 7],
								   ];
				break;
				
				case 9:
				levelEnemyWaves = [
								   [5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 7, 4, 4, 4, 4, 4, 8, 3, 3, 3, 5, 5, 5, 5],
								   [2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 8, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5],
								   [6, 6, 6, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 8, 7, 7, 7, 7, 8,  3, 3, 3, 3, 5, 5, 5, 5, 5, 3, 3, 3, 3],
								   [5, 5, 5, 5, 5, 5, 8, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 6, 6, 6, 6, 6, 6, 6, 8, 5, 5, 5, 5, 5, 3, 3, 3, 6, 6, 6, 6, 6],
								   [7, 7, 7, 7, 7, 5, 5, 5, 5, 8, 4, 4, 4, 4, 3, 3, 3, 8, 7, 7, 7, 7, 7, 4, 4, 4, 4 ,4, 4, 8, 5, 5, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 8],
								   ];
				break;
				
				case 10:
				levelEnemyWaves = [
								   [5, 5, 5, 5, 5, 6, 6, 6, 7, 7, 7, 7, 7, 8, 3, 3, 3, 8, 1, 1, 1, 1, 1, 4, 4, 4, 4, 4],
								   [6, 6, 6, 8, 7, 7 ,7, 7, 8, 6, 6, 6, 3, 3, 3, 3, 8, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 8, 5, 5, 5, 5, 5],
								   [7, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 8, 5, 5, 8, 3, 3, 3, 8, 6, 6, 6, 3, 3, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 5, 5, 5, 8, 6, 6, 6],
								   [5, 5, 5, 5, 5, 5, 5, 5, 8, 6, 6, 6, 4, 4, 4, 4, 4, 4, 4, 8, 4, 4, 4, 4, 7, 7, 7, 7, 7, 6, 6, 6, 6, 6, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 8, 7, 8],
								   [8, 7, 7, 7, 5, 5, 8, 6, 6, 6, 3, 3, 8, 3, 3, 3, 8, 6, 6, 6, 6, 5, 5, 5, 5, 5, 8, 6, 6, 6, 3, 3, 3, 8, 3, 3, 6, 6, 8, 4, 4, 4, 8, 6, 8, 6, 6]
								   ];
				break;
				
				default:
					trace("wrong level in LevelData, enemy" + level);
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
					openChars = [Turret.TURRET_GUN];
				break;
				
				case 2:
					openChars = [Turret.TURRET_GUN, Turret.TURRET_LAUNCHER];
				break;
				
				case 3:
					openChars = [Turret.TURRET_GUN, Turret.TURRET_LAUNCHER, Turret.TURRET_SWARM];
				break;
				
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
				case 10:
					openChars = [Turret.TURRET_GUN, Turret.TURRET_LAUNCHER, Turret.TURRET_SWARM, Turret.TURRET_FREEZE];
				break;
				
				default:
					trace("wrong level in LevelData, chars" + level);
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
					openTools = [SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD];
				break;
				
				case 2:
					openTools = [SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.SYS_DAMAGE_REDUCE];
				break;
				
				case 3:
					openTools = [SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.SYS_DAMAGE_REDUCE];
				break;
				
				case 4:
					openTools = [SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.SYS_DAMAGE_REDUCE,  
								 SpecialTools.MINES];
				break;
				
				case 5:
					openTools = [SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.SYS_DAMAGE_REDUCE, 
								 SpecialTools.MINES, SpecialTools.ADDITIONAL_MARKER];
				break;
				
				case 6:
					openTools = [SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.SYS_DAMAGE_REDUCE, 
								 SpecialTools.MINES, SpecialTools.ADDITIONAL_MARKER, SpecialTools.RELOCATE_TURRET];
				break;
				
				case 7:
				case 8:
				case 9:
				case 10:
					openTools = [SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.SYS_DAMAGE_REDUCE, 
								 SpecialTools.MINES, SpecialTools.ADDITIONAL_MARKER, SpecialTools.RELOCATE_TURRET, SpecialTools.FALSE_TARGET];
				break;
				
				default:
					trace("wrong level in LevelData, tools" + level);
				break;
			}
			return openTools;
		}
		
		public static function levelMemory(level:int):int
		{
			var memory:int = 200 + level * 50;
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