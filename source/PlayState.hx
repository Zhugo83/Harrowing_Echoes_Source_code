package;

import webm.WebmPlayer;
import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;

import flixel.util.FlxAxes;
import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.Lib;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

class PlayState extends MusicBeatState
{	
	public static var instance:PlayState = null;
	var endingShown:Bool = false;
	var doofend:DialogueBox;
	var doof:DialogueBox;
	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var weekScore:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;

	public static var songPosBG:FlxSprite;
	public static var songPosBar:FlxBar;

	public static var rep:Replay;
	public static var loadRep:Bool = false;

	public static var noteBools:Array<Bool> = [false, false, false, false];

	var halloweenLevel:Bool = false;

	var songLength:Float = 0;
	
	#if windows
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	private var vocals:FlxSound;
	private var noteCam:FlxCamera;
	public var originalX:Float;

	public static var dad:Character;
	public static var gf:Character;
	public static var boyfriend:Boyfriend;

	public var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	public var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	public static var strumLineNotes:FlxTypedGroup<FlxSprite> = null;
	public static var playerStrums:FlxTypedGroup<FlxSprite> = null;
	public static var cpuStrums:FlxTypedGroup<FlxSprite> = null;

	private var camZooming:Bool = true;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	public var health:Float = 1; //making public because sethealth doesnt work without it
	private var combo:Int = 0;
	public static var misses:Int = 0;
	public static var campaignMisses:Int = 0;
	public var accuracy:Float = 0.00;
	private var accuracyDefault:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalNotesHitDefault:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;


	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	private var songPositionBar:Float = 0;
	
	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	public var iconP1:HealthIcon; //making these public again because i may be stupid
	public var iconP2:HealthIcon; //what could go wrong?
	public var camHUD:FlxCamera;
	private var camGame:FlxCamera;

	public static var offsetTesting:Bool = false;

	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;

	public var dialogue:Array<String> = ['dad:blah blah blah', 'bf:coolswag'];
	public var endDialogue:Array<String> = ['dad:blah blah blah', 'bf:coolswag'];

	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;

	var imonbruh:Bool = false; // Super cool code approuved by me -Z

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var daTrain:FlxSprite;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;
	var fastCar1:FlxSprite;
	var fastCar2:FlxSprite;
	var fastCar3:FlxSprite;
	var fastCar4:FlxSprite;
	var fastCar5:FlxSprite;
	var fastCarBoi:FlxSprite;
	var fastCarPizza:FlxSprite;
	var enyojerfan:FlxSprite; // adgskqlgjlmkdfsgj -Z
	var songName:FlxText;

	public static var dadMovementXoffset:Int = 0; // camera mouvement -Z
	public static var dadMovementYoffset:Int = 0;

	public static var bfMovementXoffset:Int = 0;
	public static var bfMovementYoffset:Int = 0;

	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;

	var aaaaaa:FlxSprite;
	var qsdf:FlxSprite;
	var gfscared:FlxSprite;
	var corruptedgf:FlxSprite;
	var thebg:FlxSprite;

	var fc:Bool = true;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();

	var talking:Bool = true;
	public var songScore:Int = 0;
	var songScoreDef:Int = 0;
	var scoreTxt:FlxText;
	var replayTxt:FlxText;
	var ooooeffectlookcoolasfuck:FlxSprite;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;
	public static var repPresses:Int = 0;
	public static var repReleases:Int = 0;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;
	
	// Will fire once to prevent debug spam messages and broken animations
	private var triggeredAlready:Bool = false;
	
	// Will decide if she's even allowed to headbang at all depending on the song
	private var allowedToHeadbang:Bool = false;
	// Per song additive offset
	public static var songOffset:Float = 0;
	// BotPlay text
	private var botPlayState:FlxText;
	// Replay shit
	private var saveNotes:Array<Dynamic> = [];

	public static var highestCombo:Int = 0;

	private var executeModchart = false;

	// API stuff
	
	public function addObject(object:FlxBasic) { add(object); }
	public function removeObject(object:FlxBasic) { remove(object); }


	override public function create()
	{

		#if html5 
		FlxG.switchState(new SongState());
		#end

		FlxG.mouse.visible = false;

		instance = this;

		if (SONG.song.toLowerCase() == 'echo' || SONG.song.toLowerCase() == 'echo-(erect-remix)')
			{
				dad = new Character(100, 100, 'beno2');
				add(dad);
				remove(dad); // no more lag when changing ? -Z
			}
		
		if (SONG.song.toLowerCase() == 'zhugolecturesyouaboutpiracy')
			{
				dad = new Character(100, 100, 'madzhugo');
				add(dad);
				remove(dad); // no more lag when changing ? -Z

				dad = new Character(100, 100, 'glitchzhugo');
				add(dad);
				remove(dad); // EPIC NO LAG !! -Z
			}


		fastCar = new FlxSprite(-1700, 225).loadGraphic(Paths.image('act/cars/fastCarLol1'));
		fastCar.flipX = true;

		fastCar1 = new FlxSprite(-1700, 100).loadGraphic(Paths.image('act/cars/fastCarLol1'));

		fastCar2 = new FlxSprite(-1550, 0).loadGraphic(Paths.image('act/cars/FRENCH'));
		fastCar2.frames = Paths.getSparrowAtlas('act/cars/FRENCH');
		fastCar2.animation.addByPrefix('FRENCH bread', "FRENCH bread", 24);
		fastCar2.animation.play('FRENCH bread');
		fastCar2.setGraphicSize(Std.int(fastCar2.width * 0.9));

		fastCar3 = new FlxSprite(-1550, 0).loadGraphic(Paths.image('act/cars/funnie'));
		fastCar3.frames = Paths.getSparrowAtlas('act/cars/funnie');
		fastCar3.animation.addByPrefix('funnie bruhsoundeffect', "funnie bruhsoundeffect", 24);
		fastCar3.animation.play('funnie bruhsoundeffect');
		fastCar3.setGraphicSize(Std.int(fastCar3.width * 0.9));

		fastCar4 = new FlxSprite(-1550, 0).loadGraphic(Paths.image('act/cars/whoopwhoop'));
		fastCar4.frames = Paths.getSparrowAtlas('act/cars/whoopwhoop');
		fastCar4.animation.addByPrefix('whoopwhoop dapopo', "whoopwhoop dapopo", 24);
		fastCar4.animation.play('whoopwhoop dapopo');
		fastCar4.setGraphicSize(Std.int(fastCar4.width * 0.9));

		fastCar5 = new FlxSprite(-1550, -110).loadGraphic(Paths.image('act/cars/paydayvan'));
		fastCar5.frames = Paths.getSparrowAtlas('act/cars/paydayvan');
		fastCar5.animation.addByPrefix('payday 2 van instance', "payday 2 van instance", 24);
		fastCar5.animation.play('payday 2 van instance');
		fastCar5.setGraphicSize(Std.int(fastCar5.width * 0.9));

		fastCarPizza = new FlxSprite(-1550, 0).loadGraphic(Paths.image('act/cars/Pizzaman'));
		fastCarPizza.frames = Paths.getSparrowAtlas('act/cars/Pizzaman');
		fastCarPizza.animation.addByPrefix('pizza man bike instance', "pizza man bike instance", 5);
		fastCarPizza.animation.play('pizza man bike instance');
		fastCarPizza.setGraphicSize(Std.int(fastCarPizza.width * 0.5));

		fastCarBoi = new FlxSprite(-1550, 225).loadGraphic(Paths.image('act/cars/penguincar'));
		fastCarBoi.frames = Paths.getSparrowAtlas('act/cars/penguincar');
		fastCarBoi.animation.addByPrefix('penguins car instance ', "penguins car instance ", 24);
		fastCarBoi.animation.play('penguins car instance ');
		fastCarBoi.setGraphicSize(Std.int(fastCarBoi.width * 0.3));
		
		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(800);
		
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
		FlxG.save.data.scoreScreen = true; // Fucking code

		if (!isStoryMode)
		{
			sicks = 0;
			bads = 0;
			shits = 0;
			goods = 0;
		}
		misses = 0;

		repPresses = 0;
		repReleases = 0;

		dadMovementXoffset = 0;
		dadMovementYoffset = 0;

		bfMovementXoffset = 0;
		bfMovementYoffset = 0;

		PlayStateChangeables.useDownscroll = FlxG.save.data.downscroll;
		PlayStateChangeables.safeFrames = FlxG.save.data.frames;
		PlayStateChangeables.scrollSpeed = FlxG.save.data.scrollSpeed;
		PlayStateChangeables.botPlay = FlxG.save.data.botplay;


		// pre lowercasing the song name (create)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle': songLowercase = 'dadbattle';
			case 'philly-nice': songLowercase = 'philly';
		}
		
		removedVideo = false;

		#if windows
		executeModchart = FileSystem.exists(Paths.lua(songLowercase  + "/modchart"));
		#end
		#if !cpp
		executeModchart = false; // FORCE disable for non cpp targets
		#end

		trace('Mod chart: ' + executeModchart + " - " + Paths.lua(songLowercase + "/modchart"));

		#if windows
		// Making difficulty text for Discord Rich Presence.
		switch (storyDifficulty)
		{
			case 0:
				storyDifficultyText = "Easy";
			case 1:
				storyDifficultyText = "Normal";
			case 2:
				storyDifficultyText = "Hard";
		}

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'senpai-angry':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end


		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		noteCam = new FlxCamera();
		noteCam.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(noteCam);

		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('training', 'training');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		trace('INFORMATION ABOUT WHAT U PLAYIN WIT:\nFRAMES: ' + PlayStateChangeables.safeFrames + '\nZONE: ' + Conductor.safeZoneOffset + '\nTS: ' + Conductor.timeScale + '\nBotPlay : ' + PlayStateChangeables.botPlay);
	
		//dialogue shit
		switch (songLowercase)
		{
			case 'training':
				dialogue = CoolUtil.coolTextFile(Paths.txt('training/dialogue'));
				endDialogue = CoolUtil.coolTextFile(Paths.txt('training/EndDialogue'));
			case 'nothing-personal':
				dialogue = CoolUtil.coolTextFile(Paths.txt('nothing-personal/dialogue'));
				endDialogue = CoolUtil.coolTextFile(Paths.txt('nothing-personal/EndDialogue'));
			case 'your-choice':
				dialogue = CoolUtil.coolTextFile(Paths.txt('your-choice/dialogue'));
				endDialogue = CoolUtil.coolTextFile(Paths.txt('your-choice/EndDialogue'));
			case 'prodito':
				dialogue = CoolUtil.coolTextFile(Paths.txt('prodito/dialogue'));
			case 'echo':
				dialogue = CoolUtil.coolTextFile(Paths.txt('echo/dialogue'));
			case 'frenzy':
				dialogue = CoolUtil.coolTextFile(Paths.txt('frenzy/dialogue'));
				endDialogue = CoolUtil.coolTextFile(Paths.txt('frenzy/EndDialogue')); // i'm brain -Z also it's fucking 2 am and i love my life Hope you do too out there :D
			case 'exile':
				dialogue = CoolUtil.coolTextFile(Paths.txt('exile/dialogue'));
				endDialogue = CoolUtil.coolTextFile(Paths.txt('exile/EndDialogue'));
		}

		//defaults if no stage was found in chart
		var stageCheck:String = 'stage';
		
		if (SONG.stage == null) {
			switch(storyWeek)
			{
				case 1: stageCheck = 'prologue';
				case 2: if (songLowercase == 'prodito' || songLowercase == 'echo') {stageCheck = 'act';} else if (songLowercase == 'frenzy') {stageCheck = 'act2';}  else if (songLowercase == 'exile') {stageCheck = 'act1';}
				//i should check if its stage (but this is when none is found in chart anyway)
			}
		} else {stageCheck = SONG.stage;}

