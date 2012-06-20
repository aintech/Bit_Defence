package 
{
	public class LevelData
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
		
		public var levelMapArray:Array 	= [];
		public var levelEnemyWaves:Array = [];
		public var openChars:Array 		= [];
		public var openTools:Array			= [];
		
		public function LevelData()
		{
			
		}
		
		public function makeLevel(level:int):Array
		{
			switch(level)
			{
				case 1:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, R, P, P, P, P, D, G, G, G, G, G, G, G, G,
								 G, P, M, G, G, M, P, G, G, G, G, G, G, G, G,
								 G, P, M, G, M, G, P, G, G, G, M, G, G, M, G,
								 G, U, P, L, G, G, P, G, G, G, R, P, P, P, F,
								 G, G, M, P, G, M, P, M, G, M, P, M, G, G, G,
								 S, P, P, U, G, G, R, P, P, P, U, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G
								 ];
				break;
				
				case 2:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, R, P, P, D, G, G, G, G, G, G, G, G,
								 G, G, G, P, G, M, P, G, G, G, G, G, G, G, G,
								 G, G, M, P, M, G, P, G, G, G, M, G, G, M, G,
								 S, P, P, U, G, G, P, G, G, G, R, P, P, P, F,
								 G, M, G, G, G, M, P, M, G, M, P, M, G, G, G,
								 G, G, G, G, G, G, R, P, P, P, U, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G
								 ];
				break;
				
				case 3:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, R, P, P, D, G, G, G, G, G, G, G, G,
								 G, G, G, P, G, M, P, G, G, G, G, G, G, G, G,
								 G, G, M, P, M, G, P, G, G, G, M, G, G, M, G,
								 S, P, P, U, G, G, P, G, G, G, R, P, P, P, F,
								 G, M, G, G, G, M, P, M, G, M, P, M, G, G, G,
								 G, G, G, G, G, G, R, P, P, P, U, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G
								 ];
				break;		
				
				default:
				levelMapArray = [
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, R, P, P, D, G, G, G, G, G, G, G, G,
								 G, G, G, P, G, M, P, G, G, G, G, G, G, G, G,
								 G, G, M, P, M, G, P, G, G, G, M, G, G, M, G,
								 S, P, P, U, G, G, P, G, G, G, R, P, P, P, F,
								 G, M, G, G, G, M, P, M, G, M, P, M, G, G, G,
								 G, G, G, G, G, G, R, P, P, P, U, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G,
								 G, G, G, G, G, G, G, G, G, G, G, G, G, G, G
								 ];
				break;
			}
			
			return levelMapArray;
		}
		
		public function makeEnemies(level:int):Array
		{
			switch(level)
			{
				case 1:
				levelEnemyWaves = [//[1],
										 [1, 1, 1, 1],
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
		
		public function levelChars(level:int):Array
		{
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
		
		public function levelTools(level:int):Array
		{
			switch(level)
			{
				case 1:
				openTools = [SpecialTools.HACK_CHANCE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER];
				break;
				
				case 2:
				openTools = [SpecialTools.HACK_CHANCE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER];
				break;
				
				case 3:
				openTools = [SpecialTools.HACK_CHANCE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER];
				break;
				
				default:
				openTools = [SpecialTools.HACK_CHANCE_REDUCE, SpecialTools.FLOW_STOP, SpecialTools.FLOW_OVERLOAD, SpecialTools.RELOCATE_TURRET, SpecialTools.ADDITIONAL_MARKER];
				break;
			}
			return openTools;
		}
	}
}