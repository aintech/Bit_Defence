package 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;

	public class Drop extends MovieClip
	{
		public static const DROP_SYMBOLS:String 	= "drop symbols";
		public static const DROP_MEMORY:String 	= "drop memory";
		public static const DROP_PROTECT:String	= "drop protect";
		public static const DISTANCE:int				= 60;
		
		public var dropType:String;
		public var dropAmaunt:int;
		
		public var speed:int = 7;
		public var destX:Number;
		public var destY:Number;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var angle:Number;
		
		private var disapearTime:int = 10000;
		private var disapearTimer:Timer = new Timer(disapearTime, 1);
		
		public var inPosition:Boolean;
		public var dropReady:Boolean;
		
		public function Drop()
		{
			buttonMode = true;
			mouseChildren = false;
			
			disapearTimer.addEventListener(TimerEvent.TIMER_COMPLETE, disapear, false, 0, true);
			disapearTimer.start();
			
			filters = [new GlowFilter(0x0000FF)];
			addEventListener(MouseEvent.MOUSE_OVER, onOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onOut, false, 0, true);
		}
		
		private function onOver(e:MouseEvent):void
		{
			filters = [new GlowFilter(0x0000FF, 1, 10, 10)];
		}
		
		private function onOut(e:MouseEvent):void
		{
			filters = [new GlowFilter(0x0000FF)];
		}
		
		public function disapear(e:TimerEvent = null):void
		{
			dropReady = true;
			disapearTimer.stop();
			removeEventListener(TimerEvent.TIMER_COMPLETE, disapear);
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			filters = [new GlowFilter(0x0000FF), new BlurFilter(0, 0)];
		}
	}
}