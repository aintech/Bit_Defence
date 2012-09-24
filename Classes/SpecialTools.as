package 
{
	import flash.display.MovieClip;

	public class SpecialTools extends MovieClip
	{
		public static const SYS_DAMAGE_REDUCE:String 	= "system damage reduce";
		public static const FLOW_STOP:String			= "flow stop";
		public static const FLOW_OVERLOAD:String		= "flow overload";
		public static const RELOCATE_TURRET:String		= "relocate turret";
		public static const ADDITIONAL_MARKER:String	= "additional marker";
		public static const FALSE_TARGET:String			= "false target";
		public static const MINES:String				= "mines";
		
		public var counter:int = 0;
		public var timeWait:int;
		
		public var type:String;
		
		public function SpecialTools(type:String)
		{
			this.type = type;
			buttonMode = true;
		}
	}
}