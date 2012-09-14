package 
{
	import flash.display.MovieClip;

	public class GunTurret extends Turret
	{		
		public function GunTurret()
		{
			init();
		}
		
		private function init():void
		{
			maxLevel = Variables.GUN_MAX_LEVEL;
			base = new TurretBase();
			//gun = new GunTurret_Gun_I();
			gun = new MovieClip();
			addChild(base);
			addChild(gun);	
			
			type = Turret.TURRET_GUN;
			
			abilityDescription 	= "Cheap & Fast";
			
			gunAccDamage = 0;
			gunEnemyID = 33333;
			gunEnemyPrevID = 22222;
		}
		
		override public function updateLevel():void
		{
			switch(level)
			{
				case 1:
				memoryUse = 50;
				range = 120;
				reloadTime = 10;
				damage = 200;
				upgradeCost = 25;
				installingTime = 60;
				upgradingTime = 60;
				uninstallingTime = 60;
				additionalDamage = 50;
				additionalRange = 10;
				additionalReloadTime = 0;
				removeChild(gun);
				gun = null;
				gun = new GunTurret_Gun_I();
				addChild(gun);
				break;
				
				case 2:
				memoryUse = 75;
				range = 130;
				reloadTime = 10;
				damage = 250;
				upgradeCost = 25;
				installingTime = 90;
				upgradingTime = 90;
				uninstallingTime = 90;
				additionalDamage = 50;
				additionalRange = 10;
				additionalReloadTime = 0;
				removeChild(gun);
				gun = null;
				gun = new GunTurret_Gun_II();
				addChild(gun);
				break;
				
				case 3:
				memoryUse = 100;
				range = 140;
				reloadTime = 10;
				damage = 300;
				upgradeCost = 25;
				installingTime = 120;
				upgradingTime = 120;
				uninstallingTime = 120;
				additionalDamage = 50;
				additionalRange = 10;
				additionalReloadTime = 2;
				removeChild(gun);
				gun = null;
				gun = new GunTurret_Gun_III();
				addChild(gun);
				break;
				
				case 4:
				memoryUse = 125;
				range = 150;
				reloadTime = 8;
				damage = 350;
				upgradeCost = 25;
				installingTime = 150;
				upgradingTime = 150;
				uninstallingTime = 150;
				additionalDamage = 50;
				additionalRange = 10;
				additionalReloadTime = 2;
				removeChild(gun);
				gun = null;
				gun = new GunTurret_Gun_IV();
				addChild(gun);
				break;
				
				case 5:
				memoryUse = 150;
				range = 160;
				reloadTime = 6;
				damage = 400;
				upgradeCost = 25;
				installingTime = 180;
				uninstallingTime = 180;
				removeChild(gun);
				gun = null;
				gun = new GunTurret_Gun_V();
				addChild(gun);
				break;
			}
		}
	}
}