		switch(stageCheck)
		{
			case 'stage':
				{
						defaultCamZoom = 0.9;
						curStage = 'stage';
						var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
	
						var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
						stageFront.updateHitbox();
						stageFront.antialiasing = true;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);
	
						var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
						stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
						stageCurtains.updateHitbox();
						stageCurtains.antialiasing = true;
						stageCurtains.scrollFactor.set(1.3, 1.3);
						stageCurtains.active = false;
	
						add(stageCurtains);
				}
			case 'prologue':
					{
							defaultCamZoom = 0.8;
							curStage = 'prologue';
							if (!FlxG.save.data.Lesslag)
								{
							var bg:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('prologue/background'));
							bg.antialiasing = true;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
		
							var stageFront:FlxSprite = new FlxSprite(-400, -200).loadGraphic(Paths.image('prologue/ground'));
							//stageFront.setGraphicSizeh=(Std.int(stageFront.width * 1.1));
							stageFront.updateHitbox();
							stageFront.antialiasing = true;
							stageFront.scrollFactor.set(0.9, 0.9);
							stageFront.active = false;
							add(stageFront);
								}
					}
			case 'zhugobg':
					{
							defaultCamZoom = 0.9;
							curStage = 'zhugobg';
							if (!FlxG.save.data.Lesslag)
								{
							var bg:FlxSprite = new FlxSprite(-250, 50).loadGraphic(Paths.image('server room/ZhugoBG'));
							bg.antialiasing = true;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
								}
					}

			case 'act': // stage for prodito / echo -Z
					{
							defaultCamZoom = 0.8;
							curStage = 'act';
							if (!FlxG.save.data.Lesslag)
								{
							var bg:FlxSprite = new FlxSprite(-600, -500).loadGraphic(Paths.image('act/Funny haha sky'));
							bg.setGraphicSize(Std.int(bg.width * 0.9));
							bg.antialiasing = true;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
							
							var stage2:FlxSprite = new FlxSprite(-550, -350).loadGraphic(Paths.image('act/Funny haha sea'));
							stage2.setGraphicSize(Std.int(stage2.width * 0.9));
							stage2.updateHitbox();
							stage2.antialiasing = true;
							stage2.scrollFactor.set(0.9, 0.9);
							stage2.active = false;
							add(stage2);

							var sea:FlxSprite = new FlxSprite(-550, -350);
							sea.frames = Paths.getSparrowAtlas('act/far sea');
							sea.alpha = 0.3;
							sea.animation.addByPrefix('sea', "sea", 1);
							sea.animation.play('sea');
							sea.scrollFactor.set(0.7, 0.7);
							add(sea);

							var sea1:FlxSprite = new FlxSprite(-550, -350);
							sea1.frames = Paths.getSparrowAtlas('act/close sea');
							sea1.alpha = 0.3;
							sea1.animation.addByPrefix('sea', "sea", 5);
							sea1.animation.play('sea');
							sea1.scrollFactor.set(0.7, 0.7);
							add(sea1);

							var sea2:FlxSprite = new FlxSprite(-600, -400);
							sea2.frames = Paths.getSparrowAtlas('act/close sea');
							sea2.alpha = 0.3;
							sea2.animation.addByPrefix('sea', "sea", 5);
							sea2.animation.play('sea');
							sea2.scrollFactor.set(1.1, 1.1);
							add(sea2);

							var stageFront:FlxSprite = new FlxSprite(-550, -500).loadGraphic(Paths.image('act/Funny haha clouds'));
							stageFront.setGraphicSize(Std.int(stageFront.width * 0.9));
							//stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
							stageFront.updateHitbox();
							stageFront.antialiasing = true;
							stageFront.scrollFactor.set(0.9, 0.9);
							stageFront.active = false;
							add(stageFront);

							var alexshadow:FlxSprite = new FlxSprite(-550, -400).loadGraphic(Paths.image('act/Funny haha bridge behind'));
							alexshadow.setGraphicSize(Std.int(alexshadow.width * 0.9));
							alexshadow.updateHitbox();
							alexshadow.antialiasing = true;
							alexshadow.scrollFactor.set(0.9, 0.9);
							alexshadow.active = false;
							add(alexshadow);
							// Stage 3 but MEGAAMONGUS AM I RIGHT AHAH -Z

							if (SONG.song.toLowerCase() == 'prodito')
								{
									var cars:FlxSprite = new FlxSprite(1700, 100).loadGraphic(Paths.image('act/cars/Car block')); // almost forgot the correct path -Z
									cars.setGraphicSize(Std.int(cars.width * 0.9)); 
									cars.updateHitbox();
									cars.antialiasing = true;
									cars.scrollFactor.set(0.9, 0.9);
									cars.active = false;
									add(cars);

									qsdf = new FlxSprite(-420, 0);
									qsdf.frames = Paths.getSparrowAtlas('act/cars/mesaa');
									qsdf.animation.addByPrefix('amongus', 'Tween 2 instance', 24, false);
									qsdf.scrollFactor.set(0.9, 0.9);
									qsdf.antialiasing = true;
									add(qsdf);

									aaaaaa = new FlxSprite(750, 50);
									aaaaaa.frames = Paths.getSparrowAtlas('act/cars/angrysoras');
									aaaaaa.animation.addByPrefix('idle', 'asea car grrr instance', 24, false);
									aaaaaa.animation.addByPrefix('STOPPOSTINGABOUTAMONGUS', 'asea car HEY WHAT THE FUCK MOVE instance', 24, false);
									aaaaaa.scrollFactor.set(0.9, 0.9);
									aaaaaa.antialiasing = true;
									add(aaaaaa);
								}
								if (SONG.song.toLowerCase() == 'echo' || SONG.song.toLowerCase() == 'echo-(erect-remix)')
									{
						add(fastCarPizza); // even if not used in the erect remix :p -Z
						add(fastCar1);
					}
						add(fastCar); 

							var stage4:FlxSprite = new FlxSprite(-550, -250).loadGraphic(Paths.image('act/Haha funny bridge'));
							stage4.setGraphicSize(Std.int(stage4.width * 0.9));
							stage4.updateHitbox();
							stage4.antialiasing = true;
							stage4.scrollFactor.set(0.9, 0.9);
							stage4.active = false;
							add(stage4);	
							
							gfscared = new FlxSprite(1100, 250);
							gfscared.frames = Paths.getSparrowAtlas('characters/Scaredgf','shared');
							gfscared.animation.addByPrefix('idle', 'Scaredgf gfscrd', 24, false);
							gfscared.animation.addByPrefix('idlealt', 'Scaredgf gfvryscrd', 24, false);
							gfscared.antialiasing = true;
							add(gfscared);
								}
					}
					case 'act2':// stage for frenzy / frenzied -Z
					{
							defaultCamZoom = 1.25;
							curStage = 'act2';
							if (!FlxG.save.data.Lesslag)
								{
							var bg:FlxSprite = new FlxSprite(-600, -500).loadGraphic(Paths.image('act/Funny haha sky'));
							bg.setGraphicSize(Std.int(bg.width * 0.9));
							bg.antialiasing = true;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
							
							var stage2:FlxSprite = new FlxSprite(-550, -350).loadGraphic(Paths.image('act/Funny haha sea'));
							stage2.setGraphicSize(Std.int(stage2.width * 0.9));
							stage2.updateHitbox();
							stage2.antialiasing = true;
							stage2.scrollFactor.set(0.9, 0.9);
							stage2.active = false;
							add(stage2);

							var sea:FlxSprite = new FlxSprite(-550, -350);
							sea.frames = Paths.getSparrowAtlas('act/far sea');
							sea.alpha = 0.3;
							sea.animation.addByPrefix('sea', "sea", 1);
							sea.animation.play('sea');
							sea.scrollFactor.set(0.7, 0.7);
							add(sea);

							var sea1:FlxSprite = new FlxSprite(-550, -350);
							sea1.frames = Paths.getSparrowAtlas('act/close sea');
							sea1.alpha = 0.3;
							sea1.animation.addByPrefix('sea', "sea", 5);
							sea1.animation.play('sea');
							sea1.scrollFactor.set(0.7, 0.7);
							add(sea1);

							var sea2:FlxSprite = new FlxSprite(-600, -400);
							sea2.frames = Paths.getSparrowAtlas('act/close sea');
							sea2.alpha = 0.3;
							sea2.animation.addByPrefix('sea', "sea", 5);
							sea2.animation.play('sea');
							sea2.scrollFactor.set(1.1, 1.1);
							add(sea2);

							var stageFront:FlxSprite = new FlxSprite(-550, -500).loadGraphic(Paths.image('act/Funny haha clouds'));
							stageFront.setGraphicSize(Std.int(stageFront.width * 0.9));
							//stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
							stageFront.updateHitbox();
							stageFront.antialiasing = true;
							stageFront.scrollFactor.set(0.9, 0.9);
							stageFront.active = false;
							add(stageFront);

							var alexshadow:FlxSprite = new FlxSprite(-550, -400).loadGraphic(Paths.image('act/Funny haha bridge behind'));
							alexshadow.setGraphicSize(Std.int(alexshadow.width * 0.9));
							alexshadow.updateHitbox();
							alexshadow.antialiasing = true;
							alexshadow.scrollFactor.set(0.9, 0.9);
							alexshadow.active = false;
							add(alexshadow);
							// Stage 3 but Nuuuuuuuuuuuuuuuuu-Z

							add(fastCarBoi);
							add(fastCar5);
							add(fastCar4);
							add(fastCar3);
							add(fastCar2);
							add(fastCar1);
							add(fastCar);

							var stage4:FlxSprite = new FlxSprite(-550, -250).loadGraphic(Paths.image('act/Haha funny bridge'));
							stage4.setGraphicSize(Std.int(stage4.width * 0.9));
							stage4.updateHitbox();
							stage4.antialiasing = true;
							stage4.scrollFactor.set(0.9, 0.9);
							stage4.active = false;
							add(stage4);	

							if (SONG.song.toLowerCase() == 'frenzy')
								{
							gfscared = new FlxSprite(1100, 250);
							gfscared.frames = Paths.getSparrowAtlas('characters/Scaredgf','shared');
							gfscared.animation.addByPrefix('idle', 'Scaredgf gfscrd', 24, false);
							gfscared.animation.addByPrefix('idlealt', 'Scaredgf gfvryscrd', 24, false);
							gfscared.antialiasing = true;
							add(gfscared);	
								}		
							}	
					}
					case 'act1': // stage for exile -Z
					{
							defaultCamZoom = 0.8;
							curStage = 'act1';
							if (!FlxG.save.data.Lesslag)
								{
							var bg:FlxSprite = new FlxSprite(-550, -350).loadGraphic(Paths.image('act/Funny haha dusk sky'));
							bg.setGraphicSize(Std.int(bg.width * 1));
							bg.antialiasing = true;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
							
							var sea:FlxSprite = new FlxSprite(-550, -350);
							sea.frames = Paths.getSparrowAtlas('act/far sea');
							sea.alpha = 0.3;
							sea.animation.addByPrefix('sea', "sea", 1);
							sea.animation.play('sea');
							sea.scrollFactor.set(0.7, 0.7);
							add(sea);

							var sea1:FlxSprite = new FlxSprite(-550, -350);
							sea1.frames = Paths.getSparrowAtlas('act/close sea');
							sea1.alpha = 0.3;
							sea1.animation.addByPrefix('sea', "sea", 5);
							sea1.animation.play('sea');
							sea1.scrollFactor.set(0.7, 0.7);
							add(sea1);

							var alexshadow:FlxSprite = new FlxSprite(-550, -400).loadGraphic(Paths.image('act/Funny haha dusk bridge back'));
							alexshadow.setGraphicSize(Std.int(alexshadow.width * 0.9));
							alexshadow.updateHitbox();
							alexshadow.antialiasing = true;
							alexshadow.scrollFactor.set(0.9, 0.9);
							alexshadow.active = false;
							add(alexshadow);// aka My friend :> -Z
							// Stage 3 

							add(fastCar1);
							add(fastCar);
							
							var stage4:FlxSprite = new FlxSprite(-550, -250).loadGraphic(Paths.image('act/Funny haha dusk bridge'));
							stage4.setGraphicSize(Std.int(stage4.width * 0.9));
							stage4.updateHitbox();
							stage4.antialiasing = true;
							stage4.scrollFactor.set(0.9, 0.9);
							stage4.active = false;
							add(stage4);	
								}
					}
			case 'release': //delete bla bla bla -Z
					{
							defaultCamZoom = 0.9;
							curStage = 'release';
							if (!FlxG.save.data.Lesslag)
								{
							var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('release/garStagebgAlt'));
							bg.antialiasing = true;
							bg.scrollFactor.set(0.7, 0.7);
							bg.active = false;
							add(bg);
	  
							var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('release/garStagealt'));
							bgAlley.antialiasing = true;
							bgAlley.scrollFactor.set(0.9, 0.9);
							bgAlley.active = false;
							add(bgAlley);
	  
							var corpse:FlxSprite = new FlxSprite(-230, 540).loadGraphic(Paths.image('release/gardead'));
							corpse.antialiasing = true;
							corpse.scrollFactor.set(0.9, 0.9);
							corpse.active = false;
							add(corpse);

							var smoker:FlxSprite = new FlxSprite(0, -290);
							smoker.frames = Paths.getSparrowAtlas('release/garSmoke');
							smoker.setGraphicSize(Std.int(smoker.width * 1.7));
							smoker.alpha = 0.3;
							smoker.animation.addByPrefix('garsmoke', "smokey", 13);
							smoker.animation.play('garsmoke');
							smoker.scrollFactor.set(0.7, 0.7);
							add(smoker);
								}
					  }
					  case 'nothing': //litteraly nothing -Z
					  {
							  defaultCamZoom = 0.9;
							  curStage = 'nothing';

							  thebg = new FlxSprite(-300, 50);
							  thebg.frames = Paths.getSparrowAtlas('server room/Serverroom','shared');
							  thebg.animation.addByPrefix('BreakingDown1', 'Bgglitch1', 12, false);
							  thebg.animation.addByPrefix('BreakingDown2', 'Bgglitch2', 8, false);
							  thebg.animation.addByPrefix('BreakingDown3', 'Bgglitch3', 8, false);
							  thebg.antialiasing = true;
							  add(thebg);

							  corruptedgf = new FlxSprite(900, 450);
							  corruptedgf.frames = Paths.getSparrowAtlas('characters/GfdeadZhugo','shared');
							  corruptedgf.animation.addByPrefix('idle', 'GF Dancing Beat', 24, false);
							  corruptedgf.antialiasing = true;
							  add(corruptedgf);
					  }
			default:
			{
					defaultCamZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;

					add(stageCurtains);
			}
		}

		//defaults if no gf was found in chart
		var gfCheck:String = 'gf';
		
		if (SONG.gfVersion == null) {
			switch(storyWeek)
			{
				case 4: gfCheck = 'gf-car';
				case 5: gfCheck = 'gf-christmas';
				case 6: gfCheck = 'gf-pixel';
				case 7: gfCheck = 'gfprologue';
				case 8: gfCheck = 'gfpromise';
				case 9: gfCheck = 'gfexile';
				case 10: gfCheck = 'gfChristmasprologue';
				case 11: gfCheck = 'gfChristmasact';
				case 12: gfCheck = 'gfrelease';
				// This is not how you do it stupid, but whatever :smug: -Z
			}
		} else {gfCheck = SONG.gfVersion;}

		var curGf:String = '';
		switch (gfCheck)
		{
			case 'gf-car':
				curGf = 'gf-car';
			case 'gf-christmas':
				curGf = 'gf-christmas';
			case 'gf-pixel':
				curGf = 'gf-pixel';
			case 'gfprologue':
				curGf = 'gfprologue';
			case 'gfpromise':
				curGf = 'gfpromise';
				case 'gfexile':
					curGf = 'gfexile';
					case 'gfChristmasprologue':
						curGf = 'gfChristmasprologue';
						case 'gfChristmasact':
							curGf = 'gfChristmasact';
							case 'gfrelease':
							curGf = 'gfrelease';
			default:
				curGf = 'gf';
		}

		gf = new Character(400, 130, curGf);
		gf.scrollFactor.set(0.95, 0.95);

		dad = new Character(100, 100, SONG.player2);

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}
				case 'gfpromise': // kill me, i was trying to find there was 2 gf on training and i legit forgot about this code -Z
					dad.setPosition(gf.x, gf.y);
					gf.visible = false;
					if (isStoryMode)
					{
						camPos.x += 600;
						tweenCamIn();
					}

			case "spooky":
				dad.y += 200;
			case "monster":
				dad.y += 100;
			case 'monster-christmas':
				dad.y += 130;
			case 'dad':
				camPos.x += 400;
			case 'beno1' | 'beno2':
				dad.setGraphicSize(Std.int(dad.width * 1.2));
				dad.y += 50;
				dad.x += 25; // or else we see the black on the left smh BRUUH -Z
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y - 100);
			case 'beno3' | 'beno3blood':
				dad.setGraphicSize(Std.int(dad.width * 0.6));
				dad.y += 100;
				dad.x += 100;
			case 'beno4':
				dad.setGraphicSize(Std.int(dad.width * 0.8));
				dad.y += 100;
			case 'beno4release':
				dad.setGraphicSize(Std.int(dad.width * 0.8));
				dad.y -= 50;
			case 'zhugo' | 'madzhugo' | 'glitchzhugo':
			dad.y += 100;
			dad.x += 20;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'senpai':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpai-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'jix':
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y - 200);
		}


		
		boyfriend = new Boyfriend(770, 450, SONG.player1);


		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'limo':
				boyfriend.y -= 220;
				boyfriend.x += 260;
			case 'mall':
				boyfriend.x += 200;

			case 'mallEvil':
				boyfriend.x += 320;
				dad.y -= 80;
			case 'school':
				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'schoolEvil':
				if(FlxG.save.data.distractions){
				// trailArea.scrollFactor.set();
				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);
				}


				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'nothing':
				gf.y += 10000; // YEET ! -Z
				boyfriend.y += 1000;
			case 'prologue':
				boyfriend.x += 30;
				boyfriend.y += 60;
				gf.x += 0;
				gf.y += 0;
				camPos.set(boyfriend.getGraphicMidpoint().x - 300, boyfriend.getGraphicMidpoint().y - 200);
			case 'act':
				dad.x -= 150;
				dad.y -= 100;
				boyfriend.y += 50;
				resetFastCar();
				add(fastCar);
				resetFastCar1();
				add(fastCar1);
				resetFastCarPizza();
				add(fastCarPizza);
				camPos.set(boyfriend.getGraphicMidpoint().x - 300, boyfriend.getGraphicMidpoint().y - 200);
			case 'act2':
				dad.x += 100;
				boyfriend.x += 25;
				dad.y -= 100;
				boyfriend.y += 50;
				resetFastCar();
				add(fastCar);
				resetFastCar1();
				add(fastCar1);
				resetFastCar2();
				add(fastCar2);
				resetFastCar3();
				add(fastCar3);
				resetFastCar4();
				add(fastCar4);
				resetFastCar5();
				add(fastCar5);
				resetFastCarBoi();
				add(fastCarBoi);
			case 'act1':
				dad.x -= 150;
				dad.y -= 100;
				boyfriend.y += 50;
				resetFastCar();
				add(fastCar);
				resetFastCar1();
				add(fastCar1);
				camPos.set(boyfriend.getGraphicMidpoint().x - 300, boyfriend.getGraphicMidpoint().y - 200);
			case 'release':
				camPos.set(boyfriend.getGraphicMidpoint().x - 300, boyfriend.getGraphicMidpoint().y - 200);
				boyfriend.y -= 80;
				boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.7));
			case 'zhugobg': // CHANGE WHEN THE CAMERA SPAWN NOT WHEN IT4S PLAYING !! -Z
				dad.x += 50; 
				camPos.set(dad.getGraphicMidpoint().x + 250, dad.getGraphicMidpoint().y + 100);
			case 'nothing':
				boyfriend.y -= 50;
				camPos.set(dad.getGraphicMidpoint().x + 400, dad.getGraphicMidpoint().y + 300);
		}


		// Shitty layering but whatev it works LOL
		//if (curStage == 'limo')
		//	add(limo);

		if (!FlxG.save.data.Character)
			{
		add(gf);
		add(boyfriend);
		add(dad);
			}
	
		if (SONG.song.toLowerCase()=='training' || SONG.song.toLowerCase()=='training oldinst' && !FlxG.save.data.Character) // don't ask why lol -Z
			{
			remove(boyfriend);
			remove(dad);
			add(dad);
			add(boyfriend);
			}
			

		if (curStage == 'release')
			{
				var smoke:FlxSprite = new FlxSprite(0, 0);
				smoke.frames = Paths.getSparrowAtlas('release/garSmoke');
				smoke.setGraphicSize(Std.int(smoke.width * 1.6));
				smoke.animation.addByPrefix('garsmoke', "smokey", 15);
				smoke.animation.play('garsmoke');
				smoke.scrollFactor.set(1.1, 1.1);
				add(smoke);
			}
		if (loadRep)
		{
			FlxG.watch.addQuick('rep rpesses',repPresses);
			FlxG.watch.addQuick('rep releases',repReleases);
			// FlxG.watch.addQuick('Queued',inputsQueued);

			PlayStateChangeables.useDownscroll = rep.replay.isDownscroll;
			PlayStateChangeables.safeFrames = rep.replay.sf;
			PlayStateChangeables.botPlay = true;
		}

		trace('uh ' + PlayStateChangeables.safeFrames);

		trace("SF CALC: " + Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

		doof = new DialogueBox(false, dialogue);
		doof.scrollFactor.set();

		doofend = new DialogueBox(false, endDialogue);
		doofend.scrollFactor.set();
		doofend.finishThing = endSong;

		Conductor.songPosition = -5000;
		
		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		
		if (PlayStateChangeables.useDownscroll)
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<FlxSprite>();
		cpuStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		if (SONG.song == null)
			trace('song is null???');
		else
			trace('song looks gucci');

		generateSong(SONG.song);

		trace('generated');

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		if (FlxG.save.data.songPosition) // I dont wanna talk about this code :(
			{
				songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
				if (PlayStateChangeables.useDownscroll)
					songPosBG.y = FlxG.height * 0.9 + 45; 
				songPosBG.screenCenter(X);
				songPosBG.scrollFactor.set();
				add(songPosBG);
				
				songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
					'songPositionBar', 0, 90000);
				songPosBar.scrollFactor.set();
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
				add(songPosBar);
	
				var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
				if (PlayStateChangeables.useDownscroll)
					songName.y -= 3;
				songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				songName.scrollFactor.set();
				add(songName);

				songName.cameras = [camHUD];
			}

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		if (PlayStateChangeables.useDownscroll)
			healthBarBG.y = 50;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);
		
		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF1350DE);
		// healthBar
		

	if(SONG.song.toLowerCase()=='release')
			{
				healthBar.createFilledBar(0xFF1350DE, 0xFFEE82EE);
			}

			if(SONG.song.toLowerCase()=='nothing personal' || SONG.song.toLowerCase()=='your choice')
				{
				healthBar.createFilledBar(0xFF1FFF00, 0xFF1350DE);
				}

		if(SONG.song.toLowerCase()=='prodito' || SONG.song.toLowerCase()=='echo' || SONG.song.toLowerCase()=='echo-(erect-remix)' || SONG.song.toLowerCase()=='frenzy' || SONG.song.toLowerCase() == 'frenzy x megalovania' || SONG.song.toLowerCase()=='exile' || SONG.song.toLowerCase()=='frenzied')
			{
				healthBar.createFilledBar(0xFF1350DE, 0xFF66FF33);
			}
			// healthBar
			add(healthBar);
		
			// I know the code above is a bit bad, but who cares it work !!! -Z
			// Ps : Don't forget that the colors value always get the "0xFF" because the color code, because i forget it twice and ughh -Z





		scoreTxt = new FlxText(FlxG.width / 2 - 235, healthBarBG.y + 50, 0, "", 20);

		scoreTxt.screenCenter(X);

		originalX = scoreTxt.x;


		scoreTxt.scrollFactor.set();
		
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);

		add(scoreTxt);

		replayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "REPLAY", 20);
		replayTxt.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		replayTxt.borderSize = 4;
		replayTxt.borderQuality = 2;
		replayTxt.scrollFactor.set();
		if (loadRep)
		{
			add(replayTxt);
		}
		// Literally copy-paste of the above, fu
		botPlayState = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "BOTPLAY", 20);
		botPlayState.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		botPlayState.scrollFactor.set();
		botPlayState.borderSize = 4;
		botPlayState.borderQuality = 2;
		if(PlayStateChangeables.botPlay && !loadRep) add(botPlayState);

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		if (PlayState.SONG.song.toLowerCase() == 'frenzy' || SONG.song.toLowerCase() == 'frenzy x megalovania')
			{
				ooooeffectlookcoolasfuck = new FlxSprite(-420, -285);
				ooooeffectlookcoolasfuck.frames = Paths.getSparrowAtlas('act/Effect');
				ooooeffectlookcoolasfuck.setGraphicSize(Std.int(ooooeffectlookcoolasfuck.width * 0.62));
				ooooeffectlookcoolasfuck.animation.addByPrefix('Effect', "Effect", 24, true);
				ooooeffectlookcoolasfuck.antialiasing = true;
				add(ooooeffectlookcoolasfuck);
				ooooeffectlookcoolasfuck.visible = false;
				ooooeffectlookcoolasfuck.cameras = [camHUD];
			}// This is very bad but it cause no lag so i'm happy about it. -Z
			

		scoreTxt.cameras = [camHUD];
		notes.cameras = [noteCam]; // on a other cam hud BECAUSE OF THE SHAKE, don't want the whole screen shaking -Z
		strumLineNotes.cameras = [noteCam]; // ^ -Z
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		doof.cameras = [camHUD];
		doofend.cameras = [camHUD]; // It fix shit :D -Z, Wait fr, like the dialogue broke and that fix shit ? talk about a bad coder that still is capable of doing fonctionning code -Z

		if (FlxG.save.data.songPosition)
		{
			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
		}
		if (loadRep)
			replayTxt.cameras = [camHUD];

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;
		
		trace('starting');

		if (isStoryMode)
		{
			switch (StringTools.replace(curSong," ", "-").toLowerCase())
			{
				case 'nothing-personal':
					schoolIntro(doof);
				case 'your-choice':
					schoolIntro(doof);
				case 'prodito':
					schoolIntro(doof);
				case 'echo':
					schoolIntro(doof);
				case 'frenzy':
					schoolIntro(doof);
				case 'exile':
					if (storyDifficulty == 1) // This is very bad, but too bad that how the endings work..
					{
						camFollow.x -= 99999; // Weeeeeee fuck yeahhhhh -Z
						FlxG.switchState(new NormalEnding());	
					}
					if (storyDifficulty == 0)
						{
							camFollow.x -= 99999; // Weeeeeee fuck yeahhhhh -Z
							FlxG.switchState(new EasyEnding());	
						}
					else if (storyDifficulty == 2) // Fuck you and fix the bug that, uhh.. make the dialogue appear before sending into the other state -Z
					schoolIntro(doof);
				case 'training':
					schoolIntro(doof);
				default:
					startCountdown();
			}
		}
		else
		{
			switch (curSong.toLowerCase())
			{
				default:
					startCountdown();
				case 'frenzy' | 'frenzy x megalovania': // Congradulation this is bad, oh wait no that actually smart, bravo i figure that out -Z
						{
							playfrenzy();
							}
			}
		}

		if (!loadRep)
			rep = new Replay("na");

		super.create();
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		new FlxTimer().start(0, function(tmr:FlxTimer)
		{
			
				if (dialogueBox != null)
				{
					inCutscene = true; // That the most NONE complicated dialogue system i ever done, Lmao jk i just deleted stuff and it still work -Z

							add(dialogueBox);

				}
				else
					startCountdown();
				
			});
		}





	function playfrenzy():Void
		{
			var antiidle:FlxSprite = new FlxSprite().makeGraphic(Std.int(FlxG.width * 10), Std.int(FlxG.height * 10), FlxColor.BLACK); // not showing the idle before the knife animation -Z
			add(antiidle);
			new FlxTimer().start(0, function(tmr:FlxTimer) // delay audio for bad pc, like mine lmao -Z
				{
			remove(antiidle);
			FlxG.sound.play(Paths.sound('beno_specialknife'));
			dad.playAnim('breakmic'); // does the last frame cut ? -Z
		
			inCutscene = false;
			
			generateStaticArrows(0); // Generate arrow for fast gameplay without the countdown.. It work bruh -Z
			generateStaticArrows(1);

			startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer) // I need this to make them idle bruh, stupid -Z
				{
					 //
				}, 5);

			#if windows // added for modchart support on frenzy -Z
			// pre lowercasing the song name (startCountdown)
			var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
			switch (songLowercase) {
				case 'dad-battle': songLowercase = 'dadbattle';
				case 'philly-nice': songLowercase = 'philly';
			}
			if (executeModchart)
			{
				luaModchart = ModchartState.createModchartState();
				luaModchart.executeState('start',[songLowercase]);
			}
			#end

			
			Conductor.songPosition = 0;
			Conductor.songPosition -= Conductor.crochet * 0.25; // paiinnnnn timinnnggg slkjfdhglkjshflkvnskldfbnlk -Z
			new FlxTimer().start(2, function(tmr:FlxTimer) // should i delay by 2.6 instead of 2 for the animation ? -Z
				{
					startedCountdown = true;
					startSong();
			});
			new FlxTimer().start(2.6, function(tmr:FlxTimer)
			{
				dad.dance();
				gf.dance();
				boyfriend.playAnim('idle'); // i know i can use "boyfriend.dance();", just i love how it can still broke if i change it bruh -Z
			});
		});
		}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	var luaWiggles:Array<WiggleEffect> = [];

	#if windows
	public static var luaModchart:ModchartState = null;
	#end

	function startCountdown():Void
	{
		inCutscene = false;

		generateStaticArrows(0);
		generateStaticArrows(1);


		#if windows
		// pre lowercasing the song name (startCountdown)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle': songLowercase = 'dadbattle';
			case 'philly-nice': songLowercase = 'philly';
		}
		if (executeModchart)
		{
			luaModchart = ModchartState.createModchartState();
			luaModchart.executeState('start',[songLowercase]);
		}
		#end

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();
			boyfriend.playAnim('idle');

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);
			introAssets.set('schoolEvil', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}
				
			switch (swagCounter)
			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school'))
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;


	var songStarted = false;

	function startSong():Void
	{
		startingSong = false;
		songStarted = true;
		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
		{
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		}

		FlxG.sound.music.onComplete = endSong;
		vocals.play();

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (FlxG.save.data.songPosition)
		{
			remove(songPosBG);
			remove(songPosBar);
			remove(songName);

			songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
			if (PlayStateChangeables.useDownscroll)
				songPosBG.y = FlxG.height * 0.9 + 45; 
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);

			songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
				'songPositionBar', 0, songLength - 1000);
			songPosBar.numDivisions = 1000;
			songPosBar.scrollFactor.set();
			songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
			add(songPosBar);

			var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
			if (PlayStateChangeables.useDownscroll)
				songName.y -= 3;
			songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			songName.scrollFactor.set();
			add(songName);

			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
			songName.cameras = [camHUD];
		}
		
		// Song check real quick
		switch(curSong)
		{
			case 'Bopeebo' | 'Philly Nice' | 'Blammed' | 'Cocoa' | 'Eggnog': allowedToHeadbang = true;
			default: allowedToHeadbang = false;
		}

		if (useVideo)
			GlobalVideo.get().resume();
		
		#if windows
		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		trace('loaded vocals');

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		// Per song offset check
		#if windows
			// pre lowercasing the song name (generateSong)
			var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
				switch (songLowercase) {
					case 'dad-battle': songLowercase = 'dadbattle';
					case 'philly-nice': songLowercase = 'philly';
				}

			var songPath = 'assets/data/' + songLowercase + '/';
			
			for(file in sys.FileSystem.readDirectory(songPath))
			{
				var path = haxe.io.Path.join([songPath, file]);
				if(!sys.FileSystem.isDirectory(path))
				{
					if(path.endsWith('.offset'))
					{
						trace('Found offset file: ' + path);
						songOffset = Std.parseFloat(file.substring(0, file.indexOf('.off')));
						break;
					}else {
						trace('Offset file not found. Creating one @: ' + songPath);
						sys.io.File.saveContent(songPath + songOffset + '.offset', '');
					}
				}
			}
		#end
		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
			{
				var coolSection:Int = Std.int(section.lengthInSteps / 4);
	
				for (songNotes in section.sectionNotes)
				{
					var daStrumTime:Float = Math.round(songNotes[0]) + FlxG.save.data.offset + songOffset; // changed for the charting WOOO -Z
					if (daStrumTime < 0)
						daStrumTime = 0;
					var daNoteData:Int = Std.int(songNotes[1] % 4);
					var daType:String = songNotes[4];
	
					var gottaHitNote:Bool = section.mustHitSection;
	
					if (songNotes[1] > 3)
					{
						gottaHitNote = !section.mustHitSection;
					}
	
					var oldNote:Note;
					if (unspawnNotes.length > 0)
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
					else
						oldNote = null;
	
					var swagNote:Note;
	
					if (gottaHitNote)
					{
						swagNote = new Note(daStrumTime, daNoteData, oldNote, false, boyfriend.noteSkin, daType);
					}
					else
					{
						swagNote = new Note(daStrumTime, daNoteData, oldNote, false, dad.noteSkin, daType);
					}
					swagNote.sustainLength = songNotes[2];
					swagNote.scrollFactor.set(0, 0);
	
					var susLength:Float = swagNote.sustainLength;
	
					susLength = susLength / Conductor.stepCrochet;
					unspawnNotes.push(swagNote);
	
					for (susNote in 0...Math.floor(susLength))
					{
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
	
						var sustainNote:Note;
	
						if (gottaHitNote)
						{
							sustainNote = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, boyfriend.noteSkin, daType);
						}
						else
						{
							sustainNote = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, dad.noteSkin, daType);
						}
						sustainNote.scrollFactor.set();
						unspawnNotes.push(sustainNote);
	
						sustainNote.mustPress = gottaHitNote;
	
						if (sustainNote.mustPress)
						{
							sustainNote.x += FlxG.width / 2; // general offset
						}
					}
	
					swagNote.mustPress = gottaHitNote;
	
					if (swagNote.mustPress)
					{
						swagNote.x += FlxG.width / 2; // general offset
					}
					else
					{
					}
				}
				daBeats += 1;
			}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	private function generateStaticArrows(player:Int):Void
		{
			for (i in 0...4)
			{
				// FlxG.log.add(i);
				var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);
	
				//defaults if no noteStyle was found in chart
				var noteTypeCheck:String = 'normal';
			
				if (SONG.noteStyle == null) {
					switch(storyWeek) {case 6: noteTypeCheck = 'pixel';}
				} else {noteTypeCheck = SONG.noteStyle;}
	
				switch (noteTypeCheck)
				{
					case 'pixel':
						babyArrow.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
						babyArrow.animation.add('green', [6]);
						babyArrow.animation.add('red', [7]);
						babyArrow.animation.add('blue', [5]);
						babyArrow.animation.add('purplel', [4]);
	
						babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom));
						babyArrow.updateHitbox();
						babyArrow.antialiasing = false;
	
						switch (Math.abs(i))
						{
							case 2:
								babyArrow.x += Note.swagWidth * 2;
								babyArrow.animation.add('static', [2]);
								babyArrow.animation.add('pressed', [6, 10], 12, false);
								babyArrow.animation.add('confirm', [14, 18], 12, false);
							case 3:
								babyArrow.x += Note.swagWidth * 3;
								babyArrow.animation.add('static', [3]);
								babyArrow.animation.add('pressed', [7, 11], 12, false);
								babyArrow.animation.add('confirm', [15, 19], 24, false);
							case 1:
								babyArrow.x += Note.swagWidth * 1;
								babyArrow.animation.add('static', [1]);
								babyArrow.animation.add('pressed', [5, 9], 12, false);
								babyArrow.animation.add('confirm', [13, 17], 24, false);
							case 0:
								babyArrow.x += Note.swagWidth * 0;
								babyArrow.animation.add('static', [0]);
								babyArrow.animation.add('pressed', [4, 8], 12, false);
								babyArrow.animation.add('confirm', [12, 16], 24, false);
						}
					
						case 'normal':
							if (player == 0)
								babyArrow.frames = Paths.getSparrowAtlas('notes/' + dad.noteSkin, 'shared');
	
							if (player == 1)
								babyArrow.frames = Paths.getSparrowAtlas('notes/' + boyfriend.noteSkin, 'shared');
	
							babyArrow.animation.addByPrefix('green', 'arrowUP');
							babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
							babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
							babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
			
							babyArrow.antialiasing = true;
							babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
			
							switch (Math.abs(i))
							{
								case 0:
									babyArrow.x += Note.swagWidth * 0;
									babyArrow.animation.addByPrefix('static', 'arrowLEFT');
									babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
								case 1:
									babyArrow.x += Note.swagWidth * 1;
									babyArrow.animation.addByPrefix('static', 'arrowDOWN');
									babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
								case 2:
									babyArrow.x += Note.swagWidth * 2;
									babyArrow.animation.addByPrefix('static', 'arrowUP');
									babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
								case 3:
									babyArrow.x += Note.swagWidth * 3;
									babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
									babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
								}
		
						default:
							babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
							babyArrow.animation.addByPrefix('green', 'arrowUP');
							babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
							babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
							babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
		
							babyArrow.antialiasing = true;
							babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
		
							switch (Math.abs(i))
							{
								case 0:
									babyArrow.x += Note.swagWidth * 0;
									babyArrow.animation.addByPrefix('static', 'arrowLEFT');
									babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
								case 1:
									babyArrow.x += Note.swagWidth * 1;
									babyArrow.animation.addByPrefix('static', 'arrowDOWN');
									babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
								case 2:
									babyArrow.x += Note.swagWidth * 2;
									babyArrow.animation.addByPrefix('static', 'arrowUP');
									babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
								case 3:
									babyArrow.x += Note.swagWidth * 3;
									babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
									babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
							}
				}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}

			babyArrow.ID = i;

			switch (player)
			{
				case 0:
					cpuStrums.add(babyArrow);
					babyArrow.x -= 50;
				case 1:
					playerStrums.add(babyArrow);
					babyArrow.x += 50;
			}

			babyArrow.animation.play('static');
			babyArrow.x += 100;
			babyArrow.x += ((FlxG.width / 2) * player);
			

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			#if windows
			DiscordClient.changePresence("PAUSED on " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end
			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if windows
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses, iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), iconRPC);
			}
			#end
		}

		super.closeSubState();
	}
	

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if windows
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;
	var nps:Int = 0;
	var maxNPS:Int = 0;

	public static var songRate = 1.5;

	public var stopUpdate = false;
	public var removedVideo = false;

	var bothPlaying:Bool;
	var playerOnePlaying:Bool;
	var playerTwoPlaying:Bool;

	override public function update(elapsed:Float)
	{
		#if !debug
		perfectMode = false;
		#end

		if (curSong.toLowerCase() == 'frenzy')
			{
		doof.finishThing = playfrenzy; // Thanks 52, You're awesome :D -Z
		}
		else
		{
		doof.finishThing = startCountdown;
		}

					if (playerOnePlaying && playerTwoPlaying == true) //not duet
						bothPlaying = true;
					else
						bothPlaying = false;
			
					if (!boyfriend.animation.curAnim.name.startsWith('sing')) //isnt singing
						playerOnePlaying = false;
			
					if (!dad.animation.curAnim.name.startsWith('sing')) //isnt singing
						playerTwoPlaying = false;	

		if (PlayStateChangeables.botPlay && FlxG.keys.justPressed.ONE)
			camHUD.visible = !camHUD.visible;


		if (useVideo && GlobalVideo.get() != null && !stopUpdate)
			{		
				if (GlobalVideo.get().ended && !removedVideo)
				{
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			}


		
		#if windows
		if (executeModchart && luaModchart != null && songStarted)
		{
			luaModchart.setVar('songPos',Conductor.songPosition);
			luaModchart.setVar('hudZoom', camHUD.zoom);
			luaModchart.setVar('cameraZoom',FlxG.camera.zoom);
			luaModchart.executeState('update', [elapsed]);

			for (i in luaWiggles)
			{
				trace('wiggle le gaming');
				i.update(elapsed);
			}

			/*for (i in 0...strumLineNotes.length) {
				var member = strumLineNotes.members[i];
				member.x = luaModchart.getVar("strum" + i + "X", "float");
				member.y = luaModchart.getVar("strum" + i + "Y", "float");
				member.angle = luaModchart.getVar("strum" + i + "Angle", "float");
			}*/

			FlxG.camera.angle = luaModchart.getVar('cameraAngle', 'float');
			camHUD.angle = luaModchart.getVar('camHudAngle','float');

			if (luaModchart.getVar("showOnlyStrums",'bool'))
			{
				healthBarBG.visible = false;			
				healthBar.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
				scoreTxt.visible = false;
			}
			else
			{
				healthBarBG.visible = true;
				healthBar.visible = true;
				iconP1.visible = true;
				iconP2.visible = true;
				scoreTxt.visible = true;
			}

			var p1 = luaModchart.getVar("strumLine1Visible",'bool');
			var p2 = luaModchart.getVar("strumLine2Visible",'bool');

			for (i in 0...4)
			{
				strumLineNotes.members[i].visible = p1;
				if (i <= playerStrums.length)
					playerStrums.members[i].visible = p2;
			}
		}

		#end

		// reverse iterate to remove oldest notes first and not invalidate the iteration
		// stop iteration as soon as a note is not removed
		// all notes should be kept in the correct order and this is optimal, safe to do every frame/update
		{
			var balls = notesHitArray.length-1;
			while (balls >= 0)
			{
				var cock:Date = notesHitArray[balls];
				if (cock != null && cock.getTime() + 1000 < Date.now().getTime())
					notesHitArray.remove(cock);
				else
					balls = 0;
				balls--;
			}
			nps = notesHitArray.length;
			if (nps > maxNPS)
				maxNPS = nps;
		}

		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		switch (curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
				// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
		}

		super.update(elapsed);

		scoreTxt.text = Ratings.CalculateRanking(songScore,songScoreDef,nps,maxNPS,accuracy);

		var lengthInPx = scoreTxt.textField.length * scoreTxt.frameHeight; // bad way but does more or less a better job

		scoreTxt.x = (originalX - (lengthInPx / 2)) + 250;

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			// This is a nice easter egg, Now there a lot more of them :D -Z
			if (FlxG.random.bool(0.1))
			{
				trace('GITAROO MAN EASTER EGG');
				FlxG.switchState(new GitarooPause());
			}
			else
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			if (curSong == 'spaghetticode'){
				if (!startTimer.finished) // to stop notes killing you if you switch state, Why kade didn't think about this before ? -Z
					startTimer.active = false;
			PlayState.SONG = Song.loadFromJson('zhugolecturesyouaboutpiracy-hard', 'zhugolecturesyouaboutpiracy');
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 2;
			PlayState.storyWeek = 1;
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			LoadingState.loadAndSwitchState(new PlayState());
			}
			else {
			if (!startTimer.finished) // to stop notes killing you if you switch state, Why kade didn't think about this before ? -Z
				{
					startTimer.active = false;
				}

			if (useVideo)
				{
					GlobalVideo.get().stop();
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			#if windows
			DiscordClient.changePresence("Chart Editor", null, null, true);
			#end
			FlxG.switchState(new ChartingState());
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
			}
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(iconP2.width, 150, 0.25 / ((SONG.bpm / 0.65) / 60)))); // thanks 52 :D -Z
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(iconP2.width, 150, 0.25 / ((SONG.bpm / 0.65) / 60)))); // thanks 52 :D -Z

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 2) // This code is Ugghhh for HealthIcon.hx but eyahh it work and i can figure out stuff so lets go, agreed by me -Z
			health = 2;
		if (healthBar.percent < 30)
			iconP1.animation.curAnim.curFrame = 1;
		else if (healthBar.percent > 70)
			iconP1.animation.curAnim.curFrame = 2; 
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 70)
			iconP2.animation.curAnim.curFrame = 1;
		else if (healthBar.percent < 30)
			iconP2.animation.curAnim.curFrame = 2;
		else
			iconP2.animation.curAnim.curFrame = 0;

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		#if debug
		if (FlxG.keys.justPressed.EIGHT)
		{
			if (useVideo)
				{
					GlobalVideo.get().stop();
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}

			FlxG.switchState(new AnimationDebug(SONG.player2));
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		if (FlxG.keys.justPressed.ZERO)
		{
			FlxG.switchState(new AnimationDebug(SONG.player1));
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		#end

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;
			/*@:privateAccess
			{
				FlxG.sound.music._channel.
			}*/
			songPositionBar = Conductor.songPosition;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			// Make sure Girlfriend cheers only for certain songs
			if(allowedToHeadbang)
			{
				// Don't animate GF if something else is already animating her (eg. train passing)
				if(gf.animation.curAnim.name == 'danceLeft' || gf.animation.curAnim.name == 'danceRight' || gf.animation.curAnim.name == 'idle')
				{
					// Per song treatment since some songs will only have the 'Hey' at certain times
					switch(curSong)
					{
						case 'Philly Nice':
						{
							// General duration of the song
							if(curBeat < 250)
							{
								// Beats to skip or to stop GF from cheering
								if(curBeat != 184 && curBeat != 216)
								{
									if(curBeat % 16 == 8)
									{
										// Just a garantee that it'll trigger just once
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Bopeebo':
						{
							// Where it starts || where it ends
							if(curBeat > 5 && curBeat < 130)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
						case 'Blammed':
						{
							if(curBeat > 30 && curBeat < 190)
							{
								if(curBeat < 90 || curBeat > 128)
								{
									if(curBeat % 4 == 2)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Cocoa':
						{
							if(curBeat < 170)
							{
								if(curBeat < 65 || curBeat > 130 && curBeat < 145)
								{
									if(curBeat % 16 == 15)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Eggnog':
						{
							if(curBeat > 10 && curBeat != 111 && curBeat < 220)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
					}
				}
			}
			
			#if windows
			if (luaModchart != null)
				luaModchart.setVar("mustHit",PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			#end

			if (!PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				camFollow.setPosition(dad.getMidpoint().x + 150 + dadMovementXoffset, dad.getMidpoint().y - 100 + dadMovementYoffset);
				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerTwoTurn', []);
				#end
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);
				// LUCKY CODE ?! -Z

				switch (dad.curCharacter)
				{
					case 'jix':
						camFollow.y = dad.getMidpoint().y - 200  + dadMovementYoffset;
					case 'beno2' | 'beno1':
						camFollow.y = dad.getMidpoint().y - 100 + dadMovementYoffset;
					case 'zhugo' | 'madzhugo' | 'glitchzhugo':
						camFollow.y = dad.getMidpoint().y + 50 + dadMovementYoffset; // I4M IDIOT i forgot the camera moment BRUH -Z

				}

				if (dad.curCharacter == 'mom')
					vocals.volume = 1;
			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				camFollow.setPosition(boyfriend.getMidpoint().x - 100 + bfMovementXoffset, boyfriend.getMidpoint().y - 100 + bfMovementYoffset);

				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerOneTurn', []);
				#end

				switch (curStage)
				{
					// e -Z
				}
			}
		}

		if (boyfriend.animation.curAnim.name.startsWith('idle')) 
		{
			bfMovementYoffset = 0;
			bfMovementXoffset = 0;
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
			noteCam.zoom = FlxMath.lerp(1, noteCam.zoom, 0.95);
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
				case 163:
					// FlxG.sound.music.stop();
					// FlxG.switchState(new TitleState());
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
					// FlxG.sound.music.stop();
					// FlxG.switchState(new PlayState());
			}
		}

		if (health <= 0)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			#if windows
			// Game Over doesn't get his own variable because it's only used here
			DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}
 		if (FlxG.save.data.resetButton)
		{
			if(FlxG.keys.justPressed.R)
				{
					boyfriend.stunned = true;

					persistentUpdate = false;
					persistentDraw = false;
					paused = true;
		
					vocals.stop();
					FlxG.sound.music.stop();
		
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		
					#if windows
					// Game Over doesn't get his own variable because it's only used here
					DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
					#end
		
					// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				}
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 3500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (dad.animation.curAnim.name.startsWith('idle')) 
		{
			dadMovementYoffset = 0;
			dadMovementXoffset = 0;
		}

		if (generatedMusic)
			{
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
				var stepHeight = (0.45 * Conductor.stepCrochet * FlxMath.roundDecimal(PlayState.SONG.speed, 2));

				notes.forEachAlive(function(daNote:Note)
				{	

					// instead of doing stupid y > FlxG.height
					// we be men and actually calculate the time :)
					if (daNote.tooLate)
					{
						daNote.active = false;
						daNote.visible = false;
					}
					else
					{
						daNote.visible = true;
						daNote.active = true;
					}

					if (PlayStateChangeables.useDownscroll) // THANKS TO 52#9242 how did the "MythsList Engine" for this code !!!!!!!!! -Z
						{
							if (daNote.mustPress)
								daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed, 2));
							else
								daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed, 2));
							
							if (daNote.isSustainNote)
								{
									if (daNote.animation.curAnim.name.endsWith('end') && daNote.prevNote != null)
										daNote.y += ((daNote.prevNote.height / 1.05) * (0.37 * 1.6)) + (0.1 * SONG.speed) + 4;
			
									if ((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit && !daNote.canBeHit) && daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= (strumLine.y + Note.swagWidth / 2))
									{
											var swagRect:FlxRect = new FlxRect(0, strumLine.y + Note.swagWidth / 2 - daNote.y, daNote.width * 2, daNote.height * 2);
											swagRect.y /= daNote.scale.y;
											swagRect.height -= swagRect.y;
				
											daNote.clipRect = swagRect;
									}
							   }
						}
					else
						{
							if (daNote.mustPress)
								daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed, 2));
							else
								daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed, 2));
		
							
							if (daNote.isSustainNote)
								{
									if ((PlayStateChangeables.botPlay
										|| !daNote.mustPress
										|| daNote.wasGoodHit
										|| holdArray[Math.floor(Math.abs(daNote.noteData))])
										&& daNote.y + daNote.offset.y * daNote.scale.y <= (strumLine.y + Note.swagWidth / 2))
									{
										// Clip to strumline
										var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
										swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
											+ Note.swagWidth / 2
											- daNote.y) / daNote.scale.y;
										swagRect.height -= swagRect.y;
		
										daNote.clipRect = swagRect;
									}
								}
							}
					
		
	
					if (!daNote.mustPress && daNote.wasGoodHit)
					{

						if (storyDifficulty == 2) // this is the drain system, i know it could be better but i don't fucking care i did it myself and i found it very cool -Z
							{
								if (dad.curCharacter.toLowerCase() == "beno1" && health >= 0.07)
								{
									health -= 0.01; //how many damage he deal
									
								}
								if (dad.curCharacter.toLowerCase() == "beno2" && health >= 0.07)
								{
									health -= 0.0125; //how many damage he deal
								}
								if (dad.curCharacter.toLowerCase() == "beno3" && health >= 0.07)
								{
									health -= 0.0150; //how many damage he deal
								}
								if (dad.curCharacter.toLowerCase() == "beno3blood" && health >= 0.07) 
								{
									health -= 0.02; //how many damage he deal
								}

								// when beno IS dying -Z aka RAGE MODE -Z
								if (dad.curCharacter.toLowerCase() == "beno1" && health >= 1.25)
								{
									health -= 0.0130; //how many damage he deal
								}
								if (dad.curCharacter.toLowerCase() == "beno2" && health >= 1.25)
								{
									health -= 0.0170; //how many damage he deal
								}
								if (dad.curCharacter.toLowerCase() == "beno3" && health >= 1.25)
								{
									health -= 0.0200; //how many damage he deal
									FlxG.camera.shake(0.01, (60 / Conductor.bpm), null, true, FlxAxes.X);
								}
								if (dad.curCharacter.toLowerCase() == "beno3blood" && health >= 1.25) 
								{
									health -= 0.0250; //how many damage he deal
									FlxG.camera.shake(0.0125, (60 / Conductor.bpm), null, true, FlxAxes.X);
									if (health >= 1.95) // Should make the screen shake hard for the first note that beno hit, idfk if it work or not bruh -Z
										{
									FlxG.camera.shake(0.05, (60 / Conductor.bpm), null, true);
									FlxG.camera.zoom += 0.25;
										}
								}

							}

							if (storyDifficulty == 1)
								{
									if (dad.curCharacter.toLowerCase() == "beno1" && health >= 0.07)
									{
										health -= 0.005; //how many damage he deal
									}
									if (dad.curCharacter.toLowerCase() == "beno2" && health >= 0.07)
									{
										health -= 0.00625; //how many damage he deal
									}
									if (dad.curCharacter.toLowerCase() == "beno3" && health >= 0.07)
									{
										health -= 0.0075; //how many damage he deal
									}
									if (dad.curCharacter.toLowerCase() == "beno3blood" && health >= 0.07) 
									{
										health -= 0.01; //how many damage he deal
									}
	
									// when beno IS dying -Z aka RAGE MODE -Z
									if (dad.curCharacter.toLowerCase() == "beno1" && health >= 1.25)
									{
										health -= 0.0065; //how many damage he deal
									}
									if (dad.curCharacter.toLowerCase() == "beno2" && health >= 1.25)
									{
										health -= 0.0085; //how many damage he deal
									}
									if (dad.curCharacter.toLowerCase() == "beno3" && health >= 1.25)
									{
										health -= 0.01; //how many damage he deal
									}
									if (dad.curCharacter.toLowerCase() == "beno3blood" && health >= 1.25) 
									{
										health -= 0.0125; //how many damage he deal
									}
								}

						if (storyDifficulty == 0 && dad.curCharacter.toLowerCase() == "beno1" || dad.curCharacter.toLowerCase() == "beno2" || dad.curCharacter.toLowerCase() == "beno3" || dad.curCharacter.toLowerCase() == "beno3blood")
							{
								if (health >= 0) //Stop before you die lol
								{
									health -= 0; // Yup this code is fucking useless, what you gonna do about it ? -Z
								}
							}
		
						if (SONG.song != 'Training')
							camZooming = true;

						var altAnim:String = "";
	
						if (SONG.notes[Math.floor(curStep / 16)] != null)
						{
							if (SONG.notes[Math.floor(curStep / 16)].altAnim)
								altAnim = '-alt';
						}
	
						switch (Math.abs(daNote.noteData))
						{
							case 2:
								dad.playAnim('singUP' + altAnim, true);
								dadMovementYoffset = -30;
								dadMovementXoffset = 0;
							case 3:
								dad.playAnim('singRIGHT' + altAnim, true);
								dadMovementXoffset = 30;
								dadMovementYoffset = 0;
							case 1:
								dad.playAnim('singDOWN' + altAnim, true);
								dadMovementYoffset = 30;
								dadMovementXoffset = 0;
							case 0:
								dad.playAnim('singLEFT' + altAnim, true);
								dadMovementXoffset = -30;
								dadMovementYoffset = 0;
						}
						if (daNote.noteType == 'warning')
							switch (Math.abs(daNote.noteData))
							{
								case 2:
									dad.playAnim('slash', true);
								case 3:
									dad.playAnim('stab', true);
								case 1:
									dad.playAnim('slash', true);
								case 0:
									dad.playAnim('stab', true);
							}
						
						playerTwoPlaying = true;
						
						if (bothPlaying == false && SONG.song.toLowerCase()=='frenzy' || SONG.song.toLowerCase() == 'frenzy x megalovania')
						{
                            randomFrenzyText();
						}

						if (SONG.song.toLowerCase()=='frenzy' || SONG.song.toLowerCase() == 'frenzy x megalovania')
							{
							noteCam.shake(0.005, (60 / Conductor.bpm), null, true, FlxAxes.X);
							}

						if (SONG.song.toLowerCase()=='frenzied')
							{
							noteCam.shake(0.010, (60 / Conductor.bpm), null, true, FlxAxes.X);
							}
						
						if (FlxG.save.data.cpuStrums)
						{
							cpuStrums.forEach(function(spr:FlxSprite)
							{
								if (Math.abs(daNote.noteData) == spr.ID)
								{
									spr.animation.play('confirm', true);
								}
								if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
								{
									spr.centerOffsets();
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								}
								else
									spr.centerOffsets();
							});
						}
	
						#if windows
						if (luaModchart != null)
							luaModchart.executeState('playerTwoSing', [Math.abs(daNote.noteData), Conductor.songPosition]);
						#end

						dad.holdTimer = 0;
	
						if (SONG.needsVoices)
							vocals.volume = 1;
	
						daNote.active = false;


						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}

					if (daNote.mustPress && !daNote.modifiedByLua)
					{
						daNote.visible = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].visible;
						daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].x;
						if (!daNote.isSustainNote)
							daNote.angle = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].angle;
						daNote.alpha = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].alpha;
					}
					else if (!daNote.wasGoodHit && !daNote.modifiedByLua)
					{
						daNote.visible = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].visible;
						daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].x;
						if (!daNote.isSustainNote)
							daNote.angle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].angle;
						daNote.alpha = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].alpha;
					}
					
					

					if (daNote.isSustainNote)
						daNote.x += daNote.width / 2 + 17;
					

					//trace(daNote.y);
					// WIP interpolation shit? Need to fix the pause issue
					// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
	
					if ((daNote.mustPress && daNote.tooLate && !PlayStateChangeables.useDownscroll || daNote.mustPress && daNote.tooLate && PlayStateChangeables.useDownscroll) && daNote.mustPress)
					{
							if (daNote.isSustainNote && daNote.wasGoodHit)
							{
								daNote.kill();
								notes.remove(daNote, true);
							}
							else
							{
								if (loadRep && daNote.isSustainNote)
								{
									// im tired and lazy this sucks I know i'm dumb
									if (findByTime(daNote.strumTime) != null)
										totalNotesHit += 1;
									else
									{
										health -= 0.075;
										vocals.volume = 0;
										if (daNote.noteType == 'warning')
											{
												health = 0;
											}
										if (theFunne)
											noteMiss(daNote.noteData, daNote);
									}
								}
								else
								{
									health -= 0.075;
									vocals.volume = 0;
									if (daNote.noteType == 'warning')
										{
											health = 0;
										}
									if (theFunne)
										noteMiss(daNote.noteData, daNote);
								}
							}
		
							daNote.visible = false;
							daNote.kill();
							notes.remove(daNote, true);
						}
					
				});
			}

		if (FlxG.save.data.cpuStrums)
		{
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				if (spr.animation.finished)
				{
					spr.animation.play('static');
					spr.centerOffsets();
				}
			});
		}

		if (!inCutscene)
			keyShit();


		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	function endSong():Void
	{
		songEnded = true;
		if (useVideo)
			{
				GlobalVideo.get().stop();
				FlxG.stage.window.onFocusOut.remove(focusOut);
				FlxG.stage.window.onFocusIn.remove(focusIn);
				PlayState.instance.remove(PlayState.instance.videoSprite);
			}

		if (isStoryMode)
			campaignMisses = misses;

		if (!loadRep)
			rep.SaveReplay(saveNotes);
		else
		{
			PlayStateChangeables.botPlay = false;
			PlayStateChangeables.scrollSpeed = 1;
			PlayStateChangeables.useDownscroll = false;
		}

		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);

		#if windows
		if (luaModchart != null)
		{
			luaModchart.die();
			luaModchart = null;
		}
		#end

		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		FlxG.sound.music.pause();
		vocals.pause();
		if (SONG.validScore)
		{
			// adjusting the highscore song name to be compatible
			// would read original scores if we didn't change packages
			var songHighscore = StringTools.replace(PlayState.SONG.song, " ", "-");
			switch (songHighscore) {
				case 'Dad-Battle': songHighscore = 'Dadbattle';
				case 'Philly-Nice': songHighscore = 'Philly';
			}

			#if !switch
			Highscore.saveScore(songHighscore, Math.round(songScore), storyDifficulty);
			Highscore.saveCombo(songHighscore, Ratings.GenerateLetterRank(accuracy), storyDifficulty);
			#end
		}

		if (SONG.song.toLowerCase() == 'your choice' && isStoryMode && !endingShown)
			{
				endingShown = true;
				camZooming = false;
				inCutscene = true;
				startedCountdown = false;
				generatedMusic = false;
				canPause = false;
				FlxG.sound.music.pause();
				vocals.pause();
				vocals.stop();
				FlxG.sound.music.stop();
				remove(strumLineNotes);
				remove(scoreTxt);
				remove(healthBarBG);
				remove(healthBar);
				remove(iconP1);
				remove(iconP2);
				camFollow.x -= 99999; //Camera goes Weeeeeeeee
				schoolIntro(doofend);
			}
			// i know i can compress the code, but like i tried 2 times with 2 different code  -Z
			// Me and shining both tried different system they all fucking failed, so this what i'm dealing with, it's good, but it can be better -Z
			else if (SONG.song.toLowerCase() == 'spaghetticode' && !endingShown && FlxG.random.bool(25))
				{
					PlayState.SONG = Song.loadFromJson('zhugolecturesyouaboutpiracy-hard', 'zhugolecturesyouaboutpiracy');
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = 2;
					PlayState.storyWeek = 1;
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					LoadingState.loadAndSwitchState(new PlayState());
				}

			else if (SONG.song.toLowerCase() == 'training' && isStoryMode && !endingShown)
				{
					endingShown = true;
					camZooming = false;
					inCutscene = true;
					startedCountdown = false;
					generatedMusic = false;
					canPause = false;
					FlxG.sound.music.pause();
					vocals.pause();
					vocals.stop();
					FlxG.sound.music.stop();
					remove(strumLineNotes);
					remove(scoreTxt);
					remove(healthBarBG);
					remove(healthBar);
					remove(iconP1);
					remove(iconP2);
					camFollow.x -= 99999;
					schoolIntro(doofend);
				}

			else if (SONG.song.toLowerCase() == 'nothing personal' && isStoryMode && !endingShown)
				{
					endingShown = true;
					camZooming = false;
					inCutscene = true;
					startedCountdown = false;
					generatedMusic = false;
					canPause = false;
					FlxG.sound.music.pause();
					vocals.pause();
					vocals.stop();
					FlxG.sound.music.stop();
					remove(strumLineNotes);
					remove(scoreTxt);
					remove(healthBarBG);
					remove(healthBar);
					remove(iconP1);
					remove(iconP2);
					schoolIntro(doofend);
				}

			else if (SONG.song.toLowerCase() == 'exile' && isStoryMode && !endingShown)
				{
					endingShown = true;
					camZooming = false;
					inCutscene = true;
					startedCountdown = false;
					generatedMusic = false;
					canPause = false;
					FlxG.sound.music.pause();
					vocals.pause();
					vocals.stop();
					FlxG.sound.music.stop();
					remove(strumLineNotes);
					remove(scoreTxt);
					remove(healthBarBG);
					remove(healthBar);
					remove(iconP1);
					remove(iconP2);
					camFollow.x -= 99999; //Camera goes Weeeeeeeeeee again
					schoolIntro(doofend);
				}
				else if (storyDifficulty >= 1 && !endingShown && SONG.song.toLowerCase() == 'frenzy' && isStoryMode) // i'm brain man -Z
					{
						endingShown = true;
						camZooming = false;
						inCutscene = true;
						startedCountdown = false;
						generatedMusic = false;
						canPause = false;
						FlxG.sound.music.pause();
						vocals.pause();
						vocals.stop();
						FlxG.sound.music.stop();
						remove(strumLineNotes);
						remove(scoreTxt);
						remove(healthBarBG);
						remove(healthBar);
						remove(iconP1);
						remove(iconP2);
						camFollow.y += 9999; //LETRS FUCKING GOOOOOOOOOOOOOO -Z
						schoolIntro(doofend);
					} 
		else if (offsetTesting)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			offsetTesting = false;
			LoadingState.loadAndSwitchState(new OptionsMenu());
			FlxG.save.data.offset = offsetTest;
		}
		else
		{
			if (isStoryMode)
			{
				campaignScore += Math.round(songScore);

				storyPlaylist.remove(storyPlaylist[0]);

				if (storyPlaylist.length <= 0)
				{
					transIn = FlxTransitionableState.defaultTransIn;
					transOut = FlxTransitionableState.defaultTransOut;

					paused = true;

					FlxG.sound.music.stop();
					vocals.stop();
						if (FlxG.save.data.scoreScreen)
							{
								#if html5 
								FlxG.switchState(new SongState()); 
								#else 
								FlxG.switchState(new MainMenuState());
								FlxG.sound.playMusic(Paths.music('freakyMenu'));
								#end // No. -Z
							}
					else
					{
						trace('i tried 3'); // did this a long time ago, because training didn't wanted to go on mainmenu instead it will just crash, because the modchart was the problem -Z
						#if html5 
						FlxG.switchState(new SongState()); // I will not mention this code, please do the same. -Z
						#else 
						FlxG.switchState(new MainMenuState());
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
						#end // No Reupload -Z
						
					}	

					#if windows
					if (luaModchart != null)
					{
						luaModchart.die();
						luaModchart = null;
					}
					#end

					// if ()
					StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

					if (SONG.validScore)
					{
						NGio.unlockMedal(60961);
						Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
					}

					FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
					FlxG.save.flush();
				}
				else
				{
					
					// adjusting the song name to be compatible
					var songFormat = StringTools.replace(PlayState.storyPlaylist[0], " ", "-");
					switch (songFormat) {
						case 'Dad-Battle': songFormat = 'Dadbattle';
						case 'Philly-Nice': songFormat = 'Philly';
					}

					var poop:String = Highscore.formatSong(songFormat, storyDifficulty);

					trace('LOADING NEXT SONG');
					trace(poop);

					if (StringTools.replace(PlayState.storyPlaylist[0], " ", "-").toLowerCase() == 'eggnog')
					{
						var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
							-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
						blackShit.scrollFactor.set();
						add(blackShit);
						camHUD.visible = false;

						FlxG.sound.play(Paths.sound('Lights_Shut_off'));
					}

					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;


					PlayState.SONG = Song.loadFromJson(poop, PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();

					#if html5 
					FlxG.switchState(new SongState());
					#else 
					LoadingState.loadAndSwitchState(new PlayState());
					#end
				}
			}
			else
			{
				trace('WENT BACK TO FREEPLAY??');

				paused = true;


				FlxG.sound.music.stop();
				vocals.stop();

				if (FlxG.save.data.scoreScreen)
					#if html5 
				FlxG.switchState(new SongState());
					#else 
					FlxG.switchState(new NewFreeplaystate());// bad but fuck it -Z
					#end
				else
					#if html5 
				FlxG.switchState(new SongState());
					#else 
					FlxG.switchState(new NewFreeplaystate());
					#end
		}
	}
}

	var endingSong:Bool = false;

	var hits:Array<Float> = [];
	var offsetTest:Float = 0;

	var timeShown = 0;
	var currentTimingShown:FlxText = null;

	private function popUpScore(daNote:Note):Void
		{
			var noteDiff:Float = -(daNote.strumTime - Conductor.songPosition);
			var wife:Float = EtternaFunctions.wife3(-noteDiff, Conductor.timeScale);
			// boyfriend.playAnim('hey');
			vocals.volume = 1;
			var placement:String = Std.string(combo);
	
			var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
			coolText.y -= 350;
			coolText.cameras = [camHUD];
			//
	
			var rating:FlxSprite = new FlxSprite();
			var score:Float = 350;

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit += wife;

			var daRating = daNote.rating;

			switch(daRating)
			{
				case 'shit':
					score = -300;
					combo = 0;
					misses++;
					health -= 0.2;
					ss = false;
					shits++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.25;
				case 'bad':
					daRating = 'bad';
					score = 0;
					combo = 0;
					health -= 0.04;
					ss = false;
					bads++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.50;
				case 'good':
					daRating = 'good';
					score = 200;
					ss = false;
					goods++;
					if (health < 2)
						health += 0.02;
					if (health < 0.75)// for when you're dying -Z 
						health += 0.015; 
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.75;
				case 'sick':
					if (health < 2)
						health += 0.04; // the hp gain is lower then the normal kade engine, because i wanted to feel less powerful when playing, and this does a great job :D -Z
					if (health < 0.75) // for when you're dying -Z
						{
						health += 0.03;
						trace ('Im low give me hp');
						}
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 1;
					sicks++;
			}

			// trace('Wife accuracy loss: ' + wife + ' | Rating: ' + daRating + ' | Score: ' + score + ' | Weight: ' + (1 - wife));

			if (daRating != 'shit' || daRating != 'bad')
				{
	
	
			songScore += Math.round(score);
			songScoreDef += Math.round(ConvertScore.convertScore(noteDiff));
	
			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			 */
	
			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';
	
			if (curStage.startsWith('school'))
			{
				pixelShitPart1 = 'weeb/pixelUI/';
				pixelShitPart2 = '-pixel';
			}
	
			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.y -= 50;
			rating.x = coolText.x - 125;
			
			if (FlxG.save.data.changedHit)
			{
				rating.x = FlxG.save.data.changedHitX;
				rating.y = FlxG.save.data.changedHitY;
			}
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);
			
			var msTiming = HelperFunctions.truncateFloat(noteDiff, 3);
			if(PlayStateChangeables.botPlay && !loadRep) msTiming = 0;		
			
			if (loadRep)
				msTiming = HelperFunctions.truncateFloat(findByTime(daNote.strumTime)[3], 3);

			if (currentTimingShown != null)
				remove(currentTimingShown);

			currentTimingShown = new FlxText(0,0,0,"0ms");
			timeShown = 0;
			switch(daRating)
			{
				case 'shit' | 'bad':
					currentTimingShown.color = FlxColor.RED;
				case 'good':
					currentTimingShown.color = FlxColor.GREEN;
				case 'sick':
					currentTimingShown.color = FlxColor.CYAN;
			}
			currentTimingShown.borderStyle = OUTLINE;
			currentTimingShown.borderSize = 1;
			currentTimingShown.borderColor = FlxColor.BLACK;
			currentTimingShown.text = msTiming + "ms";
			currentTimingShown.size = 0;

			if (msTiming >= 0.03 && offsetTesting)
			{
				//Remove Outliers
				hits.shift();
				hits.shift();
				hits.shift();
				hits.pop();
				hits.pop();
				hits.pop();
				hits.push(msTiming);

				var total = 0.0;

				for(i in hits)
					total += i;
				

				
				offsetTest = HelperFunctions.truncateFloat(total / hits.length,2);
			}

			if (currentTimingShown.alpha != 1)
				currentTimingShown.alpha = 1;

			if(!PlayStateChangeables.botPlay || loadRep) add(currentTimingShown);
			
			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = rating.x;
			comboSpr.y = rating.y + 100;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;

			currentTimingShown.screenCenter();
			currentTimingShown.x = comboSpr.x + 100;
			currentTimingShown.y = rating.y + 100;
			currentTimingShown.acceleration.y = 600;
			currentTimingShown.velocity.y -= 150;
	
			comboSpr.velocity.x += FlxG.random.int(1, 10);
			currentTimingShown.velocity.x += comboSpr.velocity.x;
			if(!PlayStateChangeables.botPlay || loadRep) add(rating);
	
			if (!curStage.startsWith('school'))
			{
				rating.setGraphicSize(Std.int(rating.width * 0.7));
				rating.antialiasing = true;
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
				comboSpr.antialiasing = true;
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
			}
	
			currentTimingShown.updateHitbox();
			comboSpr.updateHitbox();
			rating.updateHitbox();


			var seperatedScore:Array<Int> = [];
	
			var comboSplit:Array<String> = (combo + "").split('');

			if (combo > highestCombo)
				highestCombo = combo;

			// make sure we have 3 digits to display (looks weird otherwise lol)
			if (comboSplit.length == 1)
			{
				seperatedScore.push(0);
				seperatedScore.push(0);
			}
			else if (comboSplit.length == 2)
				seperatedScore.push(0);

			for(i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}
	
			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = rating.x + (43 * daLoop) - 50;
				numScore.y = rating.y + 100;

				if (!curStage.startsWith('school'))
				{
					numScore.antialiasing = true;
					numScore.setGraphicSize(Std.int(numScore.width * 0.5));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();
	
				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);
	
				add(numScore);
	
				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						numScore.destroy();
					},
					startDelay: Conductor.crochet * 0.002
				});
	
				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */
	
			coolText.text = Std.string(seperatedScore);
			// add(coolText);
	
			FlxTween.tween(rating, {alpha: 0}, 0.2, {
				startDelay: Conductor.crochet * 0.001,
				onUpdate: function(tween:FlxTween)
				{
					if (currentTimingShown != null)
						currentTimingShown.alpha -= 0.02;
					timeShown++;
				}
			});

			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();
					if (currentTimingShown != null && timeShown >= 20)
					{
						remove(currentTimingShown);
						currentTimingShown = null;
					}
					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});
	
			curSection += 1;
			}
		}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
		{
			return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
		}

		var upHold:Bool = false;
		var downHold:Bool = false;
		var rightHold:Bool = false;
		var leftHold:Bool = false;	

		private function keyShit():Void // I've invested in emma stocks
			{
				// control arrays, order L D R U
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
				var pressArray:Array<Bool> = [
					controls.LEFT_P,
					controls.DOWN_P,
					controls.UP_P,
					controls.RIGHT_P
				];
				var releaseArray:Array<Bool> = [
					controls.LEFT_R,
					controls.DOWN_R,
					controls.UP_R,
					controls.RIGHT_R
				];
				#if windows
				if (luaModchart != null){
				if (controls.LEFT_P){luaModchart.executeState('keyPressed',["left"]);};
				if (controls.DOWN_P){luaModchart.executeState('keyPressed',["down"]);};
				if (controls.UP_P){luaModchart.executeState('keyPressed',["up"]);};
				if (controls.RIGHT_P){luaModchart.executeState('keyPressed',["right"]);};
				};
				#end
		 
				// Prevent player input if botplay is on
				if(PlayStateChangeables.botPlay)
				{
					holdArray = [false, false, false, false];
					pressArray = [false, false, false, false];
					releaseArray = [false, false, false, false];
				} 
				// HOLDS, check for sustain notes
				if (holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData])
							goodNoteHit(daNote);
					});
				}
		 
				// PRESSES, check for note hits
				if (pressArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					boyfriend.holdTimer = 0;
		 
					var possibleNotes:Array<Note> = []; // notes that can be hit
					var directionList:Array<Int> = []; // directions that can be hit
					var dumbNotes:Array<Note> = []; // notes to kill later
					var directionsAccounted:Array<Bool> = [false,false,false,false]; // we don't want to do judgments for more than one presses
					
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
						{
							if (!directionsAccounted[daNote.noteData])
							{
								if (directionList.contains(daNote.noteData))
								{
									directionsAccounted[daNote.noteData] = true;
									for (coolNote in possibleNotes)
									{
										if (coolNote.noteData == daNote.noteData && Math.abs(daNote.strumTime - coolNote.strumTime) < 10)
										{ // if it's the same note twice at < 10ms distance, just delete it
											// EXCEPT u cant delete it in this loop cuz it fucks with the collection lol
											dumbNotes.push(daNote);
											break;
										}
										else if (coolNote.noteData == daNote.noteData && daNote.strumTime < coolNote.strumTime)
										{ // if daNote is earlier than existing note (coolNote), replace
											possibleNotes.remove(coolNote);
											possibleNotes.push(daNote);
											break;
										}
									}
								}
								else
								{
									possibleNotes.push(daNote);
									directionList.push(daNote.noteData);
								}
							}
						}
					});

					for (note in dumbNotes)
					{
						FlxG.log.add("killing dumb ass note at " + note.strumTime);
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}
		 
					possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
		 
					var dontCheck = false;

					for (i in 0...pressArray.length)
					{
						if (pressArray[i] && !directionList.contains(i))
							dontCheck = true;
					}

					if (perfectMode)
						goodNoteHit(possibleNotes[0]);
					else if (possibleNotes.length > 0 && !dontCheck)
					{
						if (!FlxG.save.data.ghost)
						{
							for (shit in 0...pressArray.length)
								{ // if a direction is hit that shouldn't be
									if (pressArray[shit] && !directionList.contains(shit))
										noteMiss(shit, null);
								}
						}
						for (coolNote in possibleNotes)
						{
							if (pressArray[coolNote.noteData])
							{
								if (mashViolations != 0)
									mashViolations--;
								scoreTxt.color = FlxColor.WHITE;
								goodNoteHit(coolNote);
							}
						}
					}
					else if (!FlxG.save.data.ghost)
						{
							for (shit in 0...pressArray.length)
								if (pressArray[shit])
									noteMiss(shit, null);
						}

					if(dontCheck && possibleNotes.length > 0 && FlxG.save.data.ghost && !PlayStateChangeables.botPlay)
					{
						if (mashViolations > 8)
						{
							trace('mash violations ' + mashViolations);
							scoreTxt.color = FlxColor.RED;
							noteMiss(0,null);
						}
						else
							mashViolations++;
					}

				}
				
				notes.forEachAlive(function(daNote:Note)
				{
					if(PlayStateChangeables.useDownscroll && daNote.y > strumLine.y ||
					!PlayStateChangeables.useDownscroll && daNote.y < strumLine.y)
					{
						// Force good note hit regardless if it's too late to hit it or not as a fail safe
						if(PlayStateChangeables.botPlay && daNote.canBeHit && daNote.mustPress ||
						PlayStateChangeables.botPlay && daNote.tooLate && daNote.mustPress)
						{
							if(loadRep)
							{
								//trace('ReplayNote ' + tmpRepNote.strumtime + ' | ' + tmpRepNote.direction);
								var n = findByTime(daNote.strumTime);
								trace(n);
								if(n != null)
								{
									goodNoteHit(daNote);
									boyfriend.holdTimer = daNote.sustainLength;
								}
							}else {
								goodNoteHit(daNote);
								boyfriend.holdTimer = daNote.sustainLength;
							}
						}
					}
				});
				
				if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || PlayStateChangeables.botPlay))
					{
						if (boyfriend.animation.curAnim.name.startsWith('sing')
							&& !boyfriend.animation.curAnim.name.endsWith('miss')
							&& (boyfriend.animation.curAnim.curFrame >= 10 || boyfriend.animation.curAnim.finished))
							boyfriend.dance();
					}


		 
				playerStrums.forEach(function(spr:FlxSprite)
				{
					if (pressArray[spr.ID] && spr.animation.curAnim.name != 'confirm')
						spr.animation.play('pressed');
					if (!holdArray[spr.ID])
						spr.animation.play('static');
		 
					if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
					{
						spr.centerOffsets();
						spr.offset.x -= 13;
						spr.offset.y -= 13;
					}
					else
						spr.centerOffsets();
				});
			}

			public function findByTime(time:Float):Array<Dynamic>
				{
					for (i in rep.replay.songNotes)
					{
						//trace('checking ' + Math.round(i[0]) + ' against ' + Math.round(time));
						if (i[0] == time)
							return i;
					}
					return null;
				}

			public var fuckingVolume:Float = 1;
			public var useVideo = false;

			public static var webmHandler:WebmHandler;

			public var playingDathing = false;

			public var videoSprite:FlxSprite;

			public function focusOut() {
				if (paused)
					return;
				persistentUpdate = false;
				persistentDraw = true;
				paused = true;
		
					if (FlxG.sound.music != null)
					{
						FlxG.sound.music.pause();
						vocals.pause();
					}
		
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
			public function focusIn() 
			{ 
				// nada 
			}


			public function backgroundVideo(source:String) // for background videos
				{
					useVideo = true;
			
					FlxG.stage.window.onFocusOut.add(focusOut);
					FlxG.stage.window.onFocusIn.add(focusIn);

					var ourSource:String = "assets/videos/daWeirdVid/dontDelete.webm";
					WebmPlayer.SKIP_STEP_LIMIT = 90;
					var str1:String = "WEBM SHIT"; 
					webmHandler = new WebmHandler();
					webmHandler.source(ourSource);
					webmHandler.makePlayer();
					webmHandler.webm.name = str1;
			
					GlobalVideo.setWebm(webmHandler);

					GlobalVideo.get().source(source);
					GlobalVideo.get().clearPause();
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().updatePlayer();
					}
					GlobalVideo.get().show();
			
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().restart();
					} else {
						GlobalVideo.get().play();
					}
					
					var data = webmHandler.webm.bitmapData;
			
					videoSprite = new FlxSprite(-470,-30).loadGraphic(data);
			
					videoSprite.setGraphicSize(Std.int(videoSprite.width * 1.2));
			
					remove(gf);
					remove(boyfriend);
					remove(dad);
					add(videoSprite);
					add(gf);
					add(boyfriend);
					add(dad);
			
					trace('poggers');
			
					if (!songStarted)
						webmHandler.pause();
					else
						webmHandler.resume();
				}

	function noteMiss(direction:Int = 1, daNote:Note):Void
	{

		if (!boyfriend.stunned)
		{
			health -= 0.04;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;
			misses++;

			if (daNote != null)
			{
				if (!loadRep)
					saveNotes.push([daNote.strumTime,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);
			}
			else
				if (!loadRep)
					saveNotes.push([Conductor.songPosition,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);

			//var noteDiff:Float = Math.abs(daNote.strumTime - Conductor.songPosition);
			//var wife:Float = EtternaFunctions.wife3(noteDiff, FlxG.save.data.etternaMode ? 1 : 1.7);

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit -= 1;

			songScore -= 10;

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');

				switch (direction)
				{
					case 0:
						boyfriend.playAnim('singLEFTmiss', true);
					case 1:
						boyfriend.playAnim('singDOWNmiss', true);
					case 2:
						boyfriend.playAnim('singUPmiss', true);
					case 3:
						boyfriend.playAnim('singRIGHTmiss', true);
				}

			#if windows
			if (luaModchart != null)
				luaModchart.executeState('playerOneMiss', [direction, Conductor.songPosition]);
			#end


			updateAccuracy();
		}
	}

	/*function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;
	
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
			updateAccuracy();
		}
	*/
	function updateAccuracy() 
		{
			totalPlayed += 1;
			accuracy = Math.max(0,totalNotesHit / totalPlayed * 100);
			accuracyDefault = Math.max(0, totalNotesHitDefault / totalPlayed * 100);
		}


	function getKeyPresses(note:Note):Int
	{
		var possibleNotes:Array<Note> = []; // copypasted but you already know that

		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
			{
				possibleNotes.push(daNote);
				possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
			}
		});
		if (possibleNotes.length == 1)
			return possibleNotes.length + 1;
		return possibleNotes.length;
	}
	
	var mashing:Int = 0;
	var mashViolations:Int = 0;

	var etternaModeScore:Int = 0;

	function noteCheck(controlArray:Array<Bool>, note:Note):Void // sorry lol
		{
			var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

			note.rating = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

			/* if (loadRep)
			{
				if (controlArray[note.noteData])
					goodNoteHit(note, false);
				else if (rep.replay.keyPresses.length > repPresses && !controlArray[note.noteData])
				{
					if (NearlyEquals(note.strumTime,rep.replay.keyPresses[repPresses].time, 4))
					{
						goodNoteHit(note, false);
					}
				}
			} */
			
			if (controlArray[note.noteData])
			{
				goodNoteHit(note, (mashing > getKeyPresses(note)));
				
				/*if (mashing > getKeyPresses(note) && mashViolations <= 2)
				{
					mashViolations++;

					goodNoteHit(note, (mashing > getKeyPresses(note)));
				}
				else if (mashViolations > 2)
				{
					// this is bad but fuck you
					playerStrums.members[0].animation.play('static');
					playerStrums.members[1].animation.play('static');
					playerStrums.members[2].animation.play('static');
					playerStrums.members[3].animation.play('static');
					health -= 0.4;
					trace('mash ' + mashing);
					if (mashing != 0)
						mashing = 0;
				}
				else
					goodNoteHit(note, false);*/

			}
		}

		function goodNoteHit(note:Note, resetMashViolation = true):Void
			{

				if (mashing != 0)
					mashing = 0;

				var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

				if(loadRep)
					noteDiff = findByTime(note.strumTime)[3];

				note.rating = Ratings.CalculateRating(noteDiff);

				if (note.rating == "miss")
					return;	

				// add newest note to front of notesHitArray
				// the oldest notes are at the end and are removed first
				if (!note.isSustainNote)
					notesHitArray.unshift(Date.now());

				if (!resetMashViolation && mashViolations >= 1)
					mashViolations--;

				if (mashViolations < 0)
					mashViolations = 0;

				if (!note.wasGoodHit)
				{
					if (!note.isSustainNote)
					{
						popUpScore(note);
						combo += 1;
					}
					else
						totalNotesHit += 1;
	
					{
						switch (note.noteData)
						{
							case 2:
								boyfriend.playAnim('singUP', true);
								bfMovementYoffset = -30;
								bfMovementXoffset = 0;
							case 3:
								boyfriend.playAnim('singRIGHT', true);
								bfMovementXoffset = 30;
								bfMovementYoffset = 0;
							case 1:
								boyfriend.playAnim('singDOWN', true);
								bfMovementYoffset = 30;
								bfMovementXoffset = 0;
							case 0:
								boyfriend.playAnim('singLEFT', true);
								bfMovementXoffset = -30;
								bfMovementYoffset = 0;				
						}
						if (note.noteType == 'warning')
						switch (note.noteData)
						{
							case 2:
								boyfriend.playAnim('singDODGE', true);
								FlxG.sound.play(Paths.soundRandom('knife_swing', 1, 5), 1);
								FlxG.camera.zoom += 0.25; // little zoom on dodge bruh
							case 3:
								boyfriend.playAnim('singDODGE', true);
								FlxG.sound.play(Paths.soundRandom('knife_swing', 1, 5), 1);
								FlxG.camera.zoom += 0.25;
							case 1:
								boyfriend.playAnim('singDODGE', true);
								FlxG.sound.play(Paths.soundRandom('knife_swing', 1, 5), 1);
								FlxG.camera.zoom += 0.25;
							case 0:
								boyfriend.playAnim('singDODGE', true);
								FlxG.sound.play(Paths.soundRandom('knife_swing', 1, 5), 1);
								FlxG.camera.zoom += 0.25;
						}
						if (note.noteType == 'warning')
							switch (note.noteData)
							{
								case 2:
									dad.playAnim('slash', true);
								case 3:
									dad.playAnim('stab', true);
								case 1:
									dad.playAnim('slash', true);
								case 0:
									dad.playAnim('stab', true);
							}
					}

					playerOnePlaying = true;
		
					#if windows
					if (luaModchart != null)
						luaModchart.executeState('playerOneSing', [note.noteData, Conductor.songPosition]);
					#end


					if(!loadRep && note.mustPress)
					{
						var array = [note.strumTime,note.sustainLength,note.noteData,noteDiff];
						if (note.isSustainNote)
							array[1] = -1;
						//trace('pushing ' + array[0]); // I WANT TO SEE MY SHIT OAKY ?!!! -Z
						saveNotes.push(array);
					}
					
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
					
					note.wasGoodHit = true;
					vocals.volume = 1;
		
					note.kill();
					notes.remove(note, true);
					note.destroy();
					
					updateAccuracy();
				}
			}
		
