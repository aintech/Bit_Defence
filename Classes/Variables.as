package 
{
	public class Variables
	{
		public static var SYMBOLS:int;
		public static var SYMBOLS_DROP_CHANCE:int;
		public static var MEMORY_DROP_CHANCE:int;
		public static var SYMBOLS_DROP_MULTIPLE:Number;
		
		public static var HACK_PROTECT_LEVEL:int;//процент вычитается из возможности врага взломать систему 
		
		public static var GUN_START_LEVEL:int;
		public static var SWARM_START_LEVEL:int;
		public static var FREEZE_START_LEVEL:int;
		public static var LAUNCHER_START_LEVEL:int;
		
		public static var GUN_MAX_LEVEL:int;
		public static var SWARM_MAX_LEVEL:int;
		public static var FREEZE_MAX_LEVEL:int;
		public static var LAUNCHER_MAX_LEVEL:int;
		
		//public static var DAMAGE_MULTIPLY:Number 			= 1;
		//public static var RANGE_MULTIPLY:Number 			= 1;
		//public static var RELOAD_TIME_REDUCE:Number 		= 1;
		//public static var UPGRADE_COST_REDUCE:Number 		= 1;
		//public static var MEMORY_USE_REDUCE:Number 		= 1;
		//public static var SYMBOLS_DROP_MULTIPLE:Number 	= 1;
		//public static var TOTAL_MEMORY_INCREASE:int 		= 0;
		
		public static var GUN_TURRET_COST:int;
		public static var LAUNCHER_TURRET_COST:int;
		public static var FREEZE_TURRET_COST:int;
		public static var SWARM_TURRET_COST:int;
		
		public static var GUN_CRIT_CHANCE:int;//шанс gunTurret на критический выстрел
		public static var GUN_CRIT_DAMAGE_MULTIPLY:int	;//увеличивает критический повреждения
		public static var GUN_ACC_DAMAGE:int;
		
		public static var FREEZE_STUN_CHANCE:int;
		public static var FREEZE_STUN_DURATION:int;
		public static var FREEZE_MULTY_STUN_DISTANCE:int;
		public static var FREEZE_SPEED_REDUCE_DURATION:int;
		public static var FREEZE_SPEED_REDUCE_MULTIPLY:Number;
		
		public static var LAUNCHER_POISON_CHANCE:int;
		public static var LAUNCHER_POISON_DURATION:int;
		public static var LAUNCHER_POISON_DAMAGE:int;
		public static var LAUNCHER_POISON_CLOUD_DAMAGE:int;
		public static var LAUNCHER_POISON_CLOUD_LIFETIME:int;
		
		public static var SWARM_SPLASH_CHANCE:int;
		public static var SWARM_SPLASH_DAMAGE:int;
		
		public static var SPECIAL_TOOL_GAUGE:int;
		
		public static var SPECIAL_ADDITIONAL_MARKER_COOLTIME:int;
		public static var SPECIAL_FLOW_OVERLOAD_COOLTIME:int;
		public static var SPECIAL_FLOW_STOP_COOLTIME:int;
		public static var SPECIAL_HACK_REDUCE_COOLTIME:int;
		public static var SPECIAL_RELOCATE_TURRET_COOLTIME:int;
		
		public static var SPECIAL_FLOW_OVERLOAD_DAMAGE:int;
		public static var SPECIAL_HACK_REDUCE_MULTIPLY:Number;
		public static var SPECIAL_FLOW_STOP_DURATION:int;
		public static var SPECIAL_ADDITIONAL_MARKER_INSTALL_TIME:int;
		
		public static var WAVE_DELAY:int;//Wave delay in sec
		public static var ENEMY_DELAY:int;//enemy appear delay
		
		public static var UPGRADE_COST_GUN_III:int;
		public static var UPGRADE_COST_CRIT_X4:int;
		public static var UPGRADE_COST_GUN_V:int;
		public static var UPGRADE_COST_CRIT_CHANCE:int;
		public static var UPGRADE_COST_ADD_TOOLS:int;
		public static var UPGRADE_COST_ACC_DAM:int;
		public static var UPGRADE_COST_GUN_MASTER:int;
		
		public static var UPGRADE_COST_SWARM_III:int;
		public static var UPGRADE_COST_WIDE_SPLASH:int;
		public static var UPGRADE_COST_SWARM_V:int;
		public static var UPGRADE_COST_SPLASH_CHANCE:int;
		public static var UPGRADE_COST_MORE_SYMBOLS:int;
		public static var UPGRADE_COST_BOMB_CASCADE:int;
		public static var UPGRADE_COST_SWARM_MASTER:int;
		
		public static var UPGRADE_COST_LAUNCHER_III:int;
		public static var UPGRADE_COST_POISON_DAMAGE:int;
		public static var UPGRADE_COST_LAUNCHER_V:int;
		public static var UPGRADE_COST_POISON_CHANCE:int;
		public static var UPGRADE_COST_MEMORY_CHANCE:int;
		public static var UPGRADE_COST_POISON_CLOUD:int;
		public static var UPGRADE_COST_LAUNCHER_MASTER:int;
		
		public static var UPGRADE_COST_FREEZE_III:int;
		public static var UPGRADE_COST_LONGER_STUN:int;
		public static var UPGRADE_COST_FREEZE_V:int;
		public static var UPGRADE_COST_STUN_CHANCE:int;
		public static var UPGRADE_COST_HACK_PROTECT:int;
		public static var UPGRADE_COST_MULTY_STUN:int;
		public static var UPGRADE_COST_FREEZE_MASTER:int;
		
		public static var UPGRADE_GUN_III:Boolean;
		public static var UPGRADE_CRITICAL_X4:Boolean;
		public static var UPGRADE_GUN_V:Boolean;
		public static var UPGRADE_CRIT_CHANCE:Boolean;
		public static var UPGRADE_ADDITIONAL_TOOLS:Boolean;
		public static var UPGRADE_ACC_DAMAGE:Boolean;
		public static var UPGRADE_GUN_MASTERED:Boolean;
		
		public static var UPGRADE_SWARM_III:Boolean;
		public static var UPGRADE_WIDE_SPLASH:Boolean;
		public static var UPGRADE_SWARM_V:Boolean;
		public static var UPGRADE_SPLASH_CHANCE:Boolean;
		public static var UPGRADE_MORE_SYMBOLS:Boolean;
		public static var UPGRADE_BOMB_CASCADE:Boolean;
		public static var UPGRADE_SWARM_MASTERED:Boolean;
		
		public static var UPGRADE_LAUNCHER_III:Boolean;
		public static var UPGRADE_POISON_DAMAGE:Boolean;
		public static var UPGRADE_LAUNCHER_V:Boolean;
		public static var UPGRADE_POISON_CHANCE:Boolean;
		public static var UPGRADE_MEMORY_CHANCE:Boolean;
		public static var UPGRADE_POISON_CLOUD:Boolean;
		public static var UPGRADE_LAUNCHER_MASTERED:Boolean;
		
		public static var UPGRADE_FREEZE_III:Boolean;
		public static var UPGRADE_LONGER_STUN:Boolean;
		public static var UPGRADE_FREEZE_V:Boolean;
		public static var UPGRADE_STUN_CHANCE:Boolean;
		public static var UPGRADE_HACK_PROTECT:Boolean;
		public static var UPGRADE_MULTY_STUN:Boolean;
		public static var UPGRADE_FREEZE_MASTERED:Boolean;
		
		public static var GRAY_MATRIX:Array;
		
		public static var INTRODUCE_SPEEDER:Boolean;
		public static var INTRODUCE_WORM:Boolean;
		
		public static var INTRODUCE_GUN:Boolean;
		public static var INTRODUCE_SWARM:Boolean;
		public static var INTRODUCE_LAUNCHER:Boolean;
		public static var INTRODUCE_FREEZE:Boolean;
		
		public static var INTRODUCE_ADDITIONAL_MARKER:Boolean;
		public static var INTRODUCE_FLOW_OVERLOAD:Boolean;
		public static var INTRODUCE_FLOW_STOP:Boolean;
		public static var INTRODUCE_HACK_REDUCE:Boolean;
		public static var INTRODUCE_RELOCATE_TURRET:Boolean;
		
		public static function setToDefault():void
		{
			SYMBOLS						= 5000;
			SYMBOLS_DROP_CHANCE		= 15;
			MEMORY_DROP_CHANCE		= 10;
			SYMBOLS_DROP_MULTIPLE	= 1;
		
			HACK_PROTECT_LEVEL		= 0;
		
			GUN_START_LEVEL			= 1;
			SWARM_START_LEVEL			= 1;
			FREEZE_START_LEVEL		= 1;
			LAUNCHER_START_LEVEL		= 1;
		
			GUN_MAX_LEVEL 				= 1;
			SWARM_MAX_LEVEL 			= 1;
			FREEZE_MAX_LEVEL 			= 1;
			LAUNCHER_MAX_LEVEL 		= 1;
			
			GUN_TURRET_COST			= 50;
			LAUNCHER_TURRET_COST		= 100;
			FREEZE_TURRET_COST		= 50;
			SWARM_TURRET_COST			= 150;
		
			GUN_CRIT_CHANCE 						= 10;
			GUN_CRIT_DAMAGE_MULTIPLY			= 2;
			GUN_ACC_DAMAGE							= 4;
		
			FREEZE_STUN_CHANCE					= 10;
			FREEZE_STUN_DURATION					= 30;
			FREEZE_MULTY_STUN_DISTANCE			= 100;
			FREEZE_SPEED_REDUCE_DURATION		= 30;
			FREEZE_SPEED_REDUCE_MULTIPLY		= .5;
		
			LAUNCHER_POISON_CHANCE				= 10;
			LAUNCHER_POISON_DURATION 			= 30;
		 	LAUNCHER_POISON_DAMAGE				= 2;
		 	LAUNCHER_POISON_CLOUD_DAMAGE		= 2;
		 	LAUNCHER_POISON_CLOUD_LIFETIME	= 60;
		
		 	SWARM_SPLASH_CHANCE					= 10;
		 	SWARM_SPLASH_DAMAGE					= 10;
		
		 	SPECIAL_TOOL_GAUGE							= 4;
		
		 	SPECIAL_ADDITIONAL_MARKER_COOLTIME		= 100;// = 5000 ms / gameTimer(50)
		 	SPECIAL_FLOW_OVERLOAD_COOLTIME			= 100;
		 	SPECIAL_FLOW_STOP_COOLTIME					= 100;
		 	SPECIAL_HACK_REDUCE_COOLTIME 				= 100;
		 	SPECIAL_RELOCATE_TURRET_COOLTIME			= 100;
		
		 	SPECIAL_FLOW_OVERLOAD_DAMAGE				= 100;
		 	SPECIAL_HACK_REDUCE_MULTIPLY				= .5;
		 	SPECIAL_FLOW_STOP_DURATION					= 50;
		 	SPECIAL_ADDITIONAL_MARKER_INSTALL_TIME = 50;
		
			WAVE_DELAY	= 20;
			ENEMY_DELAY	= 12;
		
		 	UPGRADE_COST_GUN_III				= 50;
		 	UPGRADE_COST_CRIT_X4				= 100;
		 	UPGRADE_COST_GUN_V				= 150;
		 	UPGRADE_COST_CRIT_CHANCE		= 200;
		 	UPGRADE_COST_ADD_TOOLS			= 300;
		 	UPGRADE_COST_ACC_DAM				= 400;
		 	UPGRADE_COST_GUN_MASTER			= 500;
		
		 	UPGRADE_COST_SWARM_III			= 50;
		 	UPGRADE_COST_WIDE_SPLASH		= 100;
		 	UPGRADE_COST_SWARM_V				= 150;
		 	UPGRADE_COST_SPLASH_CHANCE		= 200;
		 	UPGRADE_COST_MORE_SYMBOLS		= 300;
		 	UPGRADE_COST_BOMB_CASCADE		= 400;
		 	UPGRADE_COST_SWARM_MASTER		= 500;
		
			UPGRADE_COST_LAUNCHER_III		= 50;
			UPGRADE_COST_POISON_DAMAGE		= 100;
		 	UPGRADE_COST_LAUNCHER_V			= 150;
		 	UPGRADE_COST_POISON_CHANCE		= 200;
		 	UPGRADE_COST_MEMORY_CHANCE		= 300;
		 	UPGRADE_COST_POISON_CLOUD		= 400;
		 	UPGRADE_COST_LAUNCHER_MASTER	= 500;
		
		 	UPGRADE_COST_FREEZE_III			= 50;
		 	UPGRADE_COST_LONGER_STUN		= 100;
		 	UPGRADE_COST_FREEZE_V			= 150;
		 	UPGRADE_COST_STUN_CHANCE		= 200;
		 	UPGRADE_COST_HACK_PROTECT		= 300;
		 	UPGRADE_COST_MULTY_STUN			= 400;
		 	UPGRADE_COST_FREEZE_MASTER		= 500;
		
		 	UPGRADE_GUN_III				= false;
		 	UPGRADE_CRITICAL_X4			= false;
		 	UPGRADE_GUN_V					= false;
		 	UPGRADE_CRIT_CHANCE			= false;
		 	UPGRADE_ADDITIONAL_TOOLS	= false;
		 	UPGRADE_ACC_DAMAGE			= false;
		 	UPGRADE_GUN_MASTERED			= false;
			
		 	UPGRADE_SWARM_III				= false;
			UPGRADE_WIDE_SPLASH			= false;
		 	UPGRADE_SWARM_V				= false;
		 	UPGRADE_SPLASH_CHANCE		= false;
		 	UPGRADE_MORE_SYMBOLS			= false;
		 	UPGRADE_BOMB_CASCADE			= false;
		 	UPGRADE_SWARM_MASTERED		= false;
		
		 	UPGRADE_LAUNCHER_III			= false;
		 	UPGRADE_POISON_DAMAGE		= false;
		 	UPGRADE_LAUNCHER_V			= false;
		 	UPGRADE_POISON_CHANCE		= false;
		 	UPGRADE_MEMORY_CHANCE		= false;
		 	UPGRADE_POISON_CLOUD			= false;
		 	UPGRADE_LAUNCHER_MASTERED	= false;
		
		 	UPGRADE_FREEZE_III			= false;
		 	UPGRADE_LONGER_STUN			= false;
		 	UPGRADE_FREEZE_V				= false;
		 	UPGRADE_STUN_CHANCE			= false;
		 	UPGRADE_HACK_PROTECT			= false;
		 	UPGRADE_MULTY_STUN			= false;
		 	UPGRADE_FREEZE_MASTERED		= false;
			
			GRAY_MATRIX = [
							0.3086, 0.6094, 0.082, 0, 0,
					  		0.3086, 0.6094, 0.082, 0, 0,
					  		0.3086, 0.6094, 0.082, 0, 0,
								  0,		 0,	  0, 1, 0
						];
		
			INTRODUCE_SPEEDER					= false;
			INTRODUCE_WORM						= false;
		
			INTRODUCE_GUN						= false;
			INTRODUCE_SWARM					= false;
			INTRODUCE_LAUNCHER				= false;
			INTRODUCE_FREEZE					= false;
		
			INTRODUCE_ADDITIONAL_MARKER	= false;
			INTRODUCE_FLOW_OVERLOAD			= false;
			INTRODUCE_FLOW_STOP				= false;
			INTRODUCE_HACK_REDUCE			= false;
			INTRODUCE_RELOCATE_TURRET		= false;
		}
	}
}