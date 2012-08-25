package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.display.Sprite;

	public class Turret extends MovieClip
	{
		public static const TURRET_GUN:String 			= "turret_gun";
		public static const TURRET_LAUNCHER:String 		= "turret_launcher";
		public static const TURRET_SWARM:String 		= "turret_swarm";
		public static const TURRET_FREEZE:String 		= "turret_freeze";
		public static const TURRET_MAX_LEVEL:int		= 5;
		
		public var type:String;
		
		public var base:Sprite;
		public var gun:MovieClip;
		
		public var glowFilter:GlowFilter;
		
		public var level:int = 1;
		public var maxLevel:int;
		public var abilityDescription:String;
				
		public var range:int;
		public var reloadTime:int;
		public var damage:int;
		public var memoryUse:int;
		public var upgradeCost:int;
		public var numMissiles:int;
		public var numSwarmBombs:int;
		
		public var additionalDamage:int = 0;
		public var additionalRange:int = 0;
		public var additionalReloadTime:int = 0;
		
		public var installingTime:int = 0;
		public var upgradingTime:int = 0;
		public var uninstallingTime:int = 0;
		
		public var cTime:int = 0;
		public var loaded:Boolean = true;
		
		public var gunAccDamage:int;
		public var gunEnemyID:int;
		public var gunEnemyPrevID:int;
		
		public function Turret()
		{
			glowFilter = new GlowFilter(0xFFFFFF, 1, 3, 3, 1);
			this.filters = [glowFilter];
		}
		
		public function updateLevel():void
		{
			
		}
	}
}