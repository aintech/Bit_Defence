package 
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LevelButton extends MovieClip
	{
		public var levelText:TextField;
		private var format:TextFormat;
		
		public function LevelButton()
		{
			format = new TextFormat("_sans", "18");
			format.align = TextFormatAlign.CENTER;
			format.color = 0xFFFFFF;
			
			levelText = new TextField();
			levelText.height = 24;
			levelText.width = 24;
			levelText.x = -levelText.height * .5;
			levelText.y = -levelText.width * .5;
			levelText.type = TextFieldType.DYNAMIC;
			levelText.selectable = false;
			levelText.defaultTextFormat = format;
			addChild(levelText);
			
			levelText.text = "0";
		}
	}
}