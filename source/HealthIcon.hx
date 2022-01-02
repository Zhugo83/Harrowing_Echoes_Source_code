package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
	
		animation.add('bf-car', [0, 1], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		animation.add('spooky', [2, 3], 0, false, isPlayer);
		animation.add('pico', [4, 5], 0, false, isPlayer);
		animation.add('mom', [6, 7], 0, false, isPlayer);
		animation.add('mom-car', [6, 7], 0, false, isPlayer);
		animation.add('tankman', [8, 9], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('gf-christmas', [16], 0, false, isPlayer);
		animation.add('gf-pixel', [16], 0, false, isPlayer);
		animation.add('parents-christmas', [17, 18], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		// used sprites
		animation.add('face', [10, 11, 10], 0, false, isPlayer);
		animation.add('dad', [33, 34, 32], 0, false, isPlayer); // dad is always place holders lol -Z
		animation.add('gfChristmasprologue', [16], 0, false, isPlayer);
		animation.add('gfChristmasact', [16], 0, false, isPlayer);
		animation.add('gfprologue', [16], 0, false, isPlayer);
		animation.add('gfpromise', [16], 0, false, isPlayer);
		animation.add('gfexile', [16], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('bf', [0, 1, 0], 0, false, isPlayer);
		animation.add('bfexile', [0, 1, 0], 0, false, isPlayer);
		animation.add('bfnormal', [0, 1, 0], 0, false, isPlayer);
		animation.add('benopromise', [24, 25, 24], 0, false, isPlayer);
		animation.add('benoprologue', [24, 25, 24], 0, false, isPlayer);
		animation.add('jix', [26, 27, 26], 0, false, isPlayer);
		animation.add('cursedjix', [39, 40, 39], 0, false, isPlayer);
		animation.add('benoscared', [28, 29, 28], 0, false, isPlayer);
		animation.add('garcellodead', [30, 31, 30], 0, false, isPlayer);
		animation.add('beno1', [33, 34, 32], 0, false, isPlayer); // 1 = neutral, 2 = losing, 3 = winning opponent side (FFS REMEMBER THIS) -Z
		animation.add('beno2', [33, 34, 32], 0, false, isPlayer);
		animation.add('beno3', [35, 36, 38], 0, false, isPlayer);// that a lot of beno lol -Z
		animation.add('beno3blood', [35, 36, 38], 0, false, isPlayer);

		animation.add('beno4', [43, 37, 35], 0, false, isPlayer); // 35 = No face 37 = Smilling 43 = Ugh.. -Z
		animation.add('benohappy', [43, 37, 35], 0, false, isPlayer);
		animation.add('beno4release', [35, 37, 35], 0, false, isPlayer);

		animation.add('zhugo', [41, 42, 41], 0, false, isPlayer); // hey that mee !!! -Z
		animation.add('madzhugo', [41, 42, 41], 0, false, isPlayer);
		animation.add('glitchzhugo', [41, 42, 41], 0, false, isPlayer);
		animation.add('gamer', [0, 1, 0], 0, false, isPlayer);

		animation.add('elise', [44, 45, 46], 0, false, isPlayer);
		animation.add('eliserelease', [44, 45, 46], 0, false, isPlayer);
		animation.add('benomegalovania', [47], 0, false, isPlayer);
		animation.play(char);

		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
			case 'face': // ahaa -Z
				flipX = true;
		}
		
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
