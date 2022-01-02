package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

import flixel.tweens.FlxTween; // amongus -Z
import flixel.FlxCamera;
import flixel.util.FlxTimer;
import openfl.Lib;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songTimer:FlxTimer;
	
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var composertext:FlxText;
	var warning:FlxText; // for wrong choice since it make crash ! -Z
	var comboText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
	var combo:String = '';

	var mainCam:FlxCamera;
	var higherCam:FlxCamera;
	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));

	public static var frenziedfreeplay:Bool = false;
	public var screenDanced:Bool = false;
	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	override function create()
	{
		#if html5 
		FlxG.switchState(new SongState());
		#end

		mainCam = new FlxCamera();
		higherCam = new FlxCamera();
		higherCam.bgColor.alpha = 0;
	
		FlxG.cameras.reset(mainCam);
		FlxG.cameras.add(higherCam);
		
		FlxCamera.defaultCameras = [mainCam];

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist')); // default in case fail loads. -Z

		if (NewFreeplaystate.hipromisesongsplease == true)
		{
			initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglistpromise'));
		}

		else if (NewFreeplaystate.hiprologuesongsplease == true)
		{
			initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglistprologue'));
		}

		else if (NewFreeplaystate.hiact1songsplease == true)
		{
			initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglistact1'));
		}

		else if (NewFreeplaystate.hibonussongssongsplease == true)
		{
			initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglistbonussongs'));
		}

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
		}

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Freeplay Menu", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false, true);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);
			
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		comboText = new FlxText(diffText.x + 330, diffText.y, 0, "", 20);
		comboText.font = diffText.font;
		add(comboText);

		add(scoreText);

		composertext = new FlxText(scoreText.x + 92, scoreText.y + 36, 0, "", 21);
		composertext.font = scoreText.font;
		add(composertext);

		warning = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		warning.font = scoreText.font;
		warning.screenCenter(Y);
		add(warning);
		

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		FlxG.sound.cache(Paths.inst(songName));
		trace("cached " + songName);
		songs.push(new SongMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['dad'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.F) // fullscreen yay :D -Z
			{
				FlxG.fullscreen = !FlxG.fullscreen;
			}

		if (FlxG.sound.music != null && FlxG.sound.music.playing)
			{
				Conductor.songPosition = FlxG.sound.music.time;
			}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;
		comboText.text = combo + '\n';

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (FlxG.keys.justPressed.SEVEN)
			{
				FlxG.switchState(new NewFreeplaystate());
			}
		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		
		if (FlxG.mouse.wheel != 0)
			{
				changeSelection(FlxG.mouse.wheel * -1);
			}
		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);

		if (controls.BACK)
		{
			FlxG.switchState(new NewFreeplaystate());
		}

		if (accepted)
		{
			// adjusting the song name to be compatible
			var songFormat = StringTools.replace(songs[curSelected].songName, " ", "-");
			switch (songFormat) {
				case 'Dad-Battle': songFormat = 'Dadbattle';
				case 'Philly-Nice': songFormat = 'Philly';

			}
			
			trace(songs[curSelected].songName);

			var poop:String = Highscore.formatSong(songFormat, curDifficulty);

			trace(poop);
			
			switch (songs[curSelected].songName.toLowerCase())
			{
				case "frenzied":
					FlxG.switchState(new EasyEnding());	
					frenziedfreeplay = true;
				default:
					PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName);
			}
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;
			PlayState.storyWeek = songs[curSelected].week;
			trace('CUR WEEK' + PlayState.storyWeek);
			LoadingState.loadAndSwitchState(new PlayState());		
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		// adjusting the highscore song name to be compatible (changeDiff)
		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
		switch (songHighscore) {
			case 'Dad-Battle': songHighscore = 'Dadbattle';
			case 'Philly-Nice': songHighscore = 'Philly';
		}
		
		#if !switch
		intendedScore = Highscore.getScore(songHighscore, curDifficulty);
		combo = Highscore.getCombo(songHighscore, curDifficulty);
		#end

		if (songs[curSelected].songName.toLowerCase() == "echo-(erect-remix)")
		{
			switch (curDifficulty)
			{
				case 0:
					diffText.text = "ERECT";
				case 1:
					diffText.text = 'ERECT';
				case 2:
					diffText.text = "ERECT";
			}
		}
		else if (songs[curSelected].songName.toLowerCase() == "frenzy-x-megalovania")
			{
				switch (curDifficulty)
				{
					case 0:
						diffText.text = "SANS";
					case 1:
						diffText.text = 'SANS';
					case 2:
						diffText.text = "SANS";
				}
			}
		else
		{
		switch (curDifficulty)
		{
			case 0:
				diffText.text = "EASY";
			case 1:
				diffText.text = 'NORMAL';
			case 2:
				diffText.text = "HARD";
		}
		}

	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;
		
		// adjusting the highscore song name to be compatible (changeSelection)
		// would read original scores if we didn't change packages
		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
		switch (songHighscore) {
			case 'Dad-Battle': songHighscore = 'Dadbattle';
			case 'Philly-Nice': songHighscore = 'Philly';
		}

		#if !switch
		intendedScore = Highscore.getScore(songHighscore, curDifficulty);
		combo = Highscore.getCombo(songHighscore, curDifficulty);
		// lerpScore = 0;
		#end

		// yes yes the code below can be better but atm idc -Z
		if (songs[curSelected].songName.toLowerCase() == 'frenzy-x-megalovania')
			{
				composertext.text = "Composer:XavNG";
				remove(bg);
				bg = new FlxSprite().loadGraphic(Paths.image('sansfreeplay'));
				add(bg);
				
					switch (curDifficulty)
					{
						case 0:
							diffText.text = "SANS";
						case 1:
							diffText.text = 'SANS';
						case 2:
							diffText.text = "SANS";
					}
				
			}
			else
			{
				remove(bg);
				bg = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
				add(bg);
			}
			if (songs[curSelected].songName.toLowerCase() == 'ZhugoLecturesYouAboutPiracy')
				{
					composertext.text = "Remix:Elise/Gamer572";
				}
		if (songs[curSelected].songName.toLowerCase() == 'training' || songs[curSelected].songName.toLowerCase() == 'nothing-personal'|| songs[curSelected].songName.toLowerCase() == 'your-choice'|| songs[curSelected].songName.toLowerCase() == 'prodito'|| songs[curSelected].songName.toLowerCase() == 'echo'|| songs[curSelected].songName.toLowerCase() == 'frenzy'|| songs[curSelected].songName.toLowerCase() == 'exile'|| songs[curSelected].songName.toLowerCase() == 'frenzied')
			{
				composertext.text = "Composer:XavNG";
			}
			else if (songs[curSelected].songName.toLowerCase() == "training-oldinst" || songs[curSelected].songName.toLowerCase() == "nothing-personal-oldinst")
			{
				composertext.text = "RComposer:XavNG";
				warning.text = "";
			}
			else if (songs[curSelected].songName.toLowerCase() == "echo-(erect-remix)")
				{
					switch (curDifficulty)
					{
						case 0:
							diffText.text = "ERECT";
						case 1:
							diffText.text = 'ERECT';
						case 2:
							diffText.text = "ERECT";
					}
					composertext.text = "RemixComposer:XavNG";
					warning.text = "";
				}
				else if (songs[curSelected].songName.toLowerCase() == "frenzy-x-megalovania")
					{	
						composertext.text = "FunnyComposer:XavNG";
						switch (curDifficulty)
						{
							case 0:
								diffText.text = "EASY";
							case 1:
								diffText.text = 'NORMAL';
							case 2:
								diffText.text = "HARD";
						}
					}
			else if (songs[curSelected].songName.toLowerCase() == "wrong-choice")
			{
				switch (curDifficulty)
				{
					case 0:
						diffText.text = "EASY";
					case 1:
						diffText.text = 'NORMAL';
					case 2:
						diffText.text = "HARD";
				}
				composertext.text = "Remix:Elise";
				warning.text = "MAKE GAME CRASH!";
			}
			else if (songs[curSelected].songName.toLowerCase() == "spaghetticode")
			{
				composertext.text = "Composer:Gamer572YT";
				switch (curDifficulty)
				{
					case 0:
						diffText.text = "EASY";
					case 1:
						diffText.text = 'NORMAL';
					case 2:
						diffText.text = "HARD";
				}
			}
			else if (songs[curSelected].songName.toLowerCase() == "release")
				{
					composertext.text = "Composer:atsuover";
				}

		#if PRELOAD_ALL
		if (FlxG.sound.music.playing)
		{
			FlxG.sound.music.stop();
		}
		if (songTimer != null)
		{
			songTimer.cancel();
			songTimer.destroy();
		}
		songTimer = new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if (FlxG.sound.music.playing)
			{
				FlxG.sound.music.stop();
			}
			FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
			Conductor.changeBPM(Song.loadFromJson(songs[curSelected].songName.toLowerCase(), songs[curSelected].songName.toLowerCase()).bpm);
		}, 1);
		#else
		Conductor.changeBPM(Song.loadFromJson(songs[curSelected].songName.toLowerCase(), songs[curSelected].songName.toLowerCase()).bpm);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;

			if (['frenzied'].contains(songs[curSelected].songName.toLowerCase()))
				{
				iconArray[i].alpha = 0.1;
				}
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;
			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));
			if (['frenzied'].contains(songs[curSelected].songName.toLowerCase()))
				{
					item.alpha = 0.1;
				}

			if (item.targetY == 0)
			{
				item.screenCenter(X);
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		
	}
	
	override function beatHit()
		{
			super.beatHit();
			
			if (['frenzied', 'frenzy', 'prodito'].contains(songs[curSelected].songName.toLowerCase()))
			{
				if (curBeat % 2 == 1) // haft the beat lol -Z
					{
			FlxG.camera.zoom += 0.03;
			FlxTween.tween(FlxG.camera, { zoom: 1 }, 0.1);
					}
		}
		if (['wrong-choice'].contains(songs[curSelected].songName.toLowerCase()))
			{
			FlxG.camera.zoom += 0.03;
			FlxTween.tween(FlxG.camera, { zoom: 1 }, 0.1);
		}
		if (['echo', 'echo-(erect-remix)'].contains(songs[curSelected].songName.toLowerCase()))
		{
			if (curBeat % 2 == 1) // haft the beat lol -Z
			{
			FlxG.camera.zoom += 0.06;
			FlxTween.tween(FlxG.camera, { zoom: 1 }, 0.5); // banger -Z
			}
		}
		if (['frenzied'].contains(songs[curSelected].songName.toLowerCase()))
		{
			if (curBeat % 2 == 1) // haft the beat lol -Z
				{
			FlxG.camera.shake(0.05, 0.1);
			FlxG.camera.zoom += 0.06;
			FlxTween.tween(FlxG.camera, { zoom: 1 }, 0.1);
			if (!FlxG.fullscreen)
				screenDance();
				}
		}

		if (['frenzy'].contains(songs[curSelected].songName.toLowerCase()))
			{
				if (curBeat % 2 == 1) // haft the beat lol -Z
					{
				if (curBeat % 2 == 1)
				{
				FlxG.camera.shake(0.01, 0.1);
				FlxG.camera.zoom += 0.06;
				FlxTween.tween(FlxG.camera, { zoom: 1 }, 0.1);
				if (!FlxG.fullscreen)
					screenDance();
				}
				}
			}
		if (['wrong-choice'].contains(songs[curSelected].songName.toLowerCase()))
			{
				if (curBeat % 4 == 3)
				{
				FlxG.camera.shake(0.01, 0.1);
				FlxG.camera.zoom += 0.06;
				FlxTween.tween(FlxG.camera, { zoom: 1 }, 0.1);
				}
			}
	}

	public function screenDance():Void
		{
			if (!screenDanced)
			{
				Lib.application.window.x += Std.int(Lib.application.window.width / 100);
			} else {
				Lib.application.window.x -= Std.int(Lib.application.window.width / 100);
			}
			screenDanced = !screenDanced;
		}

}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
