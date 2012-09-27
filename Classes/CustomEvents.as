package 
{
	import flash.events.Event;

	public class CustomEvents extends Event
	{
		public static const START_GAME:String 		= "Start Game";
		public static const SHOW_SETTINGS:String 	= "Show Settings";
		public static const CLOSE_SETTINGS:String 	= "Close Settings";
		public static const SHOW_OPTIONS:String 	= "Show Options";
		//public static const SHOW_UPDATES:String		= "Show Updates";
		public static const SHOW_UPGRADES:String	= "Show Upgrades";
		public static const CLOSE_UPGRADES:String	= "Close Upgrades";
		public static const NEW_LEVEL:String 		= "New Level";
		public static const LEVEL_WIN:String		= "Level Win";
		public static const LEVEL_LOSE:String 		= "Level Lose";
		public static const GAME_WIN:String 		= "Game Win";
		
		public function CustomEvents(type:String)
		{
			super(type);
		}
	}
}