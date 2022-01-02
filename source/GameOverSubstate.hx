package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;
	var thefuck:FlxSound;
	var die:FlxSound;
	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'benoprologue':
				stageSuffix = '-e'; // fix i guess lol
				daBf = 'benoprologue';
			case 'benoscared':
				daBf = 'benoscared';
			case 'benopromise':
				stageSuffix = '-e'; // fix i guess lol
				daBf = 'benopromise';
			case 'bfexile':
				stageSuffix = '-bruh';
				daBf = 'bfexile';
			case 'elise':// for other time lollllolololl -Z
				stageSuffix = '-elise';
				daBf = 'elise';
			case 'eliserelease':
				stageSuffix = '-elise';
				daBf = 'eliserelease';
			case 'bfnormal':
				stageSuffix = '-bruh';
				daBf = 'bfnormal';
			default:
				stageSuffix = '-bruh';
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'exile':
			{
				thefuck = FlxG.sound.play(Paths.sound('thefuck' + stageSuffix));
			}
			}
		}
		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding) // duplicate for Exile since both sound are for that song
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'exile':
			{
				die = FlxG.sound.play(Paths.sound('die' + stageSuffix));
				
				isEnding = true;
				bf.playAnim('deathConfirm', true);
				FlxG.sound.music.stop();
				thefuck.stop();
				FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
				new FlxTimer().start(0.7, function(tmr:FlxTimer)
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
				});
				
			}
			}

		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}


