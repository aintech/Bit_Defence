package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.display.Shape;
	import flash.events.MouseEvent;

	public class SpecialTools extends MovieClip
	{
		public static const SYS_DAMAGE_REDUCE:String 	= "damage reduce";
		public static const FLOW_STOP:String			= "flow stop";
		public static const FLOW_OVERLOAD:String		= "flow overload";
		public static const RELOCATE_TURRET:String		= "relocate turret";
		public static const ADDITIONAL_MARKER:String	= "additional marker";
		public static const FALSE_TARGET:String			= "false target";
		public static const MINES:String				= "mines";
		
		public var counter:int = 0;
		public var timeWait:int;
		
		public var type:String;
		private var border:Shape;
		public var enable:Boolean = false;
		public var inAction:Boolean = false;
		public var cooltime:int;
		
		public function SpecialTools(type:String)
		{
			this.type = type;
			mouseChildren = false;
			
			border = new Shape();
			border.graphics.lineStyle(2, 0xFFFFFF);
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(width, 0);
			border.graphics.lineTo(width, height);
			border.graphics.lineTo(0, height);
			border.graphics.lineTo(0, 0);
			addChild(border);
			border.visible = false;
		}
		
		private function onOver(e:MouseEvent):void
		{
			border.visible = true;
			filters = [new GlowFilter(0x0000FF, 10, 10)];
		}
		
		private function onOut(e:MouseEvent):void
		{
			border.visible = false;
			filters = [new GlowFilter(0x0000FF)];
		}
		
		public function setEnable():void
		{
			enable = true;
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			filters = [new GlowFilter(0x0000FF)];
			buttonMode = true;
		}
		
		public function setDisable():void
		{
			enable = false;
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			filters = [];
			buttonMode = false;
			border.visible = false;
		}
		
		public function toolDescription():String
		{
			var descript:String = "tool descript";
			switch(type)
			{
				
			}
			return descript;
		}
	}
}