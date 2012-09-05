package 
{
	import flash.display.MovieClip;
	import flash.utils.getTimer;

	public class IntroduceScreen extends MovieClip
	{
		
		public static const GUN:String					= "intro_Gun";
		public static const SWARM:String					= "intro_Swarm";
		public static const LAUNCHER:String 			= "intro_Launcher";
		public static const FREEZE:String 				= "intro_Freeze";
		
		public static const SPEEDER:String 				= "intro_Speeder";
		public static const WORM:String					= "intro_Worm";
		
		public static const ADDITIONAL_MARKER:String = "intro_Additional_Marker";
		public static const FLOW_OVERLOAD:String		= "intro_Flow_Overload";
		public static const FLOW_STOP:String			= "intro_Flow_Stop";
		public static const RELOCATE_TURRET:String	= "intro_Relocate_Turret";
		public static const HACK_REDUCE:String			= "intro_Hack_Reduce";
		
		public var introduceObject:String;
		public var comingOut:Boolean 			= true;
		public var leaving:Boolean				= false;
		public var speed:int						= 3;
		public var timeToLeave:int				= 200; // = 10000 ms / gameTimer(50)
		public var counter:int					= 0;
		
		public function IntroduceScreen(introduce:String)
		{
			introduceObject = introduce;
			buttonMode = true;
		}
	}
}