package 
{
	public class SwarmTurret extends Turret
	{
		public function SwarmTurret()
		{
			init();
		}
		
		private function init():void
		{
			maxLevel = Variables.SWARM_MAX_LEVEL;
			base = new TurretBase();
			gun = new MissileTurret_Gun();
			addChild(base);
			addChild(gun);
			
			numSwarmBombs = 6;
			
			type = Turret.TURRET_SWARM;
			
			abilityDescription 	= "Missile Swarm";
		}
		
		override public function updateLevel():void
		{
			switch(level)
			{
				case 1:
				memoryUse = 150;
				range = 300;
				reloadTime = 20;
				damage = 5;
				upgradeCost = 50;
				numMissiles = 3;
				installingTime = 60;
				upgradingTime = 60;
				uninstallingTime = 60;
				additionalDamage = 1;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 2:
				memoryUse = 200;
				range = 300;
				reloadTime = 20;
				damage = 6;
				upgradeCost = 50;
				numMissiles = 4;
				installingTime = 90;
				upgradingTime = 90;
				uninstallingTime = 90;
				additionalDamage = 1;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 3:
				memoryUse = 250;
				range = 300;
				reloadTime = 20;
				damage = 7;
				upgradeCost = 50;
				numMissiles = 5;
				installingTime = 120;
				upgradingTime = 120;
				uninstallingTime = 120;
				additionalDamage = 1;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 4:
				memoryUse = 300;
				range = 300;
				reloadTime = 20;
				damage = 8;
				upgradeCost = 50;
				numMissiles = 6;
				installingTime = 1500;
				upgradingTime = 150;
				uninstallingTime = 150;
				additionalDamage = 2;
				additionalRange = 0;
				additionalReloadTime = 0;
				break;
				
				case 5:
				memoryUse = 350;
				range = 300;
				reloadTime = 20;
				damage = 10;
				upgradeCost = 50;
				numMissiles = 7;
				installingTime = 180;
				uninstallingTime = 180;
				break;
			}
		}
	}
}