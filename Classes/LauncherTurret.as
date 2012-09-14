package 
{
	public class LauncherTurret extends Turret
	{
		public function LauncherTurret()
		{
			init();
		}
		
		private function init():void
		{
			maxLevel = Variables.LAUNCHER_MAX_LEVEL;
			base = new TurretBase();
			gun = new LauncherTurret_Gun();
			addChild(base);
			addChild(gun);
			
			type = Turret.TURRET_LAUNCHER;
			
			abilityDescription 	= "Splash Damage";
		}
		
		override public function updateLevel():void
		{
			switch(level)
			{
				case 1:
				memoryUse = 100;
				range = 200;
				reloadTime = 20;
				damage = 100;
				upgradeCost = 30;
				installingTime = 60;
				upgradingTime = 60;
				uninstallingTime = 60;
				additionalDamage = 50;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 2:
				memoryUse = 130;
				range = 200;
				reloadTime = 20;
				damage = 150;
				upgradeCost = 30;
				installingTime = 90;
				upgradingTime = 90;
				uninstallingTime = 90;
				additionalDamage = 50;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 3:
				memoryUse = 160;
				range = 200;
				reloadTime = 20;
				damage = 200;
				upgradeCost = 30;
				installingTime = 120;
				upgradingTime = 120;
				uninstallingTime = 120;
				additionalDamage = 50;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 4:
				memoryUse = 180;
				range = 200;
				reloadTime = 20;
				damage = 250;
				upgradeCost = 30;
				installingTime = 150;
				upgradingTime = 150;
				uninstallingTime = 150;
				additionalDamage = 50;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 5:
				memoryUse = 210;
				range = 200;
				reloadTime = 20;
				damage = 300;
				upgradeCost = 30;
				installingTime = 180;
				uninstallingTime = 180;
				break;
			}
		}
	}
}