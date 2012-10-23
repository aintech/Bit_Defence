package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class ScoreBoard extends MovieClip
	{
		public static const UPD_SYSTEM:String 	= "update system text";
		public static const UPD_WAVE:String 	= "update wave text";
		public static const UPD_ENEMIES:String 	= "update enemies text";
		public static const UPD_MEMORY:String 	= "update memory text";
		public static const UPD_SYMBOLS:String 	= "update symbols text";
				
		public function update(updateName:String, updateValue:String)
		{
			switch(updateName)
			{
				case UPD_SYSTEM:
					txtSystem.text = String(Number(Math.round(Number(updateValue) * 10) * .1).toFixed(1)) + " %";
				break;
				
				case UPD_WAVE:
					txtWave.text = updateValue;
				break;
				
				case UPD_ENEMIES:
					txtEnemiesLeft.text = updateValue;
				break;
				
				case UPD_MEMORY:
					txtMemory.text = updateValue;
				break;
				
				case UPD_SYMBOLS:
					txtSymbols.text = updateValue;
				break;
			}
		}
	}
}