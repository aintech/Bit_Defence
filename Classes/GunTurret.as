package 
{
	public class GunTurret extends Turret
	{		
		public function GunTurret()
		{
			init();
		}
		
		private function init():void
		{
			maxLevel = Variables.GUN_LEVEL;
			base = new TurretBase();
			gun = new GunTurret_Gun();
			addChild(base);
			addChild(gun);	
			
			type = Turret.TURRET_GUN;
			
			abilityDescription 	= "Cheap & Fast";
		}
		
		override public function updateLevel():void
		{
			switch(level)
			{
				case 1:
				memoryUse = 50;
				range = 100;
				reloadTime = 10;
				damage = 20;
				upgradeCost = 25;
				installingTime = 60;
				upgradingTime = 60;
				uninstallingTime = 60;
				additionalDamage = 5;
				additionalRange = 10;
				additionalReloadTime = 0;
				break;
				
				case 2:
				memoryUse = 75;
				range = 110;
				reloadTime = 10;
				damage = 25;
				upgradeCost = 25;
				installingTime = 90;
				upgradingTime = 90;
				uninstallingTime = 90;
				additionalDamage = 5;
				additionalRange = 10;
				additionalReloadTime = 0;
				break;
				
				case 3:
				memoryUse = 100;
				range = 120;
				reloadTime = 10;
				damage = 30;
				upgradeCost = 25;
				installingTime = 120;
				upgradingTime = 120;
				uninstallingTime = 120;
				additionalDamage = 5;
				additionalRange = 10;
				additionalReloadTime = 0;
				gunCritChance = Variables.GUN_CRIT_CHANCE;
				gunCritMultiply = Variables.GUN_CRIT_DAMAGE_MULTIPLY;
				break;
				
				case 4:
				memoryUse = 125;
				range = 130;
				reloadTime = 10;
				damage = 35;
				upgradeCost = 25;
				installingTime = 150;
				upgradingTime = 150;
				uninstallingTime = 150;
				additionalDamage = 5;
				additionalRange = 10;
				additionalReloadTime = 5;
				gunCritChance = Variables.GUN_CRIT_CHANCE;
				gunCritMultiply = Variables.GUN_CRIT_DAMAGE_MULTIPLY;
				break;
				
				case 5:
				memoryUse = 150;
				range = 140;
				reloadTime = 5;
				damage = 40;
				upgradeCost = 25;
				installingTime = 180;
				uninstallingTime = 180;
				gunCritChance = Variables.GUN_CRIT_CHANCE;
				gunCritMultiply = Variables.GUN_CRIT_DAMAGE_MULTIPLY;
				break;
			}
		}
	}
}