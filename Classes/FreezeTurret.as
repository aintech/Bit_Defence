package 
{
	public class FreezeTurret extends Turret
	{
		override protected function init():void
		{
			super.init();
			maxLevel = Variables.FREEZE_MAX_LEVEL;
			base = new TurretBase();
			addChild(base);	
			
			type = Turret.TURRET_FREEZE;
			turretName = "Freeze";
			
			abilityDescription 	= "Slowing NoDamage";
			damage = 0;
		}
		
		override public function updateLevel():void
		{
			var rot:int = 0;
			switch(level)
			{
				case 1:
				memoryUse = 50;
				range = 150;
				reloadTime = 10;
				upgradeCost = 25;
				installingTime = 60;
				upgradingTime = 60;
				uninstallingTime = 60;
				additionalDamage = 0;
				additionalRange = 15;
				additionalReloadTime = 1;
				if(gun && gun is FreezeTurret_Gun_I) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new FreezeTurret_Gun_I();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 2:
				memoryUse = 75;
				range = 165;
				reloadTime = 9;
				upgradeCost = 25;
				installingTime = 90;
				upgradingTime = 90;
				uninstallingTime = 90;
				additionalDamage = 0;
				additionalRange = 15;
				additionalReloadTime = 1;
				if(gun && gun is FreezeTurret_Gun_II) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new FreezeTurret_Gun_II();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 3:
				memoryUse = 100;
				range = 180;
				reloadTime = 8;
				upgradeCost = 25;
				installingTime = 120;
				upgradingTime = 120;
				uninstallingTime = 120;
				additionalDamage = 0;
				additionalRange = 15;
				additionalReloadTime = 1;
				if(gun && gun is FreezeTurret_Gun_III) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new FreezeTurret_Gun_III();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 4:
				memoryUse = 125;
				range = 190;
				reloadTime = 7;
				upgradeCost = 25;
				installingTime = 150;
				upgradingTime = 150;
				uninstallingTime = 150;
				additionalDamage = 0;
				additionalRange = 15;
				additionalReloadTime = 2;
				if(gun && gun is FreezeTurret_Gun_IV) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new FreezeTurret_Gun_IV();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 5:
				memoryUse = 150;
				range = 200;
				reloadTime = 5;
				upgradeCost = 25;
				installingTime = 180;
				uninstallingTime = 180;
				if(gun && gun is FreezeTurret_Gun_V) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new FreezeTurret_Gun_V();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
			}
		}
	}
}