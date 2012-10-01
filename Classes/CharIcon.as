package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.display.Shape;
	import flash.events.MouseEvent;

	public class CharIcon extends MovieClip
	{
		public var charType:String;
		public var memoryUse:int;
		public var range:int;
		private var border:Shape;
		
		public function CharIcon(type:String)
		{
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			charType = type;
			mouseChildren = false;
			filters = [new GlowFilter(0x0000FF)];
			
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
	}
}