// Ye ye i know the car code is bad and shining try doing it better but i felt like that mine was better for random and timing, so i did it anyways it's work leave me alone :C -Z
			var fastCarCanDrive:Bool = true;
			var fastCarCanDrive1:Bool = true;
			var fastCarCanDrive2:Bool = true;
			var fastCarCanDrive3:Bool = true;
			var fastCarCanDrive4:Bool = true;
			var fastCarCanDrive5:Bool = true;
			var fastCarCanDriveBoi:Bool = true;
			var fastCarCanDrivePizza:Bool = true;

			function resetFastCarPizza():Void
				{
					if(FlxG.save.data.distractions){
						fastCarPizza.x = 2000;
						fastCarPizza.velocity.x = 0; // No change :moyai: -Z
						fastCarCanDrivePizza = true;
					}
				}

		function resetFastCarBoi():Void
		{
			if(FlxG.save.data.distractions){
				fastCarBoi.x = 2000;
				fastCarBoi.velocity.x = 0; // Change the sounds speed IDK WHAT T§HE F§UCK
				fastCarCanDriveBoi = true;
			}
		}
			
			function resetFastCar():Void
			{
				if (FlxG.save.data.distractions)
				{
					fastCar.x = -12600;
					fastCar.velocity.x = 0;
					fastCarCanDrive = true;
				}
			}
		
			function resetFastCar1():Void
				{
					if (FlxG.save.data.distractions)
					{
						fastCar1.x = 12600;
						fastCar1.velocity.x = 0;
						fastCarCanDrive1 = true;
					}
				}
		
			function resetFastCar2():Void
				{
					if (FlxG.save.data.distractions)
					{
						fastCar2.x = 12600;
						fastCar2.velocity.x = 0;
						fastCarCanDrive2 = true;
					}
				}
		
			function resetFastCar3():Void
				{
					if (FlxG.save.data.distractions)
					{
						fastCar3.x = 12600;
						fastCar3.velocity.x = 0;
						fastCarCanDrive3 = true;
					}
				}
		
			function resetFastCar4():Void
				{
					if (FlxG.save.data.distractions)
					{
						fastCar4.x = 12600;
						fastCar4.velocity.x = 0;
						fastCarCanDrive4 = true;
					}
				}
		
			function resetFastCar5():Void
				{
					if (FlxG.save.data.distractions)
					{
						fastCar5.x = 12600;
						fastCar5.velocity.x = 0;
						fastCarCanDrive5 = true;
					}
				}

				function fastCarDrivePizza()
					{
						if(FlxG.save.data.distractions){
							FlxG.sound.play(Paths.sound('Pizza'));
			
							fastCarPizza.velocity.x = -3000;
							fastCarCanDrivePizza = false;
							new FlxTimer().start(2, function(tmr:FlxTimer)
							{
								resetFastCarPizza();
							});
						}
					}

					function fastCarDriveBoi()
						{
							if(FlxG.save.data.distractions){
								fastCarBoi.velocity.x = -500;
								fastCarCanDriveBoi = false;
								new FlxTimer().start(10, function(tmr:FlxTimer)
								{
									resetFastCarBoi();
								});
							}
						}
		
			function fastCarDrive(sound:String = 'carPass', sprite:String = 'fastCarLol1', randomA:Int = 85, randomB:Int = 110) // lower the speed i guess -Z
			{
				if (FlxG.save.data.distractions && fastCarCanDrive)
				{
					fastCar.loadGraphic(Paths.image('act/cars/$sprite'));
		
					FlxG.sound.play(Paths.soundRandom(sound, 0, 1), 0.5);
		
		
					fastCar.velocity.x = (FlxG.random.int(randomA, randomB) / FlxG.elapsed) * 3; // this is the speed so no random timing bruh -Z
		
					fastCarCanDrive = false;
		
					new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						resetFastCar();
					});
				}
			}
		
			function fastCarDrive1(sound:String = 'carPass', sprite:String = 'fastCarLol1', randomA:Int = -85, randomB:Int = -110) // lower the speed i guess -Z
				{
					if (FlxG.save.data.distractions && fastCarCanDrive1)
					{
						fastCar1.loadGraphic(Paths.image('act/cars/$sprite'));
			
						FlxG.sound.play(Paths.soundRandom(sound, 0, 1), 0.5);
			
			
						fastCar1.velocity.x = (FlxG.random.int(randomA, randomB) / FlxG.elapsed) * 3; // this is the speed so no random timing bruh -Z
			
						fastCarCanDrive1 = false;
			
						new FlxTimer().start(2, function(tmr:FlxTimer)
						{
							resetFastCar1();
						});
					}
				}
		
			function fastCarDrive2()
				{
					if(FlxG.save.data.distractions){	
						FlxG.sound.play(Paths.sound('THEFRENCHSIREN')); 
						fastCar2.velocity.x = (FlxG.random.int(-127, -165) / FlxG.elapsed) * 3; // lower the speed i guess -Z
						fastCarCanDrive2 = false;
						new FlxTimer().start(2, function(tmr:FlxTimer)
						{
							resetFastCar2();
						});
					}
				}
		
			function fastCarDrive3()
				{
					if(FlxG.save.data.distractions){	
						FlxG.sound.play(Paths.sound('THEOTHERAMERICANSIREN'));
						fastCar3.velocity.x = (FlxG.random.int(-127, -165) / FlxG.elapsed) * 3;// lower the speed i guess -Z
						fastCarCanDrive3 = false;
						new FlxTimer().start(2, function(tmr:FlxTimer)
						{
							resetFastCar3();
						});
					}
				}
		
			function fastCarDrive4()
				{
					if(FlxG.save.data.distractions){	
						FlxG.sound.play(Paths.sound('THEAMERICANSIREN'));
						fastCar4.velocity.x = (FlxG.random.int(-127, -165) / FlxG.elapsed) * 3;// lower the speed i guess -Z
						fastCarCanDrive4 = false;
						new FlxTimer().start(2, function(tmr:FlxTimer)
						{
							resetFastCar4();
						});
					}
				}
		
			function fastCarDrive5()
				{
					if(FlxG.save.data.distractions){	
						FlxG.sound.play(Paths.soundRandom('vansfx', 1, 5), 5); // ooo payday 2 music -Z
						fastCar5.velocity.x = (FlxG.random.int(-127, -165) / FlxG.elapsed) * 3;// lower the speed i guess -Z
						fastCarCanDrive5 = false;
						new FlxTimer().start(2, function(tmr:FlxTimer)
						{
							resetFastCar5();
						});
					}
				}


	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		if(FlxG.save.data.distractions){
			trainMoving = true;
			if (!trainSound.playing)
				trainSound.play(true);
		}
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if(FlxG.save.data.distractions){
			if (trainSound.time >= 4700)
				{
					startedMoving = true;
					gf.playAnim('hairBlow');
				}
		
				if (startedMoving)
				{
					phillyTrain.x -= 400;
		
					if (phillyTrain.x < -2000 && !trainFinishing)
					{
						phillyTrain.x = -1150;
						trainCars -= 1;
		
						if (trainCars <= 0)
							trainFinishing = true;
					}
		
					if (phillyTrain.x < -4000 && trainFinishing)
						trainReset();
				}
		}

	}

	var frenzyTextAlreadyThere:Bool = false;

	var lastRandom:Int = 0;

	function randomFrenzyText():Void // Thanks shining this is very cool :D -Z
		{
			if (frenzyTextAlreadyThere == false)
			{
				frenzyTextAlreadyThere = true;
				FlxG.sound.play(Paths.soundRandom('glitchnoises', 1, 6), 15);
				var sprite:FlxSprite = new FlxSprite(250, 100);
				sprite.scale.set(0.5, 0.5);

				var cooleffect:FlxSprite = new FlxSprite(0, 0);
				var mhm:Int = FlxG.random.int(1, 4);
	
				var curShitisfasdmofa:Int = FlxG.random.int(1, 9);
	
				while (curShitisfasdmofa == lastRandom)
				{
					curShitisfasdmofa  = FlxG.random.int(1, 9);
				}

				while (mhm == lastRandom)
					{
						mhm  = FlxG.random.int(1, 4);
					}
	
				sprite.loadGraphic(Paths.image('frenzyRandom/' + curShitisfasdmofa, 'shared'));
				add(sprite);

				cooleffect.loadGraphic(Paths.image('frenzyRandom/glitch/' + mhm, 'shared')); // added this for you man :D -Z
				cooleffect.cameras = [camHUD];
				if (FlxG.random.bool(25))
					{
						add(cooleffect);
					}
				
				
	
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					remove(sprite);
					remove(cooleffect);
					new FlxTimer().start(5, function(tmr:FlxTimer)
						{
							frenzyTextAlreadyThere = false;
						});
	
					lastRandom = curShitisfasdmofa;
					lastRandom = mhm;
				});
			}
		}

	function trainReset():Void
	{
		if(FlxG.save.data.distractions){
			gf.playAnim('hairFall');
			phillyTrain.x = FlxG.width + 200;
			trainMoving = false;
			// trainSound.stop();
			// trainSound.time = 0;
			trainCars = 8;
			trainFinishing = false;
			startedMoving = false;
		}
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);
	}

	var danced:Bool = false;

	var beno1notplaying:Bool = false;
	var beno2notplaying:Bool = true;

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}
		
		if (curSong.toLowerCase() == 'exile' && curStep == 448 && !FlxG.save.data.Character) 
			{
				remove(dad);
                dad = new Character(dad.x, dad.y, 'benohappy');
				dad.setGraphicSize(Std.int(dad.width * 0.8));
				add(dad);
				//make it so it change the icon too, i'm too lazy rn with the dialogue BRUUh -Z
				//Still lazy even thoug the dialogue are done TWO DAYS LATER, i just don't feel like it's usefull to change it now, since it both same icon anyways -Z
			}

		if (curSong.toLowerCase() == 'echo' && !FlxG.save.data.Character)  // fixed lag when switching yay ;D -Z
			{
				if (curStep == 320 || curStep == 416 || curStep == 544 || curStep == 592 || curStep == 624 || curStep == 784 || curStep == 880 || curStep == 1088 || curStep == 1232)
					{
				remove(dad);
                dad = new Character(dad.x, dad.y, 'beno2');
				dad.setGraphicSize(Std.int(dad.width * 1.2));
				add(dad);
					}
					
				if (curStep == 352 || curStep == 448 || curStep == 576 || curStep == 608 || curStep == 640 || curStep == 800 || curStep == 976 || curStep == 1136)
				{
					remove(dad);
					dad = new Character(dad.x, dad.y, 'beno1');
					dad.setGraphicSize(Std.int(dad.width * 1.2));
					add(dad);
				}
			}

		if (curSong.toLowerCase() == 'echo-(erect-remix)' && !FlxG.save.data.Character)
			{
				if (FlxG.random.bool(1) && beno1notplaying == true)
				{
					beno1notplaying = false;
					beno2notplaying = true;
					remove(dad);
					dad = new Character(dad.x, dad.y, 'beno1');
					dad.setGraphicSize(Std.int(dad.width * 1.2));
					add(dad);
					//trace('hi beno1 spawnned');
				}
				
				if (FlxG.random.bool(1) && beno2notplaying == true)
				{
					beno1notplaying = true;
					beno2notplaying = false;
					remove(dad);
					dad = new Character(dad.x, dad.y, 'beno2');
					dad.setGraphicSize(Std.int(dad.width * 1.2));
					add(dad);
					//trace('hi beno2 spawnned');
				}
			}

		if (curSong.toLowerCase() == 'zhugolecturesyouaboutpiracy') 
			{
				if (curStep == 70)
					{
						boyfriend.y -= 1000;
						remove(dad);
						dad = new Character(dad.x, dad.y, 'madzhugo');
						add(dad);
					}
				if (FlxG.random.bool(2) && !FlxG.save.data.Lesslag) // background change -Z
				{
					FlxG.camera.shake(0.05, (60 / Conductor.bpm), null, true);
					thebg.animation.addByPrefix('BreakingDown1', 'Bgglitch1', 12, false);
					thebg.animation.addByPrefix('BreakingDown2', 'Bgglitch2', 8, false);
					thebg.animation.addByPrefix('BreakingDown3', 'Bgglitch3', 8, false);
					if (FlxG.random.bool(33))
						{
							thebg.animation.play('BreakingDown1', true);
							trace('sports');
						}
					if (FlxG.random.bool(33))
						{
							thebg.animation.play('BreakingDown2', true);
							trace('a');
						}
					if (FlxG.random.bool(33))
					{
						thebg.animation.play('BreakingDown3', true);
						trace('e');
					}
					thebg.antialiasing = true;
				}
				if (curStep == 1024 || curStep == 1328 || curStep == 1424 || curStep == 1453 || curStep == 1536 || curStep == 1553 || curStep == 1568 || curStep == 1712 || curStep == 2048 || curStep == 2080)
					{
						remove(dad);
						FlxG.camera.shake(0.05, (60 / Conductor.bpm), null, true);
						dad = new Character(dad.x, dad.y, 'glitchzhugo');
						thebg.animation.play('BreakingDown3', true);
						add(dad);
					}
				if (curStep == 1152 || curStep == 1340 || curStep == 1440 || curStep == 1472 || curStep == 1542 || curStep == 1562 || curStep == 1600  || curStep == 1728 || curStep == 2070 || curStep == 2100 || curStep == 2175)
					{
						remove(dad);
						FlxG.camera.shake(0.05, (60 / Conductor.bpm), null, true);
						dad = new Character(dad.x, dad.y, 'madzhugo');
						thebg.animation.play('BreakingDown2', true);
						add(dad);
					}
				if (curStep == 2204)
					{
						FlxG.camera.shake(0.05, (60 / Conductor.bpm), null, true);
						FlxG.camera.zoom += 0.25;
						remove(boyfriend);
						remove(corruptedgf);
						remove(dad);
						dad = new Character(dad.x, dad.y, 'zhugo');
						add(dad);
						remove(thebg);
						thebg = new FlxSprite(-300, 50);
						thebg.frames = Paths.getSparrowAtlas('server room/Serverroom','shared');
						thebg.animation.addByPrefix('BreakingDown2', 'Bgglitch2', 8, false);
						thebg.animation.play('BreakingDown2', true); //defauilt one at start -Z SHOULD NOT BE LOOPED !
						thebg.antialiasing = true;
						add(thebg);
					}
				
			}

			if (curSong.toLowerCase() == 'frenzy' && curStep == 815) // JOJO ?! -Z
				{
					dad.playAnim('jojo', true); // does it play it fully ? -Z
					new FlxTimer().start(2, function(tmr:FlxTimer)
						{
							dad.playAnim('idle', true);
						});
				}

