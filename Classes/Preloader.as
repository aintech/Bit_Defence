package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Preloader extends MovieClip
	{		
		public function Preloader()
		{
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			gotoAndStop(1);
		}
		
		public function update(e:Event):void
		{
			txtBytes.text = String(Math.round(loaderInfo.bytesLoaded / 1024)) + " / " + String(Math.round(loaderInfo.bytesTotal / 1024)) + "Kb";
			txtPercent.text = String(Math.round(loaderInfo.bytesLoaded / loaderInfo.bytesTotal * 100)) + " %";
			
			if(loaderInfo.bytesLoaded == loaderInfo.bytesTotal || loaderInfo.bytesTotal == 0)
			{
				dispatchEvent(new Event("loadComplete"));
				clean();
			}
		}
		
		private function clean():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			itsOver();
		}
		
		private function itsOver():void
		{
			dispatchEvent(new Event("preloadFinished"));
		}
	}
}