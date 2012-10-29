package 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SoundCreator extends Sound
	{
		public static const INSTALLED:String = "installed speech";
		public static const DESTROYED:String = "destroy speech";
		
		public static function createSound(soundType:String):Sound
		{
			if(!Settings.SOUND_ON) return null;
			
			var sound:Sound = new Sound();
			var soundNumber:int;
			var soundName:String;
									
			switch(soundType)
			{
				case INSTALLED:
					soundNumber = Math.ceil(Math.random() * 22);
					switch(soundNumber)
					{
						case 1:
							sound = new install_01();
						break;
						
						case 2:
							sound = new install_02();
						break;
						
						case 3:
							sound = new install_03();
						break;
						
						case 4:
							sound = new install_04();
						break;
						
						case 5:
							sound = new install_05();
						break;
						
						case 6:
							sound = new install_06();
						break;
						
						case 7:
							sound = new install_07();
						break;
						
						case 8:
							sound = new install_08();
						break;
						
						case 9:
							sound = new install_09();
						break;
						
						case 10:
							sound = new install_10();
						break;
						
						case 11:
							sound = new install_11();
						break;
						
						case 12:
							sound = new install_12();
						break;
						
						case 13:
							sound = new install_13();
						break;
						
						case 14:
							sound = new install_14();
						break;
						
						case 15:
							sound = new install_15();
						break;
						
						case 16:
							sound = new install_16();
						break;
						
						case 17:
							sound = new install_17();
						break;
						
						case 18:
							sound = new install_18();
						break;
						
						case 19:
							sound = new install_19();
						break;
						
						case 20:
							sound = new install_20();
						break;
						
						case 21:
							sound = new install_21();
						break;
						
						case 22:
							sound = new install_22();
						break;
						
						default:
							trace("wrong soundNumber in SoundCreator" + soundNumber);
						break;
					}
				break;
				
				case DESTROYED:
					soundNumber = Math.ceil(Math.random() * 35);
					switch(soundNumber)
					{
						case 1:
							sound = new destroy_01;
						break;
						
						case 2:
							sound = new destroy_02;
						break;
						
						case 3:
							sound = new destroy_03;
						break;
						
						case 4:
							sound = new destroy_04;
						break;
						
						case 5:
							sound = new destroy_05;
						break;
						
						case 6:
							sound = new destroy_06;
						break;
						
						case 7:
							sound = new destroy_07;
						break;
						
						case 8:
							sound = new destroy_08;
						break;
						
						case 9:
							sound = new destroy_09;
						break;
						
						case 10:
							sound = new destroy_10;
						break;
						
						case 11:
							sound = new destroy_11;
						break;
						
						case 12:
							sound = new destroy_12;
						break;
						
						case 13:
							sound = new destroy_13;
						break;
						
						case 14:
							sound = new destroy_14;
						break;
						
						case 15:
							sound = new destroy_15;
						break;
						
						case 16:
							sound = new destroy_16;
						break;
						
						case 17:
							sound = new destroy_17;
						break;
						
						case 18:
							sound = new destroy_18;
						break;
						
						case 19:
							sound = new destroy_19;
						break;
						
						case 20:
							sound = new destroy_20;
						break;
						
						case 21:
							sound = new destroy_21;
						break;
						
						case 22:
							sound = new destroy_22;
						break;
						
						case 23:
							sound = new destroy_23;
						break;
						
						case 24:
							sound = new destroy_24;
						break;
						
						case 25:
							sound = new destroy_25;
						break;
						
						case 26:
							sound = new destroy_26;
						break;
						
						case 27:
							sound = new destroy_27;
						break;
						
						case 28:
							sound = new destroy_28;
						break;
						
						case 29:
							sound = new destroy_29;
						break;
						
						case 30:
							sound = new destroy_30;
						break;
						
						case 31:
							sound = new destroy_31;
						break;
						
						case 32:
							sound = new destroy_32;
						break;
						
						case 33:
							sound = new destroy_33;
						break;
						
						case 34:
							sound = new destroy_34;
						break;
						
						case 35:
							sound = new destroy_35;
						break;
						
						default:
							trace("wrong soundNumber in SoundCreator" + soundNumber);
						break;
					}
				break;
			}
			return sound;
		}
	}
}