// CARS CODE -Z
		if (curSong.toLowerCase() == 'frenzy' && curStep == 180 && fastCarCanDrive2) // cops car because fuck AAAAAAAAAAAAA -Z
			{
				fastCarDrive2(); // Cop -Z
			}
			if (curSong.toLowerCase() == 'frenzy' && curStep == 185 && fastCarCanDrive3) // cops car because fuck AAAAAAAAAAAAA -Z
			{
				fastCarDrive3(); // Cop -Z
			}
			if (curSong.toLowerCase() == 'frenzy' && curStep == 200 && fastCarCanDrive4) // cops car because fuck AAAAAAAAAAAAA -Z
			{
				fastCarDrive4(); // Cop -Z
			}
			if (curSong.toLowerCase() == 'frenzy' && curStep == 170 && fastCarCanDrive5) // VANNNNNNNNNNNNNNNNNN -Z
			{
				fastCarDrive5(); // Van -Z
			}

			if (curSong.toLowerCase() == 'echo' && curStep == 270 && fastCarCanDrivePizza)
				{
					fastCarDrivePizza();
				}
				if (curSong.toLowerCase() == 'frenzy' && curStep == 250 && fastCarCanDriveBoi)
					{
						fastCarDriveBoi();
					}

		if (SONG.song.toLowerCase() == 'frenzy')
			{
				if (curStep == 1056)
					 {
					ooooeffectlookcoolasfuck.visible = true;
					imonbruh = true;
					 }
				if (curStep == 1312)
					 {
					ooooeffectlookcoolasfuck.visible = false;
					imonbruh = false;
					 }
			}
			if (SONG.song.toLowerCase() == 'frenzy x megalovania')
				{
					if (curStep == 1040)
						 {
						ooooeffectlookcoolasfuck.visible = true;
						imonbruh = true;
						 }
					if (curStep == 1296)
						 {
						ooooeffectlookcoolasfuck.visible = false;
						imonbruh = false;
						 }
				}

		if (dad.curCharacter == 'gfpromise' && SONG.song.toLowerCase() == 'training' || SONG.song.toLowerCase() == 'training oldinst')
			{
				if (curStep == 12 || curStep == 140)
				{
					boyfriend.playAnim('hey', true);
					dad.playAnim('cheer', true);
				}
			}



		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curStep',curStep);
			luaModchart.executeState('stepHit',[curStep]);
		}
		#end

		// yes this updates every step.
		// yes this is bad
		// but i'm doing it to update misses and accuracy
		#if windows
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC,true,  songLength - Conductor.songPosition);
		#end

	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	var songEnded:Bool = false;


	var blblblbl:Bool = true;
	var fuckyou:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, (PlayStateChangeables.useDownscroll ? FlxSort.ASCENDING : FlxSort.DESCENDING));
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curBeat',curBeat);
			luaModchart.executeState('beatHit',[curBeat]);
		}
		#end

		if (curSong == 'Training' || curSong == 'Training oldinst' && dad.curCharacter == 'gfpromise') {
			if (curBeat % 2 == 1 && dad.animOffsets.exists('danceLeft'))
				dad.playAnim('danceLeft');
			if (curBeat % 2 == 0 && dad.animOffsets.exists('danceRight'))
				dad.playAnim('danceRight');
		}

		//GENERAL IDLES FIX, THIS IS THE BEST I CAN FOR NOW AND IT WORK. -Z
	if (!dad.animation.curAnim.name.startsWith("s") && !dad.animation.curAnim.name.startsWith("jojo") && !dad.animation.curAnim.name.startsWith("breakmic") && songEnded == false) // yes i put both "jojo", "breakmic", "s" animation there so they don't idle and just break the animation :D, S is for all the sings and knife animation -Z
		{
			dad.playAnim('idle'); // idle even when the camera is on him lol -Z
			//trace ('I default dad idle');
		}

	if (dad.animation.curAnim.name.startsWith('sing') && (dad.animation.curAnim.finished)) // best system i think of for idle, i know there the one in Character.hx, but it's just for safe, if the character one fails to idle somehow lmao -Z
		{ // no idea if it work, i don't need to know if it work, i don't want to know, just leave it there because i felt like it. -Z
			dad.dance();
			//trace ('Hello i dad idle after notes');
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
		//	if (SONG.notes[Math.floor(curStep / 16)].mustHitSection && dad.curCharacter != 'gfpromise' && songEnded == false)
			//	dad.dance();
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		if (FlxG.save.data.camzoom && !endingShown)
		{
			// ZOOOMMM !! -Z
			switch(curSong.toLowerCase()){
				case 'frenzied': 
					if (curBeat > 1 && curBeat < 24 || curBeat > 32 && curBeat < 156 || curBeat > 157 && curBeat < 224){
						FlxG.camera.zoom += 0.060;
						camHUD.zoom += 0.09;
						noteCam.zoom += 0.09;
					}
					switch(curStep){
						case 624 | 629 | 634 :
							FlxG.camera.zoom += 0.060;
							camHUD.zoom += 0.09;
							noteCam.zoom += 0.09;
					}	
				case 'nothing personal':
				if (curBeat > 1 && curBeat < 24){
					camHUD.zoom += 0.03;
					noteCam.zoom += 0.03; 
					}
				case 'your choice':
				if (curBeat > 80 && curBeat < 100 || curBeat > 208 && curBeat < 240){
					camHUD.zoom += 0.03;
					noteCam.zoom += 0.03; 
					}
			}
	
			if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
				{
					if (SONG.song.toLowerCase() != 'your choice' || SONG.song.toLowerCase() != 'nothing personal')
						{
					FlxG.camera.zoom += 0.015;
				}
					camHUD.zoom += 0.03;
				}
	
		}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));
			
		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (curBeat % gfSpeed == 0)
		{
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing") && songEnded == false)
			{
				boyfriend.playAnim('idle');
				if (health < 0.75 && curSong == 'Frenzy')
					{
						boyfriend.playAnim('scared', true);
					}	
				if (health < 0.75 && SONG.song.toLowerCase() == 'frenzy x megalovania')// fuck it -Z
					{
						boyfriend.playAnim('scared', true);
					}	
				if (health < 0.75 && curSong == 'Frenzied') // twise BECAUSE I CAN4T COMPRESS T§HEM WITHOUT GLITCH NO TOUCH SHINING -Z
					{
						boyfriend.playAnim('scared', true);
					}	// leave this code alone, i know it can be better.. wait....... to compress ... don't it need to have like "health <= 0.75" ? -Z
			}

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curSong.toLowerCase() == 'echo' || curSong.toLowerCase() == 'echo-(erect-remix)' || curStage == 'act1' || curStage == 'act2') // replace since beno want it actually :/ -Z
			{
				if(FlxG.save.data.distractions && !FlxG.save.data.Lesslag)
				{
					if (FlxG.random.bool(10) && fastCarCanDrive) // ahahah random go BRRRRRRRRRRRRRRRRRRRR -Z
					{
						fastCarDrive('carPass', 'fastCarLol'+FlxG.random.int(1, 12), FlxG.random.int(170, 200), FlxG.random.int(220, 250)); // left to right car -Z
					}

					if (FlxG.random.bool(10) && fastCarCanDrive1) // ahahah random go BRRRRRRRRRRRRRRRRRRRR -Z
					{
						fastCarDrive1('carPass', 'fastCarLol'+FlxG.random.int(1, 12), FlxG.random.int(-170, -200), FlxG.random.int(-220, -250)); // right to left car -Z
					}
				}
			}

		if (curSong.toLowerCase() == 'prodito') // i'm bad at coding, I KNOW -Z
			{
				if(FlxG.save.data.distractions && FlxG.save.data.Lesslag)
					{
					if (FlxG.random.bool(10) && fastCarCanDrive) // ahahah random go BRRRRRRRRRRRRRRRRRRRR -Z
						{
							fastCarDrive('carPass', 'fastCarLol'+FlxG.random.int(1, 12), FlxG.random.int(170, 200), FlxG.random.int(220, 250)); // left to right car -Z
						}
					}
			}


		switch (curStage)
		{
				case "act":
					if (!FlxG.save.data.Lesslag)
						{
					gfscared.animation.play('idle', true);
					if (curSong.toLowerCase() == 'prodito'){
					qsdf.animation.play('amongus');
					if (blblblbl){
					aaaaaa.animation.play('idle');
					}
					if (fuckyou){
						aaaaaa.animation.play('STOPPOSTINGABOUTAMONGUS'); // to uhh loop ? -Z
						}
					
						if (FlxG.random.bool(1) && blblblbl) // my head -Z
							{
							blblblbl = false;
							fuckyou = true; // WOOOOH LANGUAGE !! -Z
							FlxG.sound.play(Paths.sound('angrysorarant')); // sound into here stupid -Z
							new FlxTimer().start(32, function(tmr:FlxTimer) // AMONGUS -Z
								{
									blblblbl = true;
									fuckyou = false;
								});
					}
				}
			}
			
				//case "act1": // no since she is on the fucking uhhhhh bass -Z
				//	gfscared.animation.play('idle', true);
				case "act2":
					if (curSong.toLowerCase() == 'frenzy' && !FlxG.save.data.Lesslag){
					gfscared.animation.play('idlealt', true);
				}
				case "nothing":
				corruptedgf.animation.play('idle', true);
		}

		if (imonbruh)
		{
			ooooeffectlookcoolasfuck.animation.play('Effect', true); // Yeeet code -Z
			FlxG.camera.shake(0.015, (60 / Conductor.bpm), null, true, FlxAxes.X); // make the game shake every beat why that just bad ? may add later -Z
			noteCam.shake(0.010, (60 / Conductor.bpm), null, true, FlxAxes.X);
		}
	}

	var curLight:Int = 0;
	//Remember: to do, Delete all unused code for old fnf weeks, that will surely take lots of time, may not be worth it UHhh.... -Z
}