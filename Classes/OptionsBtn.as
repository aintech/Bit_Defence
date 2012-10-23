package 
{
	import flash.filters.GlowFilter;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;

	public class OptionsBtn extends MovieClip
	{
		private var border:Shape;
		
		public function OptionsBtn()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
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
			
			buttonMode = true;
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
	}
}