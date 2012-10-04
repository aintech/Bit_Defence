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
			filters = [new GlowFilter(0x0000FF, 1, 10, 10)];
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
				case SYS_DAMAGE_REDUCE:
					descript = "reduce viruses damage to your system by half for " + String(Variables.SPECIAL_SYS_DAMAGE_REDUCE_TIME * .05) + " sec";
				break;
				
				case FLOW_STOP:
					descript = "stop viruses for " + String(Variables.SPECIAL_FLOW_STOP_DURATION * .05) + " sec";
				break;
				
				case FLOW_OVERLOAD:
					descript = "viruses get " + String(Variables.SPECIAL_FLOW_OVERLOAD_DAMAGE) + " points of damage instantly";
				break;
				
				case RELOCATE_TURRET:
					descript = "relocating Turret to another Marker";
				break;
				
				case ADDITIONAL_MARKER:
					descript = "place new Marker near the Flow, to install Turret on it";
				break;
				
				case FALSE_TARGET:
					descript = "place on Flow false target that viruses need to hack, before they may proceed";
				break;
				
				case MINES:
					descript = "place " + String(Variables.SPECIAL_MINES_NUMBER) + " mines on Flow, each deal " + String(Variables.SPECIAL_MINES_DAMAGE) 
								+ " points of damage in radius " + String(Variables.SPECIAL_MINES_DISTANCE);
				break;
				
				default:
					trace("wrong tool in SpecialTools.toolDescription: ", type);
				break;
			}
			return descript;
		}
	}
}
/*
from SpecialToolInfo.as

package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;

	public class SpecialToolInfo extends Sprite
	{
		public var field:TextField;
		public var format:TextFormat;
		public var format_2:TextFormat;
		public var ramka:Shape = new Shape();
		public var g:Graphics = ramka.graphics;
		public var string:String = "undefined";
		public var begIndex:int;
		
		public function SpecialToolInfo(tool:String = "undefined")
		{
			switch(tool)
			{
				case SpecialTools.ADDITIONAL_MARKER:
					string = "Additional Marker /place new Marker for Turret/";
				break;
				
				case SpecialTools.FALSE_TARGET:
					string = "False Target /place on Flow false target to virus to hack/";
				break;
				
				case SpecialTools.FLOW_OVERLOAD:
					string = "Flow Overload /damage virus for " + String(Variables.SPECIAL_FLOW_OVERLOAD_DAMAGE) + " points/";
				break;
				
				case SpecialTools.FLOW_STOP:
					string = "Flow Stop /stop enemies for " + String(Variables.SPECIAL_FLOW_STOP_DURATION * .05) + " sec/";
				break;
				
				case SpecialTools.MINES:
					string = "Place Mines /place " + String(Variables.SPECIAL_MINES_NUMBER) + " mines X " + Variables.SPECIAL_MINES_DAMAGE + " points of damage/";
				break;
				
				case SpecialTools.RELOCATE_TURRET:
					string = "Relocate Turret /relocate your Turret to another Marker/";
				break;
				
				case SpecialTools.SYS_DAMAGE_REDUCE:
					string = "Reduce Damage on System /reduce enemy damage to your system by half/";
				break;
			}
			mouseEnabled = false;
			mouseChildren = false;
			format = new TextFormat();
			format_2 = new TextFormat();
			format.size = 20;
			format.color = 0xFFFFFF;
			format_2.size = 20;
			format_2.color = 0xFFFF00;
			field = new TextField();
			field.defaultTextFormat = format;
			field.autoSize = TextFieldAutoSize.LEFT;
			begIndex = string.indexOf("/");
			field.text = string;
			field.setTextFormat(format_2, begIndex, field.length);
			field.x = -(field.width * .5) + 5;
			field.y = -35;
			g.lineStyle(1, 0xFFFFFF);
			g.beginFill(0x000000);
			g.moveTo(0, 0);
			g.lineTo(10, -10);
			g.lineTo(-field.width * .5, -10);
			g.lineTo(-field.width * .5, -35);
			g.lineTo(field.width * .5 + 10, -35);
			g.lineTo(field.width * .5 + 10, -10);
			g.lineTo(20, -10);
			g.lineTo(0, 0);
			g.endFill();
			addChild(ramka);
			addChild(field);
		}
	}
}
*/