package 
{
	import flash.geom.Point;
	import flash.display.MovieClip;

	public class EnemyFalseTarget extends MovieClip
	{
		public var canBePlaced:Boolean;
		public var placed:Boolean;
		public var protectAmount:Number 	= Variables.SPECIAL_FALSE_TARGET_PROTECTION;
		public var lifeTime:int				= Variables.SPECIAL_FALSE_TARGET_PROTECTION_LIFE;
		public var lifeCounter:int 		= 0;
		
		public function EnemyFalseTarget()
		{
			// constructor code
		}
	}
}