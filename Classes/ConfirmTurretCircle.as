package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;

	public class ConfirmTurretCircle extends MovieClip
	{
		public var targetMarker:MovieClip;
		public var turretType:String;
		public var turretRange:int;
		
		public function ConfirmTurretCircle()
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
			buyTurret.filters = [new GlowFilter(0x0000FF)];
			buyTurret.buttonMode = true;
			buyTurret.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			buyTurret.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
			
			cancelTurret.filters = [new GlowFilter(0xFF0000)];
			cancelTurret.buttonMode = true;
			cancelTurret.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			cancelTurret.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
		}
		
		private function onOver(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case "buyTurret":
					buyTurret.filters = [new GlowFilter(0x0000FF, 1, 10, 10)];
				break;
				
				case "cancelTurret":
					cancelTurret.filters = [new GlowFilter(0xFF0000, 1, 10, 10)];
				break;
			}
		}
		
		private function onOut(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case "buyTurret":
					buyTurret.filters = [new GlowFilter(0x0000FF)];
				break;
				
				case "cancelTurret":
					cancelTurret.filters = [new GlowFilter(0xFF0000)];
				break;
			}
		}
	}
}