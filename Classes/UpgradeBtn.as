package 
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;

	public class UpgradeBtn extends MovieClip
	{
		public var achieved:Boolean 		= false;
		public var canBeAchieved:Boolean 	= false;
		
		public var mouseIsOver:Boolean		= false;
		
		public function UpgradeBtn()
		{
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
		}
		
		private function onOver(e:MouseEvent):void
		{
			
		}
		
		private function onOut(e:MouseEvent):void
		{
			
		}
		
		public function setAchieved():void
		{
			achieved = true;
			filters = [new GlowFilter(0x0000FF)];
		}
		
		public function setCanBeAchieved():void
		{
			canBeAchieved = true;
			filters = [new GlowFilter(0x0000FF)];
		}
	}
}