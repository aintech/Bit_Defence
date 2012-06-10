package 
{
	import flash.display.Shape;
	import flash.filters.GlowFilter;

	public class Particle extends Shape
	{
		public var speed:int;
		
		public function Particle(color:uint)
		{
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(-1, -1, 2, 2);
			this.graphics.endFill();
			this.filters = [new GlowFilter(color)];
		}
	}
}