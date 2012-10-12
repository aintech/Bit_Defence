package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class CharIcon extends MovieClip
	{
		public var charType:String;
		public var charName:String;
		
		public var level:int;
		public var damage:int;
		public var memoryUse:int;
		public var range:int;
		public var reloadTime:int;
		public var numMissiles:int;
		
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
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd, false, 0, true);
		}
		
		private function onAdd(e:Event):void
		{
			hitPoint.visible = false;
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
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			filters = [new GlowFilter(0x0000FF)];
		}
		
		public function setDisable():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			filters = [];
			border.visible = false;
		}
	}
}