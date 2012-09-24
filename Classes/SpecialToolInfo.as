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