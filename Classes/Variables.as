package 
{
	public class Variables
	{
		public static var SYMBOLS:int 			= 100;
		
		public static var GUN_LEVEL:int 			= 5;
		public static var SWARM_LEVEL:int 		= 5;
		public static var FREEZE_LEVEL:int 		= 5;
		public static var LAUNCHER_LEVEL:int 	= 5;
		
		public static var DAMAGE_MULTIPLY:Number 			= 1;
		public static var RANGE_MULTIPLY:Number 			= 1;
		public static var RELOAD_TIME_REDUCE:Number 		= 1;
		public static var UPGRADE_COST_REDUCE:Number 	= 1;
		public static var MEMORY_USE_REDUCE:Number 		= 1;
		public static var SYMBOLS_DROP_MULTIPLE:Number 	= 1;
		public static var TOTAL_MEMORY_INCREASE:int 		= 0;
		
		public static var GUN_TURRET_COST:int				= 50;
		public static var LAUNCHER_TURRET_COST:int		= 100;
		public static var FREEZE_TURRET_COST:int			= 50;
		public static var SWARM_TURRET_COST:int			= 150;
		
		public static var GUN_CRIT_CHANCE:int 							= 10;//шанс gunTurret на критический выстрел
		public static var GUN_CRIT_DAMAGE_MULTIPLY:int				= 2;//увеличивает критический повреждения
		
		public static var FREEZE_STUN_CHANCE:int						= 10;
		public static var FREEZE_STUN_DURATION:int					= 30;
		public static var FREEZE_SPEED_REDUCE_DURATION:int			= 30;
		public static var FREEZE_SPEED_REDUCE_MULTIPLY:Number		= .5;
		
		public static var LAUNCHER_POISON_CHANCE:int					= 10;
		public static var LAUNCHER_POISON_DURATION:int 				= 30;
		public static var LAUNCHER_POISON_DAMAGE:int					= 2;
		
		public static var SWARM_SPLASH_CHANCE:int						= 10;
		public static var SWARM_SPLASH_DAMAGE:int						= 10;
		
		public static var SPECIAL_TOOL_GAUGE:int						= 4;
		
		public static var SPECIAL_ADDITIONAL_MARKER_COOLTIME:int		= 100;
		public static var SPECIAL_FLOW_OVERLOAD_COOLTIME:int			= 100;
		public static var SPECIAL_FLOW_STOP_COOLTIME:int				= 100;
		public static var SPECIAL_HACK_CHANCE_REDUCE_COOLTIME:int 	= 100;
		public static var SPECIAL_RELOCATE_TURRET_COOLTIME:int		= 100;
		
		public static var SPECIAL_FLOW_OVERLOAD_DAMAGE:int					= 30;
		public static var SPECIAL_HACK_CHANCE_REDUCE_MULTIPLY:Number	= .5;
		public static var SPECIAL_FLOW_STOP_DURATION:int					= 50;
		public static var SPECIAL_ADDITIONAL_MARKER_INSTALL_TIME:int 	= 50;
		
		public static const WAVE_DELAY:int								= 20; //enemy delay time in sec
		
		public function Variables()
		{
			// constructor code
		}
	}
}