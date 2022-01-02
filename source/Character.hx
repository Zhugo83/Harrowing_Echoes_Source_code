package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var noteSkin:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				noteSkin = 'gf';
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gfprologue':
				noteSkin = 'gf';
				tex = Paths.getSparrowAtlas('characters/GF_PROLOGUE_prologue');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gfpromise':
				noteSkin = 'gf';
				tex = Paths.getSparrowAtlas('characters/GF_assets_promise');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gfexile':
				noteSkin = 'gf';
				tex = Paths.getSparrowAtlas('characters/GF_assets_EXILE');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

		case 'gfChristmasprologue':
				noteSkin = 'gf';
				tex = Paths.getSparrowAtlas('characters/gfChristmas_prologue');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gfChristmasact':
				noteSkin = 'gf';
				tex = Paths.getSparrowAtlas('characters/gfChristmas_act');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

				case 'gfrelease':
					noteSkin = 'gf';
					tex = Paths.getSparrowAtlas('characters/GF_RELEASE');
					frames = tex;
					animation.addByPrefix('cheer', 'GF Cheer', 24, false);
					animation.addByPrefix('singLEFT', 'GF left note', 24, false);
					animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
					animation.addByPrefix('singUP', 'GF Up Note', 24, false);
					animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
					animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
					animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
					animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
					animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
					animation.addByPrefix('scared', 'GF FEAR', 24);
	
					addOffset('cheer');
					addOffset('sad', -2, -21);
					addOffset('danceLeft', 0, -9);
					addOffset('danceRight', 0, -9);
	
					addOffset("singUP", 0, 4);
					addOffset("singRIGHT", 0, -20);
					addOffset("singLEFT", 0, -19);
					addOffset("singDOWN", 0, -20);
					addOffset('hairBlow', 45, -8);
					addOffset('hairFall', 0, -9);
	
					addOffset('scared', -2, -17);
	
					playAnim('danceRight');

			case 'dad':
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'benomegalovania': // should not be used but aaaaaaaaaaaaaaaaaaa -Z
			noteSkin = 'beno';
			tex = Paths.getSparrowAtlas('characters/BENO_POSES_PHASE_2', 'shared');
			frames = tex;
			animation.addByPrefix('idle', 'beno_phase2_idle', 24);
			animation.addByPrefix('singUP', 'beno_phase2_up', 24);
			animation.addByPrefix('singRIGHT', 'beno_phase2_right', 24);
			animation.addByPrefix('singDOWN', 'beno_phase2_down', 24);
			animation.addByPrefix('singLEFT', 'beno_phase2_left', 24);
			//they are sing, for that beno plays the whole animation instead of just playing it one and glitching out -Z
			animation.addByPrefix('slash', 'beno_slash', 24);
			animation.addByPrefix('stab', 'beno_stab', 24);
			animation.addByPrefix('jojo', 'beno_jojo', 24, false);
			animation.addByPrefix('breakmic', 'beno_mic_break', 24, false);

			addOffset('idle');
			addOffset("singUP", 30, 30);
			addOffset("singRIGHT", 10, 0);
			addOffset("singLEFT", 0, 0);
			addOffset("singDOWN", 0, -40);
			addOffset("slash", 20, 0);
			addOffset("stab", 0, 0);
			addOffset("jojo", 60, 0);
			addOffset("breakmic", 240, 0);

			playAnim('idle');

			case 'beno3': // Epic beno fight :D -Z
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/BENO_POSES_PHASE_2', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'beno_phase2_idle', 24);
				animation.addByPrefix('singUP', 'beno_phase2_up', 24);
				animation.addByPrefix('singRIGHT', 'beno_phase2_right', 24);
				animation.addByPrefix('singDOWN', 'beno_phase2_down', 24);
				animation.addByPrefix('singLEFT', 'beno_phase2_left', 24);
				//they are sing, for that beno plays the whole animation instead of just playing it one and glitching out -Z
				animation.addByPrefix('slash', 'beno_slash', 24);
				animation.addByPrefix('stab', 'beno_stab', 24);
				animation.addByPrefix('jojo', 'beno_jojo', 24, false);
				animation.addByPrefix('breakmic', 'beno_mic_break', 24, false);

				addOffset('idle');
				addOffset("singUP", 30, 30);
				addOffset("singRIGHT", 10, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, -40);
				addOffset("slash", 20, 0);
				addOffset("stab", 0, 0);
				addOffset("jojo", 60, 0);
				addOffset("breakmic", 240, 0);

				playAnim('idle');

			case 'beno3blood': // For um Frenzied -Z
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/BENO_POSES_PHASE_2_BLOOD', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'beno_phase2_idle_blood', 24);
				animation.addByPrefix('singUP', 'beno_phase2_up_blood', 24);
				animation.addByPrefix('singRIGHT', 'beno_phase2_right_blood', 24);
				animation.addByPrefix('singDOWN', 'beno_phase2_down_blood', 24);
				animation.addByPrefix('singLEFT', 'beno_phase2_left_blood', 24);
				animation.addByPrefix('slash', 'beno_slash_blood', 24); //they are sing, for that beno plays the whole animation instead of just playing it one and glitching out -Z
				animation.addByPrefix('stab', 'beno_stab_blood', 24);

				addOffset('idle');
				addOffset("singUP", 30, 30);
				addOffset("singRIGHT", 10, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, -40);
				addOffset("slash", 20, 0);
				addOffset("stab", 0, 0);

				playAnim('idle');

			case 'benohappy': // For exile,bruh -Z
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/BENO_POSES_PHASE3_ALT', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'beno_phase3_idle_alt', 24);
				animation.addByPrefix('singUP', 'beno_phase3_up_alt', 24);
				animation.addByPrefix('singRIGHT', 'beno_phase3_right_alt', 24);
				animation.addByPrefix('singDOWN', 'beno_phase3_down_alt', 24);
				animation.addByPrefix('singLEFT', 'beno_phase3_left_alt', 24);

				addOffset('idle');
				addOffset("singUP", 0, 25);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, -10);
				addOffset("singDOWN", 0, -15);

				playAnim('idle');

			case 'beno4': // For exile,bruh -Z
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/BENO_POSES_PHASE3', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'beno_phase3_idle', 24);
				animation.addByPrefix('singUP', 'beno_phase3_up', 24);
				animation.addByPrefix('singRIGHT', 'beno_phase3_right', 24);
				animation.addByPrefix('singDOWN', 'beno_phase3_down', 24);
				animation.addByPrefix('singLEFT', 'beno_phase3_left', 24);

				addOffset('idle');
				addOffset("singUP", 0, 25);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, -10);
				addOffset("singDOWN", 0, -15);

				playAnim('idle');

			case 'beno4release': // the name say it, and i don't know if someone will ever read this but.. i'm glad if someone do it anyways, have a great day though :D -Z
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/BENO_POSES_RELEASE', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'beno_phase3_idle', 24);
				animation.addByPrefix('singUP', 'beno_phase3_up', 24);
				animation.addByPrefix('singRIGHT', 'beno_phase3_right', 24);
				animation.addByPrefix('singDOWN', 'beno_phase3_down', 24);
				animation.addByPrefix('singLEFT', 'beno_phase3_left', 24);

				addOffset('idle');
				addOffset("singUP", 0, 25);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, -10);
				addOffset("singDOWN", 0, -15);

				playAnim('idle');

			case 'zhugo': // made by Gamer from our team :D -Z
			noteSkin = 'GlitchNotes';
				tex = Paths.getSparrowAtlas('characters/Zhugo_Assets', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Up', 24);
				animation.addByPrefix('singRIGHT', 'Right', 24);
				animation.addByPrefix('singDOWN', 'Down', 24);
				animation.addByPrefix('singLEFT', 'Left', 24);

				addOffset('idle', 20, -84);
				addOffset("singUP", 11, -64);
				addOffset("singRIGHT", -9, -84);
				addOffset("singLEFT", 59, -80); 
				addOffset("singDOWN", 2, -121);

				playAnim('idle');

			case 'madzhugo': // made by Gamer from our team :D -Z
				noteSkin = 'GlitchNotes';
				tex = Paths.getSparrowAtlas('characters/ZhugoAnimationsAngry', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Idle Angry', 24);
				animation.addByPrefix('singUP', 'Up Angry', 24);
				animation.addByPrefix('singRIGHT', 'Right Angry', 24);
				animation.addByPrefix('singDOWN', 'Down Angry', 24);
				animation.addByPrefix('singLEFT', 'Left Angry', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", 0, 20);
				addOffset("singRIGHT", -40, -50);
				addOffset("singLEFT", 30, -60); 
				addOffset("singDOWN", -30, -110);

				playAnim('idle');

			case 'glitchzhugo': // made by Gamer from our team :D -Z
				noteSkin = 'GlitchNotes';
				tex = Paths.getSparrowAtlas('characters/ZhugoAnimationsINSANE', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Up Insane', 24);
				animation.addByPrefix('singUP', 'Up Insane', 24);
				animation.addByPrefix('singRIGHT', 'Right Insane', 24);
				animation.addByPrefix('singDOWN', 'Down Insane', 24);
				animation.addByPrefix('singLEFT', 'Left Insane', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", 0, 20);
				addOffset("singRIGHT", -40, -50);
				addOffset("singLEFT", 30, -60); 
				addOffset("singDOWN", -30, -110);

				playAnim('idle');

			case 'gamer': // made by Gamer from our team :D -Z
				noteSkin = 'bf';
				tex = Paths.getSparrowAtlas('characters/Gamer572_assets', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Up0', 24);
				animation.addByPrefix('singRIGHT', 'Right0', 24);
				animation.addByPrefix('singDOWN', 'Down0', 24);
				animation.addByPrefix('singLEFT', 'Left0', 24);
				animation.addByPrefix('singUPmiss', 'DownMISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'LeftMISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'RightMISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'UpMISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -26, 13);
				addOffset("singRIGHT", -27, -6);
				addOffset("singLEFT", 7, -3);
				addOffset("singDOWN", -7, -1);
				addOffset("singUPmiss", -26, 15);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", -31, 7);
				addOffset("singDOWNmiss", -6, 4);

				playAnim('idle');

				flipX = true;

			case 'beno1':
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/BENO_POSES_NORMAL', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'BENO_IDLE', 24, false);
				animation.addByPrefix('singUP', 'BENO_UP', 24);
				animation.addByPrefix('singRIGHT', 'BENO_RIGHT', 24);
				animation.addByPrefix('singDOWN', 'BENO_DOWN', 24);
				animation.addByPrefix('singLEFT', 'BENO_LEFT', 24);

				addOffset('idle', 120, -20);
				addOffset("singUP", 20, 60);
				addOffset("singRIGHT", -80, 20);
				addOffset("singLEFT", 20, 0);
				addOffset("singDOWN", -30, -50);

				playAnim('idle');

			case 'beno2':
				noteSkin = 'beno';
				tex = Paths.getSparrowAtlas('characters/BENO_POSES_MAD', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'BENO_IDLE_MAD', 24, false);
				animation.addByPrefix('singUP', 'BENO_UP_ALT', 24);
				animation.addByPrefix('singRIGHT', 'BENO_RIGHT_ALT', 24);
				animation.addByPrefix('singDOWN', 'BENO_DOWN_ALT', 24);
				animation.addByPrefix('singLEFT', 'BENO_LEFT_ALT', 24);

				addOffset('idle', 120, -20);
				addOffset("singUP", 20, 60);
				addOffset("singRIGHT", -80, 20);
				addOffset("singLEFT", 20, 0);
				addOffset("singDOWN", -30, -50);

				playAnim('idle');

				case 'jix':
					noteSkin = 'jix';
					tex = Paths.getSparrowAtlas('characters/Jix_FNF_assetss', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'Pico Idle Dance0', 24, false);
					animation.addByPrefix('singUP', 'pico Up note0', 24);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24);
					animation.addByPrefix('singDOWN', 'Pico Down Note0', 24);
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24);
	
					addOffset('idle');
					addOffset("singUP", -90, 40);
					addOffset("singRIGHT", -5, 0);
					addOffset("singLEFT", 0, 0);
					addOffset("singDOWN", -90, -10);
	
					playAnim('idle');
				case 'cursedjix': // Very very cursed ! -Z
					noteSkin = 'jix';
					tex = Paths.getSparrowAtlas('characters/shix', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'wtf0', 24, false);
					animation.addByPrefix('singUP', 'wtf0', 24);
					animation.addByPrefix('singRIGHT', 'wtf0', 24);
					animation.addByPrefix('singDOWN', 'wtf0', 24);
					animation.addByPrefix('singLEFT', 'wtf0', 24);
	
					addOffset('idle');
					addOffset("singUP");
					addOffset("singRIGHT");
					addOffset("singLEFT");
					addOffset("singDOWN");
	
					playAnim('idle');

			case 'elise':
				noteSkin = 'elise';
				var tex = Paths.getSparrowAtlas('characters/Elise_Sprites', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'elise_idle', 24, false);
				animation.addByPrefix('singUP', 'elise_up0', 24, false);
				animation.addByPrefix('singLEFT', 'elise_left0', 24, false);
				animation.addByPrefix('singRIGHT', 'elise_right0', 24, false);
				animation.addByPrefix('singDOWN', 'elise_down0', 24, false);
				animation.addByPrefix('singUPmiss', 'elise_up_miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'elise_left_miss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'elise_right_miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'elise_down_miss', 24, false);

				animation.addByPrefix('firstDeath', "el_dies0", 24, false);
				animation.addByPrefix('deathLoop', "el_dies loop", 24, true);
				animation.addByPrefix('deathConfirm', "el_dead_confirm", 24, false);

				addOffset('idle', -80,95);
				addOffset("singUP", -130, 130);
				addOffset("singRIGHT", -180, 90);
				addOffset("singLEFT", -135, 90);
				addOffset("singDOWN", -140, 90);
				addOffset("singUPmiss", -125, 131);
				addOffset("singRIGHTmiss", -165, 90);
				addOffset("singLEFTmiss", -125, 90);
				addOffset("singDOWNmiss", -150, 85);
				addOffset('firstDeath', -7, 96); 
				addOffset('deathLoop', -7, -124);
				addOffset('deathConfirm', -8, -90);

				playAnim('idle');

				flipX = true;

			case 'eliserelease':
				noteSkin = 'elise';
				var tex = Paths.getSparrowAtlas('characters/Elise_Sprites_Release', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'elise_idle', 24, false);
				animation.addByPrefix('singUP', 'elise_up0', 24, false);
				animation.addByPrefix('singLEFT', 'elise_left0', 24, false);
				animation.addByPrefix('singRIGHT', 'elise_right0', 24, false);
				animation.addByPrefix('singDOWN', 'elise_down0', 24, false);
				animation.addByPrefix('singUPmiss', 'elise_up_miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'elise_left_miss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'elise_right_miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'elise_down_miss', 24, false);

				animation.addByPrefix('firstDeath', "el_dies0", 24, false);
				animation.addByPrefix('deathLoop', "el_dies loop", 24, true);
				animation.addByPrefix('deathConfirm', "el_dead_confirm", 24, false);

				//I spend so much time offset perfect, but i don't really care since i love elise character -Z
				addOffset('idle', -80,95);
				addOffset("singUP", -130, 130);
				addOffset("singRIGHT", -180, 80);
				addOffset("singLEFT", -135, 80);
				addOffset("singDOWN", -140, 80);
				addOffset("singUPmiss", -130, 131);
				addOffset("singRIGHTmiss", -180, 80);
				addOffset("singLEFTmiss", -135, 80);
				addOffset("singDOWNmiss", -140, 80);
				addOffset('firstDeath', -7, 96);
				addOffset('deathLoop', -8, -124);
				addOffset('deathConfirm', -8, -90);

				playAnim('idle');

				flipX = true;

				case 'bfnormal':
				noteSkin = 'bf';
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND_UNSHADED', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('singDODGE', 'boyfriend dodge', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('singDODGE', 0, 0);

				playAnim('idle');

				flipX = true;

			case 'bf':
				noteSkin = 'bf';
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('singDODGE', 'boyfriend dodge', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('singDODGE', 0, 0);

				playAnim('idle');

				flipX = true;

				case 'bfexile':
				noteSkin = 'bf';
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND_EXILE', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('dodge', 'boyfriend dodge', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('dodge', 0, 0);

				playAnim('idle');

				flipX = true;
			case 'benoprologue':
				noteSkin = 'beno';
				var tex = Paths.getSparrowAtlas('characters/BENO_PROLOGUE_ASSETS', 'shared');
				frames = tex;
	
				trace(tex.frames.length);
	
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
	
				animation.addByPrefix('scared', 'BF idle shaking', 24);
	
				addOffset('idle', -4, 0);
				addOffset("singUP", -45, 0);
				addOffset("singRIGHT", -52, 0);
				addOffset("singLEFT", 4, -17);
				addOffset("singDOWN", -10, -45);
				addOffset("singUPmiss", -30, 25);
				addOffset("singRIGHTmiss", -50, 25);
				addOffset("singLEFTmiss", 0, 25);
				addOffset("singDOWNmiss", -20, -15);
				addOffset("hey", -3, 2);
				addOffset('firstDeath', 20, 30);
				addOffset('deathLoop', 20, 30);
				addOffset('deathConfirm', 20, 60);
				addOffset('scared', -4, 0);
	
				playAnim('idle');
	
				flipX = true;

			case 'benopromise':
				noteSkin = 'beno';
				var tex = Paths.getSparrowAtlas('characters/BENO_PROLOGUE_ASSETS_promise', 'shared');
				frames = tex;
	
				trace(tex.frames.length);
	
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
	
				animation.addByPrefix('scared', 'BF idle shaking', 24);
	
				addOffset('idle', -4, 0);
				addOffset("singUP", -45, 0);
				addOffset("singRIGHT", -52, 0);
				addOffset("singLEFT", 4, -17);
				addOffset("singDOWN", -10, -45);
				addOffset("singUPmiss", -30, 25);
				addOffset("singRIGHTmiss", -50, 25);
				addOffset("singLEFTmiss", 0, 25);
				addOffset("singDOWNmiss", -20, -15);
				addOffset("hey", -3, 2);
				addOffset('firstDeath', 20, 30);
				addOffset('deathLoop', 20, 30);
				addOffset('deathConfirm', 20, 60);
				addOffset('scared', -4, 0);
	
				playAnim('idle');
	
				flipX = true;
	
			case 'benoscared':
				noteSkin = 'beno';
				var tex = Paths.getSparrowAtlas('characters/BENO_SCARED', 'shared');
				frames = tex;
	
				trace(tex.frames.length);
	
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
	
				animation.addByPrefix('scared', 'BF idle shaking', 24);
	
				addOffset('idle', -4, 0);
				addOffset("singUP", -45, 0);
				addOffset("singRIGHT", -52, 0);
				addOffset("singLEFT", 4, -17);
				addOffset("singDOWN", -10, -45);
				addOffset("singUPmiss", -30, 25);
				addOffset("singRIGHTmiss", -50, 25);
				addOffset("singLEFTmiss", 0, 25);
				addOffset("singDOWNmiss", -20, -15);
				addOffset("hey", -3, 2);
				addOffset('firstDeath', 20, 30);
				addOffset('deathLoop', 20, 30);
				addOffset('deathConfirm', 20, 60);
				addOffset('scared', -4, 0);
	
				playAnim('idle');
	
				flipX = true;

				case 'garcellodead':
					// GARCELLO DEAD ANIMATION LOADING CODE
					tex = Paths.getSparrowAtlas('characters/garcellodead_assets', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'garcello idle dance', 24);
					animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
					animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
					animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
					animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);
	
					animation.addByPrefix('garTightBars', 'garcello coolguy', 15);
	
					addOffset('idle');
					addOffset("singUP", 0, 0);
					addOffset("singRIGHT", 0, 0);
					addOffset("singLEFT", 0, 0);
					addOffset("singDOWN", 0, 0);
					addOffset("garTightBars", 0, 0);
	
					playAnim('idle');
	
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			// BENO PROLOGUE IS FUCKED SO FLIP LEFT AND RIGHT QmdfghkSdfjhsùksdfgjsgdgsdfjpkp^zjkg^pgaz	e^jpor JHKOPFEKPOFDGPJKOHBQSHEDTOJÏK -Z
			if (curCharacter.startsWith('beno'))
			{
				//var animArray
			var oldRight = animation.getByName('singRIGHT').frames;
			animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
			animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
			if (animation.getByName('singRIGHTmiss') != null)
				{
			var oldMiss = animation.getByName('singRIGHTmiss').frames;
			animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
			animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!isPlayer) // CODE SHITDRshksdfmgbmhnsdjbjmkbhqdzshmjb -Z
			
		{
			if (animation.curAnim.name.startsWith('s'))
			{
				holdTimer += elapsed;
			}
				//note from Zhugo, i finaly understand the idle system And WOW IT WORK !!! i'm a genius 
			var dadVar:Float = 4;

			//if (curCharacter == 'dad')
			//	dadVar = 6.1;
			if (curCharacter == 'beno3blood')
				{
					dadVar = 3;
				}
			if (curCharacter == 'beno4release')
				{
					dadVar = 8;
				}
			if (curCharacter == 'beno1' && PlayState.SONG.song.toLowerCase()=='prodito')
				{
					//trace('prodito beno detected');
					dadVar = 6;
				}
			else if (curCharacter == 'beno1' || curCharacter == 'beno2' && PlayState.SONG.song.toLowerCase()=='echo' || PlayState.SONG.song.toLowerCase()=='echo-(erect-remix)')
				{
					//trace('echo benos detected');
					dadVar = 8;
				}

			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance(); // WAIT IT WAS BROKEN BEFORE ??? -Z, Also it's the idle after a note, it was broken somehow so i first did almost the same system in playstate -Z
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	
	}
	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
						case 'gfprologue':
							if (!animation.curAnim.name.startsWith('hair'))
							{
								danced = !danced;
		
								if (danced)
									playAnim('danceRight');
								else
									playAnim('danceLeft');
							}
							case 'gfpromise':
								if (!animation.curAnim.name.startsWith('hair') || !animation.curAnim.name.startsWith('sing')) // i hate this so bad -Z
								{
									danced = !danced;
			
									if (danced)
										playAnim('danceRight');
									else
										playAnim('danceLeft');
								}
								case 'gfexile':
									if (!animation.curAnim.name.startsWith('hair'))
									{
										danced = !danced;
				
										if (danced)
											playAnim('danceRight');
										else
											playAnim('danceLeft');
									}
									case 'gfChristmasprologue':
										if (!animation.curAnim.name.startsWith('hair'))
										{
											danced = !danced;
					
											if (danced)
												playAnim('danceRight');
											else
												playAnim('danceLeft');
										}
										case 'gfChristmasact':
											if (!animation.curAnim.name.startsWith('hair'))
											{
												danced = !danced;
						
												if (danced)
													playAnim('danceRight');
												else
													playAnim('danceLeft');
											}
										case 'gfrelease':
											if (!animation.curAnim.name.startsWith('hair'))
											{
												danced = !danced;
						
												if (danced)
													playAnim('danceRight');
												else
													playAnim('danceLeft');
											}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
