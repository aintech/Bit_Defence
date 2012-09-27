package 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Button extends MovieClip
	{
		private var btnLabel:String;
		private var labelIndex:int = 0;
		private var timer:Timer;
		private var field:TextField;
		private var format:TextFormat;
		private var outFilter:GlowFilter = new GlowFilter(0x0000FF);
		private var overFilter:GlowFilter = new GlowFilter(0x0000FF, 1, 20, 20);
		private var bg:Sprite;
		private var border:Sprite;
		private var btnWidth:int = 200;
		private var btnHeight:int = 55;
		public var offset:int = 5;
		
		public function Button(label:String = "BUTTON")
		{
			btnLabel = label;
			addEventListener(MouseEvent.MOUSE_OVER, overButton, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, outButton, false, 0, true);
			buttonMode = true;
			mouseChildren = false;
			format = new TextFormat();
			format.font = "Digital-7";
			format.size = 50;
			format.color = 0xFFFFFF;
			
			bg = new Sprite();
			bg.graphics.beginFill(0xFFFFFF, 0);
			bg.graphics.drawRect(0, 0, btnWidth, btnHeight);
			bg.graphics.endFill();
			addChild(bg);
			
			border = new Sprite();
			border.graphics.lineStyle(2, 0xFFFFFF);
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(btnWidth, 0);
			border.graphics.lineTo(btnWidth, btnHeight);
			border.graphics.lineTo(0, btnHeight);
			border.graphics.lineTo(0, 0);
			border.visible = false;
			addChild(border);
			
			field = new TextField();
			field.defaultTextFormat = format;
			field.text = btnLabel;
			field.selectable = false;
			field.autoSize = TextFieldAutoSize.CENTER;
			field.x = btnWidth * .5 - field.width * .5;
			field.text = "";
			bg.addChild(field);
			
			filters = [outFilter];
			
			timer = new Timer(50, btnLabel.length);
			timer.addEventListener(TimerEvent.TIMER, textAnimation, false, 0, true);
			timer.start();
		}
		
		private function textAnimation(e:Event):void
		{
			if(labelIndex == 0) field.text = "";
			field.appendText(String(btnLabel.charAt(labelIndex)));
			labelIndex++;
			if(labelIndex >= btnLabel.length) removeEventListener(Event.ENTER_FRAME, textAnimation);
		}
		
		private function overButton(e:MouseEvent):void
		{
			border.visible = true;
			filters = [overFilter];
		}
		
		private function outButton(e:MouseEvent):void
		{
			border.visible = false;
			filters = [outFilter];
		}
	}
}