package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;

	public class ChooseTurretCircle extends MovieClip
	{
		public var targetMarker:MovieClip;
		
		public function ChooseTurretCircle()
		{
			// constructor code
		}
		
		public function setStatus(turretType:String):void
		{
			switch(turretType)
			{
				case Turret.TURRET_GUN:
					turret_gun.filters = [new GlowFilter(0x0000FF)];
					turret_gun.buttonMode = true;
					turret_gun.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
					turret_gun.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
				break;
			
				case Turret.TURRET_LAUNCHER:
					turret_launcher.filters = [new GlowFilter(0x0000FF)];
					turret_launcher.buttonMode = true;
					turret_launcher.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
					turret_launcher.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
				break;
			
				case Turret.TURRET_FREEZE:
					turret_freeze.filters = [new GlowFilter(0x0000FF)];
					turret_freeze.buttonMode = true;
					turret_freeze.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
					turret_freeze.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
				break;
				
				case Turret.TURRET_SWARM:
					turret_swarm.filters = [new GlowFilter(0x0000FF)];
					turret_swarm.buttonMode = true;
					turret_swarm.addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
					turret_swarm.addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
				break;
				
				default:
					trace("error in ChooseTurretCircle.as - turretType: " + turretType);
				break;
			}
		}
		
		private function onOver(e:MouseEvent):void
		{
			e.currentTarget.filters = [new GlowFilter(0x0000FF, 1, 10, 10)];
		}
		
		private function onOut(e:MouseEvent):void
		{
			e.currentTarget.filters = [new GlowFilter(0x0000FF)];
		}
	}
}