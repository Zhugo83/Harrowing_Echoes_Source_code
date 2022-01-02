package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['Storymode', 'Freeplay', 'Discord', 'Options'];
	#else
	var optionShit:Array<String> = ['Storymode', 'Freeplay'];
	#end

	var menuItemText:FlxSprite;

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.3" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var logoBl:FlxSprite;
	var bg:FlxSprite;
	var magenta:FlxSprite;
	var versionShit:FlxText;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	override function create()
	{
		#if html5 
		FlxG.switchState(new SongState());
		#end
		
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Main Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-100).loadGraphic(Paths.image('transparant'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('transparant'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.alpha = 0;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		
		logoBl = new FlxSprite(735, -55);
		logoBl.scale.set(0.5, 0.5);
		logoBl.frames = Paths.getSparrowAtlas('LogoBumpin', 'preload');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		logoBl.scrollFactor.set();
		add(logoBl);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		menuItemText = new FlxSprite(20, -89).loadGraphic(Paths.image('menu/storytext', 'shared'));
		menuItemText.scale.set(0.31, 0.31);
		menuItemText.scrollFactor.set();
		menuItemText.antialiasing = true;
		add(menuItemText);

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.scale.set(0.7, 0.7);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.x += 25;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			finishedFunnyMove = true; 
			changeItem();

			if (firstStart)
				FlxTween.tween(menuItem,{y: 60 + (i * 160)},3 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
				{ 
					// lol -Z
				}});
			else
				menuItem.y = 60 + (i * 160);
		}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		versionShit = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + "Kade Engine " + kadeEngineVer + " Harrowing Echoes Build": "Friday Night Funkin'"), 32);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.BLUE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();

		
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		FlxG.mouse.visible = true;

		if (FlxG.keys.justPressed.F) // fullscreen yay :D -Z
			{
				FlxG.fullscreen = !FlxG.fullscreen;
			}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}
			if (FlxG.keys.justPressed.A)
			{
				FlxG.sound.music.pause();
				FlxG.sound.play(Paths.soundRandom('STOP_POSTING_ABOUT_', 1, 3), 1);
				new FlxTimer().start(48, function(tmr:FlxTimer)
					{
						FlxG.sound.music.play();
					});
			}
			if (FlxG.keys.justPressed.R)
				{
					FlxG.sound.music.pause();
					FlxG.sound.play(Paths.sound('wow'));
					new FlxTimer().start(4, function(tmr:FlxTimer)
						{
							FlxG.sound.music.play();
						});
				}
			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'Discord')
				{
					fancyOpenURL("https://discord.gg/xYeqKtnD6d");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr,{y: 1000, alpha: 0}, 1, {
								ease: FlxEase.quadOut,
								onComplete: function(flxTween:FlxTween) 
								{
									spr.kill();
								}
							});

							FlxTween.tween(bg,{y: 1000, alpha: 0}, 0.5, {
								ease: FlxEase.quadOut,
								onComplete: function(flxTween:FlxTween) 
								{
								}
							});

							FlxTween.tween(magenta,{y: 1000, alpha: 0}, 0.1, {
								ease: FlxEase.quadOut,
								onComplete: function(flxTween:FlxTween) 
								{
								}
							});

							FlxTween.tween(menuItemText,{y: 1000, alpha: 0}, 0.3, {
								ease: FlxEase.quadOut,
								onComplete: function(flxTween:FlxTween) 
								{
								}
							});

							FlxTween.tween(versionShit,{y: 1000, alpha: 0}, 1, {
								ease: FlxEase.quadOut,
								onComplete: function(flxTween:FlxTween) 
								{
								}
							});

							FlxTween.tween(logoBl,{y: 1000, alpha: 0}, 0.7, {
								ease: FlxEase.quadOut,
								onComplete: function(flxTween:FlxTween) 
								{
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'Storymode':
				#if html5 
				FlxG.switchState(new SongState());
				#else 
				FlxG.switchState(new StoryMenuState());
				#end // can't stop me -Z
			case 'Freeplay':
				#if html5 
				FlxG.switchState(new SongState()); 
				#else 
				FlxG.switchState(new NewFreeplaystate());
				#end // I'll be here -Z
			case 'Options':
				#if html5 
				FlxG.switchState(new SongState());
				#else 
				FlxG.switchState(new OptionsMenu());
				#end // Watching YOU ! -Z
		}
	}

	function changeItem(huh:Int = 0)
	{

		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);

				switch(spr.ID)
				{
					case 0:
						remove(menuItemText);
						menuItemText.loadGraphic(Paths.image('menu/storytext', 'shared'));
						add(menuItemText);
					case 1:
						remove(menuItemText);
						menuItemText.loadGraphic(Paths.image('menu/freeplaytext', 'shared'));
						add(menuItemText);
					case 2:
						remove(menuItemText);
						menuItemText.loadGraphic(Paths.image('menu/discordtext', 'shared'));
						add(menuItemText);
					case 3:
						remove(menuItemText);
						menuItemText.loadGraphic(Paths.image('menu/optionstext', 'shared'));
						add(menuItemText);
				}
			}

			spr.updateHitbox();
		});
	}
}
