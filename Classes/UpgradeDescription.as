package 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;

	public class UpgradeDescription extends MovieClip
	{
		private var holder:Sprite;
		private var BG:UpgradeBG;
		
		public var txtName:TextField;
		private var nameFormat:TextFormat;
		
		public var txtCost:TextField;
		private var costFormat:TextFormat;
		
		public var txtDescription:TextField;
		private var descriptFormat:TextFormat;
		
		public function UpgradeDescription()
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
			mouseEnabled = false;
			mouseChildren = false;
			
			BG = new UpgradeBG();
			addChild(BG);
			
			holder = new Sprite();
			addChild(holder);
			
			nameFormat = new TextFormat();
			nameFormat.font = "Digital-7";
			nameFormat.size = "18";
			nameFormat.color = "0x00FF00";
			
			txtName = new TextField();
			txtName.autoSize = TextFieldAutoSize.LEFT;
			txtName.defaultTextFormat = nameFormat;
			txtName.embedFonts = true;
			txtName.y = -40;
			txtName.filters = [new DropShadowFilter()];
			holder.addChild(txtName);
			
			costFormat = new TextFormat();
			costFormat.font = "Digital-7";
			costFormat.size = "18";
			costFormat.color = "0xFFFF00";
			
			txtCost = new TextField();
			txtCost.autoSize = TextFieldAutoSize.LEFT;
			txtCost.defaultTextFormat = costFormat;
			txtCost.embedFonts = true;
			txtCost.x = txtName.x + txtName.width + 5;
			txtCost.y = txtName.y;
			holder.addChild(txtCost);
			
			descriptFormat = new TextFormat();
			descriptFormat.font = "Digital-7";
			descriptFormat.size = "14";
			descriptFormat.color = "0xFFFFFF";;
			
			txtDescription = new TextField();
			txtDescription.autoSize = TextFieldAutoSize.LEFT;
			txtDescription.defaultTextFormat = descriptFormat;
			txtDescription.embedFonts = true;
			txtDescription.y = -17;
			holder.addChild(txtDescription);
		}
		
		public function setBG(xVal:int):void
		{
			var grid:Rectangle = new Rectangle(45, 15, 50, 20);
			var w:int = Math.max(txtDescription.width, (txtName.width + txtCost.width + 5));
			BG.scale9Grid = grid;
			BG.width = w + 20;
			
			if(Main.STAGE_WIDTH < xVal + BG.width + 60) holder.x = -holder.width - 15;
			else holder.x = 15;
			
			holder.y = -15;
			BG.x = holder.x - 8;
			BG.y = holder.y - holder.height - 3;
		}
	}
}