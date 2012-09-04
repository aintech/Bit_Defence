package 
{
	import flash.display.MovieClip;

	public class SpecialTools extends MovieClip
	{
		public static const HACK_REDUCE:String 			= "hack chance reduce";
		public static const FLOW_STOP:String				= "flow stop";
		public static const FLOW_OVERLOAD:String			= "flow overload";
		public static const RELOCATE_TURRET:String		= "relocate turret";
		public static const ADDITIONAL_MARKER:String		= "additional marker";
		
		public var counter:int = 0;
		public var timeWait:int;
		
		public var type:String;
		
		public function SpecialTools(type:String)
		{
			this.type = type;
			
		}
	}
}