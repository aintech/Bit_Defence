package 
{
	import flash.display.MovieClip;

	public class IntroduceScreen extends MovieClip
	{
		
		public static const GUN:String					= "intro Gun";
		public static const SWARM:String					= "intro Swarm";
		public static const LAUNCHER:String 			= "intro Launcher";
		public static const FREEZE:String 				= "intro Freeze";
		
		public static const SPEEDER:String 				= "intro Speeder";
		public static const WORM:String					= "intro Worm";
		
		public static const ADDITIONAL_MARKER:String = "intro Additional Marker";
		public static const FLOW_OVERLOAD:String		= "intro Flow Overload";
		public static const FLOW_STOP:String			= "intro Flow Stop";
		public static const RELOCATE_TURRET:String	= "intro Relocate Turret";
		public static const HACK_REDUCE:String			= "intro Hack Reduce";
		
		public var introduceObject:String;
		
		public function IntroduceScreen(introduce:String)
		{
			introduceObject = introduce;
		}
	}
}