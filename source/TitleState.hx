package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import openfl.Assets;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class TitleState extends MusicBeatState
{	
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	override public function create():Void
	{
		#if html5 
		FlxG.switchState(new SongState()); 
		#end

		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Title screen", null);
		#end
		
		//#if polymod
		//polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
		//#end
		
		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "/assets/replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "/assets/replays");
		#end

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}
		
		PlayerSettings.init();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		super.create();

		// NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		FlxG.save.bind('funkin', 'ninjamuffin99');

		KadeEngineData.initSave();

		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
		#end
	}

	var jix:FlxSprite;
	var beno:FlxSprite;
	var character:FlxSprite;
	var rick:FlxSprite;
	var sticky:FlxSprite;
	var elise:FlxSprite;
	var pain:FlxSprite;
	var uhh1:FlxSprite;
	var uhh2:FlxSprite;
	var logoBl:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;
            
			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(105);
		persistentUpdate = true;
		
		var titlecardbackground:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('titlecardbackground'));
		titlecardbackground.setGraphicSize(Std.int(titlecardbackground.width * 1));
		titlecardbackground.updateHitbox();
		titlecardbackground.antialiasing = true;
		titlecardbackground.scrollFactor.set(1, 1);
		titlecardbackground.active = false;
		add(titlecardbackground);

		jix = new FlxSprite(1500, 0).loadGraphic(Paths.image('jixtitlecardPOSITIONREF'));
		jix.setGraphicSize(Std.int(jix.width * 0.7));
		jix.updateHitbox();
		jix.antialiasing = true;
		jix.scrollFactor.set(1, 1);
		jix.active = false;
		add(jix);

		elise = new FlxSprite(1500, 0).loadGraphic(Paths.image('Elise'));
		elise.setGraphicSize(Std.int(elise.width * 1));
		elise.updateHitbox();
		elise.antialiasing = true;
		elise.scrollFactor.set(1, 1);
		elise.active = false;
		elise.visible = false;
		add(elise);

		pain = new FlxSprite(1500, 200).loadGraphic(Paths.image('ayui_main_menu_left'));
		pain.setGraphicSize(Std.int(pain.width * 1));
		pain.updateHitbox();
		pain.antialiasing = true;
		pain.scrollFactor.set(1, 1);
		pain.active = false;
		pain.visible = false;
		add(pain);

		sticky  = new FlxSprite(1400, 200).loadGraphic(Paths.image('Sticky'));
		sticky.setGraphicSize(Std.int(sticky.width * 1));
		sticky.updateHitbox();
		sticky.antialiasing = true;
		sticky.scrollFactor.set(1, 1);
		sticky.active = false;
		sticky.visible = false;
		add(sticky);

		uhh1  = new FlxSprite(1400, 200).loadGraphic(Paths.image('3rd_main_menu_right'));
		uhh1.setGraphicSize(Std.int(uhh1.width * 1));
		uhh1.updateHitbox();
		uhh1.antialiasing = true;
		uhh1.scrollFactor.set(1, 1);
		uhh1.active = false;
		uhh1.visible = false;
		add(uhh1);

		uhh2  = new FlxSprite(1400, 200).loadGraphic(Paths.image('2nd_main_menu_e.e_right'));
		uhh2.setGraphicSize(Std.int(uhh2.width * 1));
		uhh2.updateHitbox();
		uhh2.antialiasing = true;
		uhh2.scrollFactor.set(1, 1);
		uhh2.active = false;
		uhh2.visible = false;
		add(uhh2);

		beno = new FlxSprite(1400, 0).loadGraphic(Paths.image('benotitlecard'));
		beno.setGraphicSize(Std.int(beno.width * 0.7));
		beno.updateHitbox();
		beno.antialiasing = true;
		beno.scrollFactor.set(1, 1);
		beno.active = false;
		add(beno);

		character = new FlxSprite(1400, 250).loadGraphic(Paths.image('fnf_alpha_cameo'));
		character.updateHitbox();
		character.antialiasing = true;
		character.scrollFactor.set(1, 1);
		character.active = false;
		add(character);
		remove(character);

		rick = new FlxSprite(1400, 100).loadGraphic(Paths.image('Rick'));
		rick.setGraphicSize(Std.int(rick.width * 4));
		rick.updateHitbox();
		rick.antialiasing = true;
		rick.scrollFactor.set(1, 1);
		rick.active = false;
		rick.visible = false;
		add(rick);

		logoBl = new FlxSprite(-1650, -100);
		logoBl.frames = Paths.getSparrowAtlas('LogoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		add(logoBl);

		var barthing:FlxSprite = new FlxSprite(0, 70).loadGraphic(Paths.image('pressenter')); // 0 maybe not correct since i already tried it anad it was offscreen check the other bar  shit
		barthing.setGraphicSize(Std.int(barthing.width * 0.6));
		barthing.updateHitbox();
		barthing.antialiasing = true;
		barthing.scrollFactor.set(1, 1);
		barthing.active = false;
		add(barthing);



		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = true;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = true;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro)
		{
			#if !switch
			NGio.unlockMedal(60960);

			// If it's Friday according to da clock
			if (Date.now().getDay() == 5)
				NGio.unlockMedal(61034);
			#end

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();
			FlxG.save.data.cpuStrums = true; // make the game load with the Ennemy arrow light up -Z
			FlxG.save.data.ghost = false; //make the game load without ghost typing -Z 
			// A great code was here, working at first, but was deleted because it destroy charts and everything in game :sob: -Z
			FlxG.save.data.scoreScreen = true; // Fucking code, fixed by this bruh, i spend so much time one this shit :sob: -Z
			MainMenuState.firstStart = true;

			new FlxTimer().start(1.5, function(tmr:FlxTimer)
			{
				#if html5 // am
				FlxG.switchState(new SongState()); // on
				#else // g
				FlxG.switchState(new MainMenuState());
				#end // s
			});
		}

		if (pressedEnter && !skippedIntro && initialized)
		{
			skipIntro();
		//	skipintothemainmenu();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	function moveCoolText()
	{
		var directionInt:Int = FlxG.random.int(1, 2);
		var directionBool:Bool = true;
		switch(directionInt)
		{
			case 1:
				directionBool = true;
			case 2:
				directionBool = false;
		}

		var munisDirectionInt:Int = FlxG.random.int(1, 2);
		var munisDirectionString:String = '';
		switch(munisDirectionInt)
		{
			case 1:
				munisDirectionString = '-';
			case 2:
				munisDirectionString = '';
		}

		for (i in 0...textGroup.members.length)
		{
			if (i != 0)
			{
				if (directionBool == true)
				{
					FlxTween.tween(
						textGroup.members[i],
						{x:munisDirectionString+1500},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
					FlxTween.tween(
						textGroup.members[i],
						{width:0},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
				}
				if (directionBool == false)
				{
					FlxTween.tween(
						textGroup.members[i],
						{y:munisDirectionString+1500},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
					FlxTween.tween(
						textGroup.members[i],
						{height:0},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
				}
			}
		}

		for (i in 0...credGroup.members.length)
		{
			if (i != 0)
			{
				if (directionBool == true)
				{
					FlxTween.tween(
						credGroup.members[i],
						{y:munisDirectionString+1500},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
					FlxTween.tween(
						credGroup.members[i],
						{height:0},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
				}
				if (directionBool == false)
				{
					FlxTween.tween(
						credGroup.members[i],
						{x:munisDirectionString+1500},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
					FlxTween.tween(
						credGroup.members[i],
						{width:0},0.7,
						{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
					}});
				}
			}
		}
	}

	override function beatHit()
	{
		super.beatHit();
		logoBl.animation.play('bump');
	}

	override function stepHit()
	{
		super.stepHit();

		FlxG.log.add(curStep);

		switch (curStep)
		{
			case 15:
					createCoolText(['Using', 'Kade Engine', 'created by']);
					addMoreText('KadeDeveloper');
			case 28:
				deleteCoolText();
				createCoolText(["Friday Night Funkin' by:"]);
			case 36:
				deleteCoolText();
				createCoolText(["These awesome dudes"]);
				addMoreText('');
				addMoreText('Ninjamuffin99');
				addMoreText('KawaiSprite');
				addMoreText('Phantom Arcade');
				addMoreText('Evilsk8er');
			case 52:
				deleteCoolText();
				addMoreText('Mod by');
				addMoreText('Harrowing Echoes');
				addMoreText('Mod Team');
			case 76:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);
				addMoreText(curWacky[1]);
			case 84:
				deleteCoolText();
				addMoreText('Friday');
			case 92:
				addMoreText('Night');
			case 96:
				addMoreText("Funkin'");
			case 100:
				addMoreText('Harrowing Echoes'); 
			case 104:
				addMoreText('Act Update'); 
			case 107:
				skipIntro();
		}
	}

	var skippedIntro:Bool = false;

function skipIntro():Void
	{
		if (!skippedIntro)
		{
			FlxG.mouse.visible = true;
			remove(ngSpr);

			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);

		// to do : Re do this code since sometimes character don't vanish and just overlaps smh, why nothing work as intended :c -Z
			if (FlxG.random.bool(7))
				{
					trace('THE MAN');
					beno.visible = false;
					sticky.visible = true;
					rick.visible = false;
					character.visible = false;
				}
			if (FlxG.random.bool(7))
				{
					trace('the new character');
					beno.visible = false;
					sticky.visible = false;
					rick.visible = false;
					character.visible = true; // you !! -Z
					add(character); // uh fix ? -Z
				}
			if (FlxG.random.bool(5))
				{
					trace('Secret two ?'); // fixed -Z
					uhh1.visible = true;
					uhh2.visible = false;
					jix.visible = false;
					elise.visible = false;
					pain.visible = false;
				}
			if (FlxG.random.bool(5))
				{
					trace('Bruh');
					uhh2.visible = true;
					jix.visible = false;
					elise.visible = false;
					pain.visible = false;
				}
			if (FlxG.random.bool(5))
				{
					trace('HII Uhh you ?'); // fixed -Z FIXED AGAIN ????????????????? -Z
					pain.visible = true;
					beno.visible = false;
					sticky.visible = false;
					uhh1.visible = false;
					uhh2.visible = false;
					rick.visible = false;
					character.visible = false;
				}
			if (FlxG.random.bool(0.1))
				{
					trace('Get Rick Roll lmfao');
					beno.visible = false;
					sticky.visible = false;
					uhh1.visible = false;
					uhh2.visible = false;
					rick.visible = true;
					character.visible = false;
					FlxG.sound.play(Paths.sound('Rick'));
					FlxG.sound.music.fadeIn(4, 0, 0.7);
				}
			if (FlxG.random.bool(5))
				{
					trace('HII ELISE!!');
					uhh1.visible = false;
					uhh2.visible = false;
					jix.visible = false;
					elise.visible = true;
					pain.visible = false;
				}


// this code is hard to remember xd -z
			

			FlxTween.tween(logoBl,{x: -150}, 1.4, {ease: FlxEase.expoInOut});
			FlxTween.tween(beno,{x: -100}, 3.5, {ease: FlxEase.expoInOut}); // beno last bruhruuhburh
			FlxTween.tween(character,{x: 600}, 3, {ease: FlxEase.expoInOut});
			FlxTween.tween(sticky,{x: 600}, 3.5, {ease: FlxEase.expoInOut});
			FlxTween.tween(pain,{x: 600}, 3, {ease: FlxEase.expoInOut});
			FlxTween.tween(uhh1,{x: 900}, 3, {ease: FlxEase.expoInOut});
			FlxTween.tween(uhh2,{x: 900}, 3, {ease: FlxEase.expoInOut});
			FlxTween.tween(rick,{x: 400}, 3.5, {ease: FlxEase.expoInOut});
			FlxTween.tween(jix,{x: 0}, 3, {ease: FlxEase.expoInOut}); // jix first followed by beno sprite
			FlxTween.tween(elise,{x: 900}, 3, {ease: FlxEase.expoInOut});
			

			logoBl.angle = -4;

			new FlxTimer().start(0.01, function(tmr:FlxTimer)
				{
					if(logoBl.angle == -4) 
						FlxTween.angle(logoBl, logoBl.angle, 4, 4, {ease: FlxEase.quartInOut});
					if (logoBl.angle == 4) 
						FlxTween.angle(logoBl, logoBl.angle, -4, 4, {ease: FlxEase.quartInOut});
				}, 0);

			skippedIntro = true;
		}
	}

	//function skipintothemainmenu():Void
//	{
	//	FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
//		#if html5 // am
	//	FlxG.switchState(new SongState()); // on
//		#else // g
//		MainMenuState.firstStart = true;
//		FlxG.switchState(new MainMenuState());
//		#end // 		
//	}
	
}
