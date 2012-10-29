package 
{
	public class SwarmTurret extends Turret
	{
		override protected function init():void
		{
			super.init();
			maxLevel = Variables.SWARM_MAX_LEVEL;
			base = new TurretBase();
			addChild(base);
			
			numSwarmBombs = 6;
			
			type = Turret.TURRET_SWARM;
			turretName = "Swarm";
			
			abilityDescription 	= "Missile Swarm";
		}
		
		override public function updateLevel():void
		{
			var rot:int = 0;
			switch(level)
			{
				case 1:
				memoryUse = 150;
				range = 300;
				reloadTime = 20;
				damage = 100;
				upgradeCost = 50;
				numMissiles = 3;
				installingTime = 60;
				upgradingTime = 60;
				uninstallingTime = 60;
				additionalDamage = 20;
				additionalRange = 0;
				additionalReloadTime = 0;
				additionalMissiles = 1;
				if(gun && gun is SwarmTurret_Gun_I) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new SwarmTurret_Gun_I();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 2:
				memoryUse = 200;
				range = 300;
				reloadTime = 20;
				damage = 120;
				upgradeCost = 50;
				numMissiles = 4;
				installingTime = 90;
				upgradingTime = 90;
				uninstallingTime = 90;
				additionalDamage = 20;
				additionalRange = 0;
				additionalReloadTime = 0;
				additionalMissiles = 1;
				if(gun && gun is SwarmTurret_Gun_II) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new SwarmTurret_Gun_II();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 3:
				memoryUse = 250;
				range = 300;
				reloadTime = 20;
				damage = 140;
				upgradeCost = 50;
				numMissiles = 5;
				installingTime = 120;
				upgradingTime = 120;
				uninstallingTime = 120;
				additionalDamage = 20;
				additionalRange = 0;
				additionalReloadTime = 4;
				additionalMissiles = 1;
				if(gun && gun is SwarmTurret_Gun_III) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new SwarmTurret_Gun_III();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 4:
				memoryUse = 300;
				range = 300;
				reloadTime = 16;
				damage = 160;
				upgradeCost = 50;
				numMissiles = 6;
				installingTime = 1500;
				upgradingTime = 150;
				uninstallingTime = 150;
				additionalDamage = 40;
				additionalRange = 0;
				additionalReloadTime = 0;
				additionalMissiles = 1;
				if(gun && gun is SwarmTurret_Gun_IV) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new SwarmTurret_Gun_IV();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 5:
				memoryUse = 350;
				range = 300;
				reloadTime = 16;
				damage = 200;
				upgradeCost = 50;
				numMissiles = 7;
				installingTime = 180;
				uninstallingTime = 180;
				if(gun && gun is SwarmTurret_Gun_V) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new SwarmTurret_Gun_V();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
			}
		}
	}
}