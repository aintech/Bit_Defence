package 
{
	public class Variables
	{
		public static var SYMBOLS:int;
		public static var SYMBOLS_DROP_CHANCE:int;
		public static var MEMORY_DROP_CHANCE:int;
		public static var PROTECT_DROP_CHANCE:int;
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
		
		public static const SPECIAL_ADDITIONAL_MARKER_COOLTIME:int	= 200;// = 10000 ms / gameTimer(50)
		public static const SPECIAL_FLOW_OVERLOAD_COOLTIME:int		= 200;
		public static const SPECIAL_FLOW_STOP_COOLTIME:int			= 200;
		public static const SPECIAL_SYS_DAMAGE_REDUCE_COOLTIME:int	= 200;
		public static const SPECIAL_RELOCATE_TURRET_COOLTIME:int	= 200;
		public static const SPECIAL_FALSE_TARGET_COOLTIME:int		= 200;
		public static const SPECIAL_MINES_COOLTIME:int				= 200;
		
		public static var SPECIAL_FLOW_OVERLOAD_DAMAGE:int;
		public static var SPECIAL_SYS_DAMAGE_MULTIPLY:Number;
		public static var SPECIAL_SYS_DAMAGE_REDUCE_TIME:int;
		public static var SPECIAL_FLOW_STOP_DURATION:int;
		public static var SPECIAL_ADDITIONAL_MARKER_INSTALL_TIME:int;
		public static var SPECIAL_FALSE_TARGET_PROTECTION:int;
		public static var SPECIAL_FALSE_TARGET_PROTECTION_LIFE:int;
		public static var SPECIAL_MINES_NUMBER:int;
		public static var SPECIAL_MINES_DAMAGE:int;
		public static var SPECIAL_MINES_DISTANCE:int;
		
		public static var WAVE_DELAY:int;//Wave delay in sec
		public static var ENEMY_DELAY:int;//enemy appear delay
		
		public static var UPGRADE_COST_GUN_III:int			= 50;
		public static var UPGRADE_COST_CRIT_X4:int			= 100;
		public static var UPGRADE_COST_GUN_V:int			= 150;
		public static var UPGRADE_COST_CRIT_CHANCE:int		= 200;
		public static var UPGRADE_COST_ADD_TOOLS:int		= 300;
		public static var UPGRADE_COST_ACC_DAM:int			= 400;
		public static var UPGRADE_COST_GUN_MASTER:int		= 500;
		
		public static var UPGRADE_COST_SWARM_III:int		= 50;
		public static var UPGRADE_COST_WIDE_SPLASH:int		= 100;
		public static var UPGRADE_COST_SWARM_V:int			= 150;
		public static var UPGRADE_COST_SPLASH_CHANCE:int 	= 200;
		public static var UPGRADE_COST_MORE_SYMBOLS:int		= 300;
		public static var UPGRADE_COST_BOMB_CASCADE:int		= 400;
		public static var UPGRADE_COST_SWARM_MASTER:int		= 500;
		
		public static var UPGRADE_COST_LAUNCHER_III:int		= 50;
		public static var UPGRADE_COST_POISON_DAMAGE:int	= 100;
		public static var UPGRADE_COST_LAUNCHER_V:int		= 150;
		public static var UPGRADE_COST_POISON_CHANCE:int	= 200;
		public static var UPGRADE_COST_MEMORY_CHANCE:int	= 300;
		public static var UPGRADE_COST_POISON_CLOUD:int		= 400;
		public static var UPGRADE_COST_LAUNCHER_MASTER:int	= 500;
		
		public static var UPGRADE_COST_FREEZE_III:int		= 50;
		public static var UPGRADE_COST_LONGER_STUN:int		= 100;
		public static var UPGRADE_COST_FREEZE_V:int			= 150;
		public static var UPGRADE_COST_STUN_CHANCE:int		= 200;
		public static var UPGRADE_COST_HACK_PROTECT:int		= 300;
		public static var UPGRADE_COST_MULTY_STUN:int		;
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
		public static var INTRODUCE_RECODER:Boolean;
		public static var INTRODUCE_PROTECTOR:Boolean;
		public static var INTRODUCE_NEIROBOT:Boolean;
		public static var INTRODUCE_RUNNER:Boolean;
		public static var INTRODUCE_CYCLER:Boolean;
		public static var INTRODUCE_EMMITER:Boolean;
		public static var INTRODUCE_BUG:Boolean;
		
		public static var INTRODUCE_GUN:Boolean;
		public static var INTRODUCE_SWARM:Boolean;
		public static var INTRODUCE_LAUNCHER:Boolean;
		public static var INTRODUCE_FREEZE:Boolean;
		
		public static var INTRODUCE_ADDITIONAL_MARKER:Boolean;
		public static var INTRODUCE_FLOW_OVERLOAD:Boolean;
		public static var INTRODUCE_FLOW_STOP:Boolean;
		public static var INTRODUCE_SYS_DAMAGE_REDUCE:Boolean;
		public static var INTRODUCE_RELOCATE_TURRET:Boolean;
		public static var INTRODUCE_FALSE_TARGET:Boolean;
		public static var INTRODUCE_MINES:Boolean;
		
		public static var NUM_NEIROBOTS:int;
		public static var NUM_PROTECTORS:int;
		
		public static function setToDefault():void
		{
			SYMBOLS					= 10000;
			SYMBOLS_DROP_CHANCE		= 15;
			MEMORY_DROP_CHANCE		= 10;
			PROTECT_DROP_CHANCE		= 15;
			SYMBOLS_DROP_MULTIPLE	= 1;
		
			HACK_PROTECT_LEVEL		= 0;
		
			GUN_START_LEVEL			= 1;
			SWARM_START_LEVEL		= 1;
			FREEZE_START_LEVEL		= 1;
			LAUNCHER_START_LEVEL	= 1;
		
			GUN_MAX_LEVEL 			= 1;
			SWARM_MAX_LEVEL 		= 1;
			FREEZE_MAX_LEVEL 		= 1;
			LAUNCHER_MAX_LEVEL 		= 1;
		
			GUN_CRIT_CHANCE 				= 10;
			GUN_CRIT_DAMAGE_MULTIPLY		= 2;
			GUN_ACC_DAMAGE					= 40;
		
			FREEZE_STUN_CHANCE				= 10;
			FREEZE_STUN_DURATION			= 30;
			FREEZE_MULTY_STUN_DISTANCE		= 100;
			FREEZE_SPEED_REDUCE_DURATION	= 30;
			FREEZE_SPEED_REDUCE_MULTIPLY	= .5;
		
			LAUNCHER_POISON_CHANCE			= 10;
			LAUNCHER_POISON_DURATION 		= 30;
		 	LAUNCHER_POISON_DAMAGE			= 5;
		 	LAUNCHER_POISON_CLOUD_DAMAGE	= 3;
		 	LAUNCHER_POISON_CLOUD_LIFETIME	= 60;
		
		 	SWARM_SPLASH_CHANCE				= 10;
		 	SWARM_SPLASH_DAMAGE				= 50;
		
		 	SPECIAL_TOOL_GAUGE						= 4;
		
		 	SPECIAL_FLOW_OVERLOAD_DAMAGE			= 1000;
		 	SPECIAL_SYS_DAMAGE_MULTIPLY				= 1;
			SPECIAL_SYS_DAMAGE_REDUCE_TIME			= 160;//должно быть меньше чем SPECIAL_SYS_DAMAGE_REDUCE_COOLTIME
		 	SPECIAL_FLOW_STOP_DURATION				= 100;
		 	SPECIAL_ADDITIONAL_MARKER_INSTALL_TIME 	= 50;
			SPECIAL_FALSE_TARGET_PROTECTION			= 50;
			SPECIAL_FALSE_TARGET_PROTECTION_LIFE	= 160;// 8 sec
			SPECIAL_MINES_NUMBER					= 5;
			SPECIAL_MINES_DAMAGE					= 400;
			SPECIAL_MINES_DISTANCE					= 150;
		
			WAVE_DELAY	= 20;
			ENEMY_DELAY	= 12;
		
		 	UPGRADE_COST_GUN_III			= 50;
		 	UPGRADE_COST_CRIT_X4			= 100;
		 	UPGRADE_COST_GUN_V				= 150;
		 	UPGRADE_COST_CRIT_CHANCE		= 200;
		 	UPGRADE_COST_ADD_TOOLS			= 300;
		 	UPGRADE_COST_ACC_DAM			= 400;
		 	UPGRADE_COST_GUN_MASTER			= 500;
		
		 	UPGRADE_COST_SWARM_III			= 50;
		 	UPGRADE_COST_WIDE_SPLASH		= 100;
		 	UPGRADE_COST_SWARM_V			= 150;
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
		 	UPGRADE_GUN_V				= false;
		 	UPGRADE_CRIT_CHANCE			= false;
		 	UPGRADE_ADDITIONAL_TOOLS	= false;
		 	UPGRADE_ACC_DAMAGE			= false;
		 	UPGRADE_GUN_MASTERED		= false;
			
		 	UPGRADE_SWARM_III			= false;
			UPGRADE_WIDE_SPLASH			= false;
		 	UPGRADE_SWARM_V				= false;
		 	UPGRADE_SPLASH_CHANCE		= false;
		 	UPGRADE_MORE_SYMBOLS		= false;
		 	UPGRADE_BOMB_CASCADE		= false;
		 	UPGRADE_SWARM_MASTERED		= false;
		
		 	UPGRADE_LAUNCHER_III		= false;
		 	UPGRADE_POISON_DAMAGE		= false;
		 	UPGRADE_LAUNCHER_V			= false;
		 	UPGRADE_POISON_CHANCE		= false;
		 	UPGRADE_MEMORY_CHANCE		= false;
		 	UPGRADE_POISON_CLOUD		= false;
		 	UPGRADE_LAUNCHER_MASTERED	= false;
		
		 	UPGRADE_FREEZE_III			= false;
		 	UPGRADE_LONGER_STUN			= false;
		 	UPGRADE_FREEZE_V			= false;
		 	UPGRADE_STUN_CHANCE			= false;
		 	UPGRADE_HACK_PROTECT		= false;
		 	UPGRADE_MULTY_STUN			= false;
		 	UPGRADE_FREEZE_MASTERED		= false;
			
			GRAY_MATRIX = [
							0.3086, 0.6094, 0.082, 0, 0,
					  		0.3086, 0.6094, 0.082, 0, 0,
					  		0.3086, 0.6094, 0.082, 0, 0,
								 0,		 0,	  	0, 1, 0
							];
		
			INTRODUCE_SPEEDER			= false;
			INTRODUCE_WORM				= false;
			INTRODUCE_RECODER			= false;
			INTRODUCE_PROTECTOR			= false;
			INTRODUCE_NEIROBOT			= false;
			INTRODUCE_RUNNER			= false;
			INTRODUCE_CYCLER			= false;
			INTRODUCE_EMMITER			= false;
			INTRODUCE_BUG				= false;
		
			INTRODUCE_GUN				= false;
			INTRODUCE_SWARM				= false;
			INTRODUCE_LAUNCHER			= false;
			INTRODUCE_FREEZE			= false;
		
			INTRODUCE_ADDITIONAL_MARKER	= false;
			INTRODUCE_FLOW_OVERLOAD		= false;
			INTRODUCE_FLOW_STOP			= false;
			INTRODUCE_SYS_DAMAGE_REDUCE	= false;
			INTRODUCE_RELOCATE_TURRET	= false;
			INTRODUCE_FALSE_TARGET		= false;
			INTRODUCE_MINES				= false;
			
			NUM_NEIROBOTS = 0;
			NUM_PROTECTORS = 0;
		}
	}
}