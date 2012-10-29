package 
{
	public class LauncherTurret extends Turret
	{
		override protected function init():void
		{
			super.init();
			maxLevel = Variables.LAUNCHER_MAX_LEVEL;
			base = new TurretBase();
			addChild(base);
			
			type = Turret.TURRET_LAUNCHER;
			turretName = "Launcher";
			
			abilityDescription 	= "Splash Damage";
		}
		
		override public function updateLevel():void
		{
			var rot:int = 0;
			switch(level)
			{
				case 1:
				memoryUse = 100;
				range = 200;
				reloadTime = 20;
				damage = 200;
				upgradeCost = 30;
				installingTime = 60;
				upgradingTime = 60;
				uninstallingTime = 60;
				additionalDamage = 50;
				additionalRange = 0;
				additionalReloadTime = 0;
				if(gun && gun is LauncherTurret_Gun_I) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new LauncherTurret_Gun_I();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 2:
				memoryUse = 130;
				range = 200;
				reloadTime = 20;
				damage = 250;
				upgradeCost = 30;
				installingTime = 90;
				upgradingTime = 90;
				uninstallingTime = 90;
				additionalDamage = 50;
				additionalRange = 0;
				additionalReloadTime = 0;
				if(gun && gun is LauncherTurret_Gun_II) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new LauncherTurret_Gun_II();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 3:
				memoryUse = 160;
				range = 200;
				reloadTime = 20;
				damage = 300;
				upgradeCost = 30;
				installingTime = 120;
				upgradingTime = 120;
				uninstallingTime = 120;
				additionalDamage = 100;
				additionalRange = 0;
				additionalReloadTime = 0;
				if(gun && gun is LauncherTurret_Gun_III) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new LauncherTurret_Gun_III();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 4:
				memoryUse = 180;
				range = 200;
				reloadTime = 16;
				damage = 400;
				upgradeCost = 30;
				installingTime = 150;
				upgradingTime = 150;
				uninstallingTime = 150;
				additionalDamage = 100;
				additionalRange = 0;
				additionalReloadTime = 0;
				if(gun && gun is LauncherTurret_Gun_IV) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new LauncherTurret_Gun_IV();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
				
				case 5:
				memoryUse = 210;
				range = 200;
				reloadTime = 16;
				damage = 500;
				upgradeCost = 30;
				installingTime = 180;
				uninstallingTime = 180;
				if(gun && gun is LauncherTurret_Gun_V) {}
				else
				{
					if(gun)
					{
						rot = gun.rotation;
						removeChild(gun);
						gun = null;
					}
					gun = new LauncherTurret_Gun_V();
					addChild(gun);
					gun.rotation = rot;
				}
				break;
			}
		}
	}
}