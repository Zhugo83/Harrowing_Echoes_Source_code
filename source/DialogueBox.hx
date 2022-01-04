package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var skippedDialogue:Bool = false;
	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitLeftone:FlxSprite;
	var portraitLeftJixsuspence:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitRightone:FlxSprite;
	var portraitRighttwo:FlxSprite;
	var portraitRightGf:FlxSprite;
	var portraitRightGfshock:FlxSprite;
	var portraitRightGfphone:FlxSprite;
	var portraitRightGfphoneshock:FlxSprite;
	var portraitRightBeno:FlxSprite;
	var portraitRightBenoshocked:FlxSprite;
	var portraitRightBenosad:FlxSprite;
	var portraitRightBenodots:FlxSprite;
	var portraitRightBenohappy:FlxSprite;
	var portraitRightCutscene:FlxSprite;
	var portraitRightCutscene2:FlxSprite;
	var portraitRightJixshadow:FlxSprite;
	var portraitRightJixreveal:FlxSprite;
	var portraitRightNothing:FlxSprite;
	var portraitRightJixtalk:FlxSprite;
	var portraitRightJixhappy:FlxSprite;
	var portraitLeftJixsad:FlxSprite;
	var portraitRightCutscene3:FlxSprite;
	var portraitRightCutscene4:FlxSprite;
	var portraitRightCutscene5:FlxSprite;
	var portraitRightCutscene6:FlxSprite;
	var portraitRightCutscene7:FlxSprite;
	var portraitRightCutscene8:FlxSprite;
	var portraitRightCutscene9:FlxSprite;
	var portraitRightCutscene10:FlxSprite;

	// WHAT THE FUCK IT THIS qmlkfghsdmlzrhl -Z
	var portraitkillme:FlxSprite;
	var dadportrait:FlxSprite;

	public static var isStoryMode:Bool = false;

	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'nothing personal':
				FlxG.sound.playMusic(Paths.music('Nothing'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'your choice':
				FlxG.sound.playMusic(Paths.music('Nothing'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'training':
				FlxG.sound.playMusic(Paths.music('Nothing'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'prodito':
				FlxG.sound.playMusic(Paths.music('Lovely_View'), 0); // change when got the music by xav bruh
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'echo':
				FlxG.sound.playMusic(Paths.music('Nothing'), 0); // here too btw
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'frenzy':
				FlxG.sound.playMusic(Paths.music('Nothing'), 0); // same here
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'exile':
				FlxG.sound.playMusic(Paths.music('Nothing'), 0); // Hiii :D
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}


		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
		bgFade.scrollFactor.set();
		bgFade.alpha = 1;
		add(bgFade);

		var fadeTime:Float = 0.83; //how long it takes to fully fade
        var bgAlpha:Float = 0.7; //alpha for the bg
        switch(PlayState.SONG.song.toLowerCase())
        {
            case 'your choice':
                bgAlpha = 1; //makes it just black
                new FlxTimer().start(fadeTime, function(tmr:FlxTimer)
                {
                    bgFade.alpha += (1 / 5) * bgAlpha;
                    if (bgFade.alpha > bgAlpha)
                        bgFade.alpha = bgAlpha;
                }, 5);
            case 'nothing personal':
                bgAlpha = 0.75; //makes it 0.5 alpha
                new FlxTimer().start(fadeTime, function(tmr:FlxTimer)
                {
                    bgFade.alpha += (1 / 5) * bgAlpha;
                    if (bgFade.alpha > bgAlpha)
                        bgFade.alpha = bgAlpha;
                }, 5);
            case 'training':
                bgAlpha = 0.75; //makes it 0.5 alpha
                new FlxTimer().start(fadeTime, function(tmr:FlxTimer)
                {
                    bgFade.alpha += (1 / 5) * bgAlpha;
                    if (bgFade.alpha > bgAlpha)
                        bgFade.alpha = bgAlpha;
                }, 5);
            case 'prodito':
                bgAlpha = 0.75; //makes it 0.5 alpha
                new FlxTimer().start(fadeTime, function(tmr:FlxTimer)
                {
                    bgFade.alpha += (1 / 5) * bgAlpha;
                    if (bgFade.alpha > bgAlpha)
                        bgFade.alpha = bgAlpha;
                }, 5);
            case 'echo':
                bgAlpha = 0.75; //makes it 0.5 alpha
                new FlxTimer().start(fadeTime, function(tmr:FlxTimer)
                {
                    bgFade.alpha += (1 / 5) * bgAlpha;
                    if (bgFade.alpha > bgAlpha)
                        bgFade.alpha = bgAlpha;
                }, 5);
        }

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'nothing personal':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				box.animation.addByPrefix('normalOpen', 'AHH speech bubble', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 170;
                box.height = 48;
                box.x = 0;
                box.y = 450;


			case 'your choice':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				box.animation.addByPrefix('normalOpen', 'AHH speech bubble', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 170;
                box.height = 48;
                box.x = 0;
                box.y = 450;
			case 'training':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				box.animation.addByPrefix('normalOpen', 'AHH speech bubble', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 170;
                box.height = 48;
                box.x = 0;
                box.y = 450;
			case 'prodito':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				box.animation.addByPrefix('normalOpen', 'AHH speech bubble', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 170;
                box.height = 48;
                box.x = 0;
                box.y = 450;
			case 'echo':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				box.animation.addByPrefix('normalOpen', 'AHH speech bubble', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 170;
                box.height = 48;
                box.x = 0;
                box.y = 450;
			case 'frenzy':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				box.animation.addByPrefix('normalOpen', 'AHH speech bubble', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 170;
                box.height = 48;
                box.x = 0;
                box.y = 450;
			case 'exile':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				box.animation.addByPrefix('normalOpen', 'AHH speech bubble', 24, false);
				box.animation.addByIndices('normal', 'AHH speech bubble', [4], "", 24);
				box.width = 170;
                box.height = 48;
                box.x = 0;
                box.y = 450;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		// i know there a fucking "enter" that is a warning in the debug mode, i don't have TIME to find it so FUCK IT >:C -Z

		portraitkillme = new FlxSprite(0, 0);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/beachfadein');
		portraitkillme.animation.addByPrefix('enter', 'Cutscene Enter instance', 24, false);
		portraitkillme.setGraphicSize(Std.int(portraitkillme.width * 0.67));
		portraitkillme.updateHitbox();
		portraitkillme.scrollFactor.set();
		add(portraitkillme);
		portraitkillme.visible = false;

		portraitLeftone = new FlxSprite(-100, -250);
	//	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benotalk');
		portraitLeftone.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.80));
		portraitLeftone.updateHitbox();
		portraitLeftone.scrollFactor.set();
		portraitLeftone.flipX = true; // should work, because it's the master ?????? -Z
		add(portraitLeftone);
		portraitLeftone.visible = false;

		portraitRightone = new FlxSprite(500, -200);
	//	portraitRightone.frames = Paths.getSparrowAtlas('portraits/act1/gftalk');
		portraitRightone.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightone.setGraphicSize(Std.int(portraitRightone.width * 0.80));
		portraitRightone.updateHitbox();
		portraitRightone.scrollFactor.set();
		add(portraitRightone);
		portraitRightone.visible = false;

		portraitRighttwo = new FlxSprite(400, -250);
	//	portraitRighttwo.frames = Paths.getSparrowAtlas('portraits/act1/bftalk');
		portraitRighttwo.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRighttwo.setGraphicSize(Std.int(portraitRighttwo.width * 0.80));
		portraitRighttwo.updateHitbox();
		portraitRighttwo.scrollFactor.set();
		add(portraitRighttwo);
		portraitRighttwo.visible = false;

		dadportrait = new FlxSprite(300, 100);
		dadportrait.frames = Paths.getSparrowAtlas('portraits/DDtalkphone');
		dadportrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		dadportrait.setGraphicSize(Std.int(dadportrait.width * 0.80));
		dadportrait.updateHitbox();
		dadportrait.scrollFactor.set();
		add(dadportrait);
		dadportrait.visible = false;


		portraitLeft = new FlxSprite(-20, 40);
	//	portraitLeft.frames = Paths.getSparrowAtlas('portraits/jix_suspense');
	//	portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
		
		portraitLeftJixsuspence = new FlxSprite(0, 0);
		portraitLeftJixsuspence.frames = Paths.getSparrowAtlas('portraits/jix_suspense');
		portraitLeftJixsuspence.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeftJixsuspence.setGraphicSize(Std.int(portraitLeftJixsuspence.width * PlayState.daPixelZoom * -1));
		portraitLeftJixsuspence.updateHitbox();
		portraitLeftJixsuspence.scrollFactor.set();
		add(portraitLeftJixsuspence);
		portraitLeftJixsuspence.visible = false;

		portraitLeftJixsad = new FlxSprite(0, 0);
		portraitLeftJixsad.frames = Paths.getSparrowAtlas('portraits/jix_sad');
		portraitLeftJixsad.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeftJixsad.setGraphicSize(Std.int(portraitLeftJixsad.width * PlayState.daPixelZoom * -1));
		portraitLeftJixsad.updateHitbox();
		portraitLeftJixsad.scrollFactor.set();
		add(portraitLeftJixsad);
		portraitLeftJixsad.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('prologue/weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitRightGf = new FlxSprite(-65, 75);
		portraitRightGf.frames = Paths.getSparrowAtlas('portraits/GF_talking');
		portraitRightGf.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightGf.setGraphicSize(Std.int(portraitRightGf.width * PlayState.daPixelZoom * -1));
		portraitRightGf.updateHitbox();
		portraitRightGf.scrollFactor.set();
		add(portraitRightGf);
		portraitRightGf.visible = false;

		portraitRightGfshock = new FlxSprite(-65, 75);
		portraitRightGfshock.frames = Paths.getSparrowAtlas('portraits/GF_shock');
		portraitRightGfshock.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightGfshock.setGraphicSize(Std.int(portraitRightGfshock.width * PlayState.daPixelZoom * -1));
		portraitRightGfshock.updateHitbox();
		portraitRightGfshock.scrollFactor.set();
		add(portraitRightGfshock);
		portraitRightGfshock.visible = false;

		portraitRightGfphone = new FlxSprite(-65, 75);
		portraitRightGfphone.frames = Paths.getSparrowAtlas('portraits/GF_phone_look');
		portraitRightGfphone.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightGfphone.setGraphicSize(Std.int(portraitRightGfphone.width * PlayState.daPixelZoom * -1));
		portraitRightGfphone.updateHitbox();
		portraitRightGfphone.scrollFactor.set();
		add(portraitRightGfphone);
		portraitRightGfphone.visible = false;

		portraitRightGfphoneshock = new FlxSprite(-65, 75);
		portraitRightGfphoneshock.frames = Paths.getSparrowAtlas('portraits/GF_phone');
		portraitRightGfphoneshock.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightGfphoneshock.setGraphicSize(Std.int(portraitRightGfphoneshock.width * PlayState.daPixelZoom * -1));
		portraitRightGfphoneshock.updateHitbox();
		portraitRightGfphoneshock.scrollFactor.set();
		add(portraitRightGfphoneshock);
		portraitRightGfphoneshock.visible = false;

		portraitRightBeno = new FlxSprite(-70, 30);
		portraitRightBeno.frames = Paths.getSparrowAtlas('portraits/BEANS_talk_2');
		portraitRightBeno.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightBeno.setGraphicSize(Std.int(portraitRightBeno.width * PlayState.daPixelZoom * -1));
		portraitRightBeno.updateHitbox();
		portraitRightBeno.scrollFactor.set();
		add(portraitRightBeno);
		portraitRightBeno.visible = false;

		portraitRightBenoshocked = new FlxSprite(-70, 30);
		portraitRightBenoshocked.frames = Paths.getSparrowAtlas('portraits/BEANS_shocked');
		portraitRightBenoshocked.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightBenoshocked.setGraphicSize(Std.int(portraitRightBenoshocked.width * PlayState.daPixelZoom * -1));
		portraitRightBenoshocked.updateHitbox();
		portraitRightBenoshocked.scrollFactor.set();
		add(portraitRightBenoshocked);
		portraitRightBenoshocked.visible = false;

		portraitRightBenosad = new FlxSprite(-70, 30);
		portraitRightBenosad.frames = Paths.getSparrowAtlas('portraits/BEANS_sadboihours');
		portraitRightBenosad.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightBenosad.setGraphicSize(Std.int(portraitRightBenosad.width * PlayState.daPixelZoom * -1));
		portraitRightBenosad.updateHitbox();
		portraitRightBenosad.scrollFactor.set();
		add(portraitRightBenosad);
		portraitRightBenosad.visible = false;

		portraitRightBenodots = new FlxSprite(-70, 30);
		portraitRightBenodots.frames = Paths.getSparrowAtlas('portraits/BEANS_dots');
		portraitRightBenodots.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightBenodots.setGraphicSize(Std.int(portraitRightBenodots.width * PlayState.daPixelZoom * -1));
		portraitRightBenodots.updateHitbox();
		portraitRightBenodots.scrollFactor.set();
		add(portraitRightBenodots);
		portraitRightBenodots.visible = false;

		portraitRightBenohappy = new FlxSprite(-70, 30);
		portraitRightBenohappy.frames = Paths.getSparrowAtlas('portraits/BEANS_haha');
		portraitRightBenohappy.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightBenohappy.setGraphicSize(Std.int(portraitRightBenohappy.width * PlayState.daPixelZoom * -1));
		portraitRightBenohappy.updateHitbox();
		portraitRightBenohappy.scrollFactor.set();
		add(portraitRightBenohappy);
		portraitRightBenohappy.visible = false;

		portraitRightCutscene = new FlxSprite(0, 0);
		portraitRightCutscene.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene');
		portraitRightCutscene.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene.setGraphicSize(Std.int(portraitRightCutscene.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene.updateHitbox();
		portraitRightCutscene.scrollFactor.set();
		add(portraitRightCutscene);
		portraitRightCutscene.visible = false;

		portraitRightCutscene2 = new FlxSprite(0, 0);
		portraitRightCutscene2.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene2');
		portraitRightCutscene2.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene2.setGraphicSize(Std.int(portraitRightCutscene2.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene2.updateHitbox();
		portraitRightCutscene2.scrollFactor.set();
		add(portraitRightCutscene2);
		portraitRightCutscene2.visible = false;

		portraitRightJixshadow = new FlxSprite(0, 0);
		portraitRightJixshadow.frames = Paths.getSparrowAtlas('portraits/Cutscene/jixshadow');
		portraitRightJixshadow.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightJixshadow.setGraphicSize(Std.int(portraitRightJixshadow.width * PlayState.daPixelZoom * 0.0835));
		portraitRightJixshadow.updateHitbox();
		portraitRightJixshadow.scrollFactor.set();
		add(portraitRightJixshadow);
		portraitRightJixshadow.visible = false;

		portraitRightJixreveal = new FlxSprite(0, 0);
		portraitRightJixreveal.frames = Paths.getSparrowAtlas('portraits/Cutscene/jixreveal');
		portraitRightJixreveal.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightJixreveal.setGraphicSize(Std.int(portraitRightJixreveal.width * PlayState.daPixelZoom * 0.0835));
		portraitRightJixreveal.updateHitbox();
		portraitRightJixreveal.scrollFactor.set();
		add(portraitRightJixreveal);
		portraitRightJixreveal.visible = false;

		portraitRightNothing = new FlxSprite(0, 0);
		portraitRightNothing.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		portraitRightNothing.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightNothing.setGraphicSize(Std.int(portraitRightNothing.width * PlayState.daPixelZoom * -1));
		portraitRightNothing.updateHitbox();
		portraitRightNothing.scrollFactor.set();
		add(portraitRightNothing);
		portraitRightNothing.visible = false;

		portraitRightJixhappy = new FlxSprite(0, 0);
		portraitRightJixhappy.frames = Paths.getSparrowAtlas('portraits/jix_happy');
		portraitRightJixhappy.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightJixhappy.setGraphicSize(Std.int(portraitRightJixhappy.width * PlayState.daPixelZoom * -1));
		portraitRightJixhappy.updateHitbox();
		portraitRightJixhappy.scrollFactor.set();
		add(portraitRightJixhappy);
		portraitRightJixhappy.visible = false;

		portraitRightJixtalk = new FlxSprite(0, 0);
		portraitRightJixtalk.frames = Paths.getSparrowAtlas('portraits/jix_talk');
		portraitRightJixtalk.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightJixtalk.setGraphicSize(Std.int(portraitRightJixtalk.width * PlayState.daPixelZoom * -1));
		portraitRightJixtalk.updateHitbox();
		portraitRightJixtalk.scrollFactor.set();
		add(portraitRightJixtalk);
		portraitRightJixtalk.visible = false;

		portraitRightCutscene3 = new FlxSprite(0, 0);
		portraitRightCutscene3.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene3'); // yes yes there is a black texture that it's unused because i made it duh -Z
		portraitRightCutscene3.animation.addByPrefix('enter', 'Portrait Enter instance', 5, false);
		portraitRightCutscene3.setGraphicSize(Std.int(portraitRightCutscene3.width * PlayState.daPixelZoom * 0.167));
		portraitRightCutscene3.updateHitbox();
		portraitRightCutscene3.scrollFactor.set();
		add(portraitRightCutscene3);
		portraitRightCutscene3.visible = false;

		portraitRightCutscene4 = new FlxSprite(0, 0);
		portraitRightCutscene4.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene4');
		portraitRightCutscene4.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene4.setGraphicSize(Std.int(portraitRightCutscene4.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene4.updateHitbox();
		portraitRightCutscene4.scrollFactor.set();
		add(portraitRightCutscene4);
		portraitRightCutscene4.visible = false;

		portraitRightCutscene5 = new FlxSprite(0, 0);
		portraitRightCutscene5.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene5');
		portraitRightCutscene5.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene5.setGraphicSize(Std.int(portraitRightCutscene5.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene5.updateHitbox();
		portraitRightCutscene5.scrollFactor.set();
		add(portraitRightCutscene5);
		portraitRightCutscene5.visible = false;

		portraitRightCutscene6 = new FlxSprite(0, 0);
		portraitRightCutscene6.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene6');
		portraitRightCutscene6.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene6.setGraphicSize(Std.int(portraitRightCutscene6.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene6.updateHitbox();
		portraitRightCutscene6.scrollFactor.set();
		add(portraitRightCutscene6);
		portraitRightCutscene6.visible = false;

		portraitRightCutscene7 = new FlxSprite(0, 0);
		portraitRightCutscene7.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene7');
		portraitRightCutscene7.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene7.setGraphicSize(Std.int(portraitRightCutscene7.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene7.updateHitbox();
		portraitRightCutscene7.scrollFactor.set();
		add(portraitRightCutscene7);
		portraitRightCutscene7.visible = false;

		portraitRightCutscene8 = new FlxSprite(0, 0);
		portraitRightCutscene8.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene8');
		portraitRightCutscene8.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene8.setGraphicSize(Std.int(portraitRightCutscene8.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene8.updateHitbox();
		portraitRightCutscene8.scrollFactor.set();
		add(portraitRightCutscene8);
		portraitRightCutscene8.visible = false;

		portraitRightCutscene9 = new FlxSprite(0, 0);
		portraitRightCutscene9.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene9');
		portraitRightCutscene9.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene9.setGraphicSize(Std.int(portraitRightCutscene9.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene9.updateHitbox();
		portraitRightCutscene9.scrollFactor.set();
		add(portraitRightCutscene9);
		portraitRightCutscene9.visible = false;

		portraitRightCutscene10 = new FlxSprite(0, 0);
		portraitRightCutscene10.frames = Paths.getSparrowAtlas('portraits/Cutscene/Cutscene10');
		portraitRightCutscene10.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitRightCutscene10.setGraphicSize(Std.int(portraitRightCutscene10.width * PlayState.daPixelZoom * 0.0835));
		portraitRightCutscene10.updateHitbox();
		portraitRightCutscene10.scrollFactor.set();
		add(portraitRightCutscene10);
		portraitRightCutscene10.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		var somuchpain:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('act/skip'));
		somuchpain.updateHitbox();
		somuchpain.antialiasing = true;
		somuchpain.active = true;
		add(somuchpain);

		

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 50);
		dropText.font = 'Doppler';
		dropText.color = 0xFF00B9FF;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 50);
		swagDialogue.font = 'Doppler';
		swagDialogue.color = 0xFFFFFFFF;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		if (PlayState.SONG.song.toLowerCase() == 'prodito' || PlayState.SONG.song.toLowerCase() == 'echo' || PlayState.SONG.song.toLowerCase() == 'frenzy' || PlayState.SONG.song.toLowerCase() == 'exile')
			{
				dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 50);
				dropText.font = 'Purista-SemiBold';
				dropText.color = 0xFF00B9FF;
				add(dropText);
		
				swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 50);
				swagDialogue.font = 'Purista-SemiBold';
				swagDialogue.color = 0xFFFFFFFF;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				add(swagDialogue);
			}
		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		if (FlxG.keys.justPressed.SPACE)
			{
				skipDialogue();
			}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				//box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ENTER  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('Textsilence'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'frenzy' || PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'nothing personal' || PlayState.SONG.song.toLowerCase() == 'nothing-personal' || PlayState.SONG.song.toLowerCase() == 'your choice' || PlayState.SONG.song.toLowerCase() == 'your-choice' || PlayState.SONG.song.toLowerCase() == 'training' || PlayState.SONG.song.toLowerCase() == 'prodito' || PlayState.SONG.song.toLowerCase() == 'echo')
						FlxG.sound.music.fadeOut(0.1, 0);
					else if (PlayState.SONG.song.toLowerCase() == 'exile')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeftone.visible = false;
						portraitRightone.visible = false;
						portraitRighttwo.visible = false;
						portraitLeft.visible = false;
						portraitLeftJixsuspence.visible = false;
						portraitLeftJixsad.visible = false;
						portraitRight.visible = false;
						portraitRightGf.visible = false;
						portraitRightGfshock.visible = false;
						portraitRightGfphone.visible = false;
						portraitRightGfphoneshock.visible = false;
						portraitRightBeno.visible = false;
						portraitRightBenoshocked.visible = false;
						portraitRightBenosad.visible = false;
						portraitRightBenodots.visible = false;
						portraitRightBenohappy.visible = false;
						portraitRightCutscene.visible = false;
						portraitRightCutscene2.visible = false;
						portraitRightJixshadow.visible = false;
						portraitRightJixreveal.visible = false;
						portraitRightNothing.visible = false;
						portraitRightJixtalk.visible = false;
						portraitRightJixhappy.visible = false;
						portraitRightCutscene3.visible = false;
						portraitRightCutscene4.visible = false;
						portraitRightCutscene5.visible = false;
						portraitRightCutscene6.visible = false;
						portraitRightCutscene7.visible = false;
						portraitRightCutscene8.visible = false;
						portraitRightCutscene9.visible = false;
						portraitRightCutscene10.visible = false;
						portraitkillme.visible = false;
						dadportrait.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(0, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.06, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					//portraitLeft.animation.play('enter');
				}
			case 'jixsuspense':
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('jix_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitLeftJixsuspence.visible)
				{
					portraitLeftJixsuspence.visible = true;
					portraitLeftJixsuspence.animation.play('enter');
				}
			case 'jixsad':
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('jix_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitLeftJixsad.visible)
				{
					portraitLeftJixsad.visible = true;
					portraitLeftJixsad.animation.play('enter');
				}
				case 'jixmusic':
					portraitRight.visible = false;
					portraitRightGf.visible = false;
					portraitRightGfshock.visible = false;
					portraitRightGfphone.visible = false;
					portraitRightGfphoneshock.visible = false;
					portraitRightBeno.visible = false;
					portraitRightBenoshocked.visible = false;
					portraitRightBenosad.visible = false;
					portraitRightBenodots.visible = false;
					portraitRightBenohappy.visible = false;
					portraitRightCutscene.visible = false;
					portraitRightCutscene2.visible = false;
					portraitRightJixshadow.visible = false;
					portraitRightJixreveal.visible = false;
					portraitRightNothing.visible = false;
					portraitRightJixtalk.visible = false;
					portraitRightJixhappy.visible = false;
					portraitLeftJixsad.visible = false;
					portraitRightCutscene3.visible = false;
					portraitRightCutscene4.visible = false;
					portraitRightCutscene5.visible = false;
					portraitRightCutscene6.visible = false;
					portraitRightCutscene7.visible = false;
					portraitRightCutscene8.visible = false;
					portraitRightCutscene9.visible = false;
					portraitRightCutscene10.visible = false;
					FlxG.sound.play(Paths.sound('clickText'), 0.4);
					box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
					swagDialogue.sounds = [FlxG.sound.load(Paths.sound('jix_talktext'), 0.5)];
					swagDialogue.start(0.06, true);
					FlxG.sound.playMusic(Paths.music('Tense_BGM'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
					if (!portraitLeftJixsuspence.visible)
					{
						portraitLeftJixsuspence.visible = true;
						portraitLeftJixsuspence.animation.play('enter');
					}
			case 'bfpixel':
				portraitLeftJixsuspence.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfprologue_talktext'), 0.6)];
				swagDialogue.start(0.06, true);
				if (!portraitRightGf.visible)
				{
					portraitRightGf.visible = true;
					portraitRightGf.animation.play('enter');
				}
			case 'gfshock':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfprologue_talktext'), 0.6)];
				swagDialogue.start(0.06, true);
				if (!portraitRightGfshock.visible)
				{
					portraitRightGfshock.visible = true;
					portraitRightGfshock.animation.play('enter');
				}
			case 'gfphone':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfprologue_talktext'), 0.6)];
				swagDialogue.start(0.06, true);
				if (!portraitRightGf.visible)
				{
					portraitRightGfphone.visible = true;
					portraitRightGfphone.animation.play('enter');
				}
			case 'gfphoneshock':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfprologue_talktext'), 0.6)];
				swagDialogue.start(0.06, true);
				if (!portraitRightGfphoneshock.visible)
				{
					portraitRightGfphoneshock.visible = true;
					portraitRightGfphoneshock.animation.play('enter');
				}
			case 'beno':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benoprologue_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitRightBeno.visible)
				{
					portraitRightBeno.visible = true;
					portraitRightBeno.animation.play('enter');
				}
			case 'benomusic':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benoprologue_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				FlxG.sound.playMusic(Paths.music('Chill_BGM'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				if (!portraitRightBeno.visible)
				{
					portraitRightBeno.visible = true;
					portraitRightBeno.animation.play('enter');
				}
			case 'benoshocked':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benoprologue_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitRightBenoshocked.visible)
				{
					portraitRightBenoshocked.visible = true;
					portraitRightBenoshocked.animation.play('enter');
				}
			case 'benosad':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benoprologue_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitRightBenosad.visible)
				{
					portraitRightBenosad.visible = true;
					portraitRightBenosad.animation.play('enter');
				}
			case 'benodots':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benoprologue_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitRightBenodots.visible)
				{
					portraitRightBenodots.visible = true;
					portraitRightBenodots.animation.play('enter');
				}
			case 'benohappy':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benoprologue_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitRightBenohappy.visible)
				{
					portraitRightBenohappy.visible = true;
					portraitRightBenohappy.animation.play('enter');
				}
			case 'cutscene':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				swagDialogue.start(0.05, true);
				if (!portraitRightCutscene.visible)
				{
					portraitRightCutscene.visible = true;
					portraitRightCutscene.animation.play('enter');
				}
				case 'cutsceneb':
					portraitLeftJixsuspence.visible = false;
					portraitRight.visible = false;
					portraitRightGf.visible = false;
					portraitRightGfshock.visible = false;
					portraitRightGfphone.visible = false;
					portraitRightGfphoneshock.visible = false;
					portraitRightBeno.visible = false;
					portraitRightBenoshocked.visible = false;
					portraitRightBenosad.visible = false;
					portraitRightBenodots.visible = false;
					portraitRightBenohappy.visible = false;
					portraitRightCutscene2.visible = false;
					portraitRightJixshadow.visible = false;
					portraitRightJixreveal.visible = false;
					portraitRightNothing.visible = false;
					portraitRightJixtalk.visible = false;
					portraitRightJixhappy.visible = false;
					portraitLeftJixsad.visible = false;
					portraitRightCutscene3.visible = false;
					portraitRightCutscene4.visible = false;
					portraitRightCutscene5.visible = false;
					portraitRightCutscene6.visible = false;
					portraitRightCutscene7.visible = false;
					portraitRightCutscene8.visible = false;
					portraitRightCutscene9.visible = false;
					portraitRightCutscene10.visible = false;
					box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
					swagDialogue.start(0.05, true);
					if (!portraitRightCutscene.visible)
					{
						portraitRightCutscene.visible = true;
						portraitRightCutscene.animation.play('enter');
					}
			case 'cutscenegf':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightBenohappy.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('GF'), 0.6)];
				swagDialogue.start(0.05, true);
				if (!portraitRightCutscene.visible)
				{
					portraitRightCutscene.visible = true;
					portraitRightCutscene.animation.play('enter');
				}
			case 'cutscene2':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benoprologue_talktext'), 0.5)];
				swagDialogue.start(0.06, true);
				if (!portraitRightCutscene2.visible)
				{
					portraitRightCutscene2.visible = true;
					portraitRightCutscene2.animation.play('enter');
				}
			case 'cutscene2gf':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightCutscene2.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfprologue_talktext'), 0.6)];
				swagDialogue.start(0.06, true);
				if (!portraitRightCutscene2.visible)
				{
					portraitRightCutscene2.visible = true;
					portraitRightCutscene2.animation.play('enter');
				}
			case 'jixshadow':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				swagDialogue.start(0.06, true);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
				if (!portraitRightJixshadow.visible)
				{
					portraitRightJixshadow.visible = true;
					portraitRightJixshadow.animation.play('enter');
				}
			case 'jixreveal':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightNothing.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				swagDialogue.start(1, true);
				box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
				FlxG.sound.play(Paths.sound('Texttest'));
				if (!portraitRightJixreveal.visible)
				{
					portraitRightJixreveal.visible = true;
					portraitRightJixreveal.animation.play('enter');
				}
			case 'nothing':
				portraitLeftJixsuspence.visible = false;
				portraitRight.visible = false;
				portraitRightGf.visible = false;
				portraitRightGfshock.visible = false;
				portraitRightGfphone.visible = false;
				portraitRightGfphoneshock.visible = false;
				portraitRightBeno.visible = false;
				portraitRightBenoshocked.visible = false;
				portraitRightBenosad.visible = false;
				portraitRightBenodots.visible = false;
				portraitRightCutscene.visible = false;
				portraitRightJixshadow.visible = false;
				portraitRightJixreveal.visible = false;
				portraitRightJixtalk.visible = false;
				portraitRightJixhappy.visible = false;
				portraitLeftJixsad.visible = false;
				portraitRightCutscene3.visible = false;
				portraitRightCutscene4.visible = false;
				portraitRightCutscene5.visible = false;
				portraitRightCutscene6.visible = false;
				portraitRightCutscene7.visible = false;
				portraitRightCutscene8.visible = false;
				portraitRightCutscene9.visible = false;
				portraitRightCutscene10.visible = false;
				portraitLeftone.visible = false;
				portraitRightone.visible = false;
				portraitRighttwo.visible = false;
				dadportrait.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				swagDialogue.start(0.05, true);
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				if (!portraitRightNothing.visible)
				{
					portraitRightNothing.visible = true;
					portraitRightNothing.animation.play('enter');
				}

				case 'nothingslow':
					portraitLeftJixsuspence.visible = false;
					portraitRight.visible = false;
					portraitRightGf.visible = false;
					portraitRightGfshock.visible = false;
					portraitRightGfphone.visible = false;
					portraitRightGfphoneshock.visible = false;
					portraitRightBeno.visible = false;
					portraitRightBenoshocked.visible = false;
					portraitRightBenosad.visible = false;
					portraitRightBenodots.visible = false;
					portraitRightCutscene.visible = false;
					portraitRightJixshadow.visible = false;
					portraitRightJixreveal.visible = false;
					portraitRightJixtalk.visible = false;
					portraitRightJixhappy.visible = false;
					portraitLeftJixsad.visible = false;
					portraitRightCutscene3.visible = false;
					portraitRightCutscene4.visible = false;
					portraitRightCutscene5.visible = false;
					portraitRightCutscene6.visible = false;
					portraitRightCutscene7.visible = false;
					portraitRightCutscene8.visible = false;
					portraitRightCutscene9.visible = false;
					portraitRightCutscene10.visible = false;
					FlxG.sound.play(Paths.sound('clickText'), 0.4);
					swagDialogue.start(0.20, true);
					if (!portraitRightNothing.visible)
					{
						portraitRightNothing.visible = true;
						portraitRightNothing.animation.play('enter');
					}
					case 'nothingbuzz':
						portraitLeftJixsuspence.visible = false;
						portraitRight.visible = false;
						portraitRightGf.visible = false;
						portraitRightGfshock.visible = false;
						portraitRightGfphone.visible = false;
						portraitRightGfphoneshock.visible = false;
						portraitRightBeno.visible = false;
						portraitRightBenoshocked.visible = false;
						portraitRightBenosad.visible = false;
						portraitRightBenodots.visible = false;
						portraitRightCutscene.visible = false;
						portraitRightJixshadow.visible = false;
						portraitRightJixreveal.visible = false;
						portraitRightJixtalk.visible = false;
						portraitRightJixhappy.visible = false;
						portraitLeftJixsad.visible = false;
						portraitRightCutscene3.visible = false;
						portraitRightCutscene4.visible = false;
						portraitRightCutscene5.visible = false;
						portraitRightCutscene6.visible = false;
						portraitRightCutscene7.visible = false;
						portraitRightCutscene8.visible = false;
						portraitRightCutscene9.visible = false;
						portraitRightCutscene10.visible = false;
						FlxG.sound.play(Paths.sound('phonebuzz'), 1.5);
						swagDialogue.start(15, true);
						if (!portraitRightNothing.visible)
						{
							portraitRightNothing.visible = true;
							portraitRightNothing.animation.play('enter');
						}
					case 'pew':
						portraitLeftJixsuspence.visible = false;
						portraitRight.visible = false;
						portraitRightGf.visible = false;
						portraitRightGfshock.visible = false;
						portraitRightGfphone.visible = false;
						portraitRightGfphoneshock.visible = false;
						portraitRightBeno.visible = false;
						portraitRightBenoshocked.visible = false;
						portraitRightBenosad.visible = false;
						portraitRightBenodots.visible = false;
						portraitRightCutscene.visible = false;
						portraitRightJixshadow.visible = false;
						portraitRightJixreveal.visible = false;
						portraitRightJixtalk.visible = false;
						portraitRightJixhappy.visible = false;
						portraitLeftJixsad.visible = false;
						portraitRightCutscene3.visible = false;
						portraitRightCutscene4.visible = false;
						portraitRightCutscene5.visible = false;
						portraitRightCutscene6.visible = false;
						portraitRightCutscene7.visible = false;
						portraitRightCutscene8.visible = false;
						portraitRightCutscene9.visible = false;
						portraitRightCutscene10.visible = false;
						box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
						FlxG.sound.play(Paths.sound('pew'), 1);
						swagDialogue.start(1, true);
						if (!portraitRightNothing.visible)
						{
							portraitRightNothing.visible = true;
							portraitRightNothing.animation.play('enter');
						}
						case 'jixtalking':
							portraitLeftJixsuspence.visible = false;
							portraitRight.visible = false;
							portraitRightGf.visible = false;
							portraitRightGfshock.visible = false;
							portraitRightGfphone.visible = false;
							portraitRightGfphoneshock.visible = false;
							portraitRightBeno.visible = false;
							portraitRightBenosad.visible = false;
							portraitRightBenoshocked.visible = false;
							portraitRightBenodots.visible = false;
							portraitRightBenohappy.visible = false;
							portraitRightCutscene.visible = false;
							portraitRightCutscene2.visible = false;
							portraitRightJixshadow.visible = false;
							portraitRightJixreveal.visible = false;
							portraitRightNothing.visible = false;
							portraitRightJixtalk.visible = false;
							portraitRightJixhappy.visible = false;
							portraitLeftJixsad.visible = false;
							portraitRightCutscene3.visible = false;
							portraitRightCutscene4.visible = false;
							portraitRightCutscene5.visible = false;
							portraitRightCutscene6.visible = false;
							portraitRightCutscene7.visible = false;
							portraitRightCutscene8.visible = false;
							portraitRightCutscene9.visible = false;
							portraitRightCutscene10.visible = false;
							FlxG.sound.play(Paths.sound('clickText'), 0.4);
							box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
							swagDialogue.sounds = [FlxG.sound.load(Paths.sound('jix_talktext'), 0.5)];
							swagDialogue.start(0.06, true);
							if (!portraitRightJixtalk.visible)
							{
								portraitRightJixtalk.visible = true;
								portraitRightJixtalk.animation.play('enter');
							}
						case 'jixhappy':
							portraitLeftJixsuspence.visible = false;
							portraitRight.visible = false;
							portraitRightGf.visible = false;
							portraitRightGfshock.visible = false;
							portraitRightGfphone.visible = false;
							portraitRightGfphoneshock.visible = false;
							portraitRightBeno.visible = false;
							portraitRightBenosad.visible = false;
							portraitRightBenoshocked.visible = false;
							portraitRightBenodots.visible = false;
							portraitRightBenohappy.visible = false;
							portraitRightCutscene.visible = false;
							portraitRightCutscene2.visible = false;
							portraitRightJixshadow.visible = false;
							portraitRightJixreveal.visible = false;
							portraitRightNothing.visible = false;
							portraitRightJixtalk.visible = false;
							portraitLeftJixsad.visible = false;
							portraitRightCutscene3.visible = false;
							portraitRightCutscene4.visible = false;
							portraitRightCutscene5.visible = false;
							portraitRightCutscene6.visible = false;
							portraitRightCutscene7.visible = false;
							portraitRightCutscene8.visible = false;
							portraitRightCutscene9.visible = false;
							portraitRightCutscene10.visible = false;
							FlxG.sound.play(Paths.sound('clickText'), 0.4);
							box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
							swagDialogue.sounds = [FlxG.sound.load(Paths.sound('jix_talktext'), 0.5)];
							swagDialogue.start(0.06, true);
							if (!portraitRightJixhappy.visible)
							{
								portraitRightJixhappy.visible = true;
								portraitRightJixhappy.animation.play('enter');
							}
							case 'cutscene3':
								portraitLeftJixsuspence.visible = false;
								portraitRight.visible = false;
								portraitRightGf.visible = false;
								portraitRightGfshock.visible = false;
								portraitRightGfphone.visible = false;
								portraitRightGfphoneshock.visible = false;
								portraitRightBeno.visible = false;
								portraitRightBenoshocked.visible = false;
								portraitRightBenosad.visible = false;
								portraitRightBenodots.visible = false;
								portraitRightCutscene.visible = false;
								portraitRightCutscene2.visible = false;
								portraitRightJixshadow.visible = false;
								portraitRightJixreveal.visible = false;
								portraitRightNothing.visible = false;
								portraitRightJixtalk.visible = false;
								portraitRightJixhappy.visible = false;
								portraitLeftJixsad.visible = false;
								portraitRightCutscene4.visible = false;
								portraitRightCutscene5.visible = false;
								portraitRightCutscene6.visible = false;
								portraitRightCutscene7.visible = false;
								portraitRightCutscene8.visible = false;
								portraitRightCutscene9.visible = false;
								portraitRightCutscene10.visible = false;
								box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
								swagDialogue.sounds = [FlxG.sound.load(Paths.sound('benodidthebruh'), 0.6)];
								swagDialogue.start(0.06, true);
								FlxG.sound.play(Paths.sound('benodidthebruh'), 0.4);
								swagDialogue.start(0.05, true);
								if (!portraitRightCutscene3.visible)
								{
									portraitRightCutscene3.visible = true;
									portraitRightCutscene3.animation.play('enter');
								}
								case 'cutscene4b':
									portraitLeftJixsuspence.visible = false;
									portraitRight.visible = false;
									portraitRightGf.visible = false;
									portraitRightGfshock.visible = false;
									portraitRightGfphone.visible = false;
									portraitRightGfphoneshock.visible = false;
									portraitRightBeno.visible = false;
									portraitRightBenoshocked.visible = false;
									portraitRightBenosad.visible = false;
									portraitRightBenodots.visible = false;
									portraitRightCutscene.visible = false;
									portraitRightCutscene2.visible = false;
									portraitRightJixshadow.visible = false;
									portraitRightJixreveal.visible = false;
									portraitRightNothing.visible = false;
									portraitRightJixtalk.visible = false;
									portraitRightJixhappy.visible = false;
									portraitLeftJixsad.visible = false;
									portraitRightCutscene3.visible = false;
									portraitRightCutscene5.visible = false;
									portraitRightCutscene6.visible = false;
									portraitRightCutscene7.visible = false;
									portraitRightCutscene8.visible = false;
									portraitRightCutscene9.visible = false;
									portraitRightCutscene10.visible = false;
									FlxG.sound.play(Paths.sound('clickText'), 0.4);
									box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
									swagDialogue.start(0.05, true);
									if (!portraitRightCutscene4.visible)
									{
										portraitRightCutscene4.visible = true;
										portraitRightCutscene4.animation.play('enter');
									}
									case 'cutscene4':
										portraitLeftJixsuspence.visible = false;
										portraitRight.visible = false;
										portraitRightGf.visible = false;
										portraitRightGfshock.visible = false;
										portraitRightGfphone.visible = false;
										portraitRightGfphoneshock.visible = false;
										portraitRightBeno.visible = false;
										portraitRightBenoshocked.visible = false;
										portraitRightBenosad.visible = false;
										portraitRightBenodots.visible = false;
										portraitRightCutscene.visible = false;
										portraitRightCutscene2.visible = false;
										portraitRightJixshadow.visible = false;
										portraitRightJixreveal.visible = false;
										portraitRightNothing.visible = false;
										portraitRightJixtalk.visible = false;
										portraitRightJixhappy.visible = false;
										portraitLeftJixsad.visible = false;
										portraitRightCutscene3.visible = false;
										portraitRightCutscene5.visible = false;
										portraitRightCutscene6.visible = false;
										portraitRightCutscene7.visible = false;
										portraitRightCutscene8.visible = false;
										portraitRightCutscene9.visible = false;
										portraitRightCutscene10.visible = false;
										FlxG.sound.play(Paths.sound('clickText'), 0.4);
										box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
										swagDialogue.start(0.05, true);
										if (!portraitRightCutscene4.visible)
										{
											portraitRightCutscene4.visible = true;
											portraitRightCutscene4.animation.play('enter');
										}
									case 'cutscene5':
										portraitLeftJixsuspence.visible = false;
										portraitRight.visible = false;
										portraitRightGf.visible = false;
										portraitRightGfshock.visible = false;
										portraitRightGfphone.visible = false;
										portraitRightGfphoneshock.visible = false;
										portraitRightBeno.visible = false;
										portraitRightBenoshocked.visible = false;
										portraitRightBenosad.visible = false;
										portraitRightBenodots.visible = false;
										portraitRightCutscene.visible = false;
										portraitRightCutscene2.visible = false;
										portraitRightJixshadow.visible = false;
										portraitRightJixreveal.visible = false;
										portraitRightNothing.visible = false;
										portraitRightJixtalk.visible = false;
										portraitRightJixhappy.visible = false;
										portraitLeftJixsad.visible = false;
										portraitRightCutscene3.visible = false;
										portraitRightCutscene4.visible = false;
										portraitRightCutscene6.visible = false;
										portraitRightCutscene7.visible = false;
										portraitRightCutscene8.visible = false;
										portraitRightCutscene9.visible = false;
										portraitRightCutscene10.visible = false;
										FlxG.sound.play(Paths.sound('clickText'), 0.4);
										box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
										if (!portraitRightCutscene5.visible)
										{
											portraitRightCutscene5.visible = true;
											portraitRightCutscene5.animation.play('enter');
										}
										case 'cutscene6':
											portraitLeftJixsuspence.visible = false;
											portraitRight.visible = false;
											portraitRightGf.visible = false;
											portraitRightGfshock.visible = false;
											portraitRightGfphone.visible = false;
											portraitRightGfphoneshock.visible = false;
											portraitRightBeno.visible = false;
											portraitRightBenoshocked.visible = false;
											portraitRightBenosad.visible = false;
											portraitRightBenodots.visible = false;
											portraitRightCutscene.visible = false;
											portraitRightCutscene2.visible = false;
											portraitRightJixshadow.visible = false;
											portraitRightJixreveal.visible = false;
											portraitRightNothing.visible = false;
											portraitRightJixtalk.visible = false;
											portraitRightJixhappy.visible = false;
											portraitLeftJixsad.visible = false;
											portraitRightCutscene3.visible = false;
											portraitRightCutscene4.visible = false;
											portraitRightCutscene5.visible = false;
											portraitRightCutscene7.visible = false;
											portraitRightCutscene8.visible = false;
											portraitRightCutscene9.visible = false;
											portraitRightCutscene10.visible = false;
											FlxG.sound.play(Paths.sound('clickText'), 0.4);
											box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
											swagDialogue.sounds = [FlxG.sound.load(Paths.sound('picoprologue_talktext'), 0.5)];
											swagDialogue.start(0.06, true);
											if (!portraitRightCutscene6.visible)
											{
												portraitRightCutscene6.visible = true;
												portraitRightCutscene6.animation.play('enter');
											}
											case 'cutscene6b':
												portraitLeftJixsuspence.visible = false;
												portraitRight.visible = false;
												portraitRightGf.visible = false;
												portraitRightGfshock.visible = false;
												portraitRightGfphone.visible = false;
												portraitRightGfphoneshock.visible = false;
												portraitRightBeno.visible = false;
												portraitRightBenoshocked.visible = false;
												portraitRightBenosad.visible = false;
												portraitRightBenodots.visible = false;
												portraitRightCutscene.visible = false;
												portraitRightCutscene2.visible = false;
												portraitRightJixshadow.visible = false;
												portraitRightJixreveal.visible = false;
												portraitRightNothing.visible = false;
												portraitRightJixtalk.visible = false;
												portraitRightJixhappy.visible = false;
												portraitLeftJixsad.visible = false;
												portraitRightCutscene3.visible = false;
												portraitRightCutscene4.visible = false;
												portraitRightCutscene5.visible = false;
												portraitRightCutscene7.visible = false;
												portraitRightCutscene8.visible = false;
												portraitRightCutscene9.visible = false;
												portraitRightCutscene10.visible = false;
												box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
												swagDialogue.sounds = [FlxG.sound.load(Paths.sound('BF'), 0.6)];
												swagDialogue.start(0.06, true);
												FlxG.sound.play(Paths.sound('BF'), 0.4);
												if (!portraitRightCutscene6.visible)
												{
													portraitRightCutscene6.visible = true;
													portraitRightCutscene6.animation.play('enter');
												}
											case 'cutscene7':
												portraitLeftJixsuspence.visible = false;
												portraitRight.visible = false;
												portraitRightGf.visible = false;
												portraitRightGfshock.visible = false;
												portraitRightGfphone.visible = false;
												portraitRightGfphoneshock.visible = false;
												portraitRightBeno.visible = false;
												portraitRightBenoshocked.visible = false;
												portraitRightBenosad.visible = false;
												portraitRightBenodots.visible = false;
												portraitRightCutscene.visible = false;
												portraitRightCutscene2.visible = false;
												portraitRightJixshadow.visible = false;
												portraitRightJixreveal.visible = false;
												portraitRightNothing.visible = false;
												portraitRightJixtalk.visible = false;
												portraitRightJixhappy.visible = false;
												portraitLeftJixsad.visible = false;
												portraitRightCutscene3.visible = false;
												portraitRightCutscene4.visible = false;
												portraitRightCutscene5.visible = false;
												portraitRightCutscene6.visible = false;
												portraitRightCutscene8.visible = false;
												portraitRightCutscene9.visible = false;
												portraitRightCutscene10.visible = false;
												box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
												swagDialogue.start(0.05, true);
												FlxG.sound.playMusic(Paths.music('chillredacted'), 0);
												FlxG.sound.music.fadeIn(1, 0, 0.8);
												if (!portraitRightCutscene7.visible)
												{
													portraitRightCutscene7.visible = true;
													portraitRightCutscene7.animation.play('enter');
												}
												case 'cutscene7b':
													portraitLeftJixsuspence.visible = false;
													portraitRight.visible = false;
													portraitRightGf.visible = false;
													portraitRightGfshock.visible = false;
													portraitRightGfphone.visible = false;
													portraitRightGfphoneshock.visible = false;
													portraitRightBeno.visible = false;
													portraitRightBenoshocked.visible = false;
													portraitRightBenosad.visible = false;
													portraitRightBenodots.visible = false;
													portraitRightCutscene.visible = false;
													portraitRightCutscene2.visible = false;
													portraitRightJixshadow.visible = false;
													portraitRightJixreveal.visible = false;
													portraitRightNothing.visible = false;
													portraitRightJixtalk.visible = false;
													portraitRightJixhappy.visible = false;
													portraitLeftJixsad.visible = false;
													portraitRightCutscene3.visible = false;
													portraitRightCutscene4.visible = false;
													portraitRightCutscene5.visible = false;
													portraitRightCutscene6.visible = false;
													portraitRightCutscene8.visible = false;
													portraitRightCutscene9.visible = false;
													portraitRightCutscene10.visible = false;
													FlxG.sound.play(Paths.sound('clickText'), 0.4);
													swagDialogue.sounds = [FlxG.sound.load(Paths.sound('picoprologue_talktext'), 0.5)];
													swagDialogue.start(0.06, true);
													box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
													if (!portraitRightCutscene7.visible)
													{
														portraitRightCutscene7.visible = true;
														portraitRightCutscene7.animation.play('enter');
													}
												case 'cutscene8':
													portraitLeftJixsuspence.visible = false;
													portraitRight.visible = false;
													portraitRightGf.visible = false;
													portraitRightGfshock.visible = false;
													portraitRightGfphone.visible = false;
													portraitRightGfphoneshock.visible = false;
													portraitRightBeno.visible = false;
													portraitRightBenoshocked.visible = false;
													portraitRightBenosad.visible = false;
													portraitRightBenodots.visible = false;
													portraitRightCutscene.visible = false;
													portraitRightCutscene2.visible = false;
													portraitRightJixshadow.visible = false;
													portraitRightJixreveal.visible = false;
													portraitRightNothing.visible = false;
													portraitRightJixtalk.visible = false;
													portraitRightJixhappy.visible = false;
													portraitLeftJixsad.visible = false;
													portraitRightCutscene3.visible = false;
													portraitRightCutscene4.visible = false;
													portraitRightCutscene5.visible = false;
													portraitRightCutscene6.visible = false;
													portraitRightCutscene7.visible = false;
													portraitRightCutscene10.visible = false;
													FlxG.sound.play(Paths.sound('clickText'), 0.4);
													box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
													swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
													swagDialogue.start(0.06, true);
													if (!portraitRightCutscene8.visible)
													{
														portraitRightCutscene8.visible = true;
														portraitRightCutscene8.animation.play('enter');
													}
													case 'cutscene9':
														portraitLeftJixsuspence.visible = false;
														portraitRight.visible = false;
														portraitRightGf.visible = false;
														portraitRightGfshock.visible = false;
														portraitRightGfphone.visible = false;
														portraitRightGfphoneshock.visible = false;
														portraitRightBeno.visible = false;
														portraitRightBenoshocked.visible = false;
														portraitRightBenosad.visible = false;
														portraitRightBenodots.visible = false;
														portraitRightCutscene.visible = false;
														portraitRightCutscene2.visible = false;
														portraitRightJixshadow.visible = false;
														portraitRightJixreveal.visible = false;
														portraitRightNothing.visible = false;
														portraitRightJixtalk.visible = false;
														portraitRightJixhappy.visible = false;
														portraitLeftJixsad.visible = false;
														portraitRightCutscene3.visible = false;
														portraitRightCutscene4.visible = false;
														portraitRightCutscene5.visible = false;
														portraitRightCutscene6.visible = false;
														portraitRightCutscene7.visible = false;
														portraitRightCutscene8.visible = false;
														portraitRightCutscene10.visible = false;
														FlxG.sound.play(Paths.sound('clickText'), 0.4);
														box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
														swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
													swagDialogue.start(0.06, true);
														if (!portraitRightCutscene9.visible)
														{
															portraitRightCutscene9.visible = true;
															portraitRightCutscene9.animation.play('enter');
														}

														case 'cutscene9b':
															portraitLeftJixsuspence.visible = false;
															portraitRight.visible = false;
															portraitRightGf.visible = false;
															portraitRightGfshock.visible = false;
															portraitRightGfphone.visible = false;
															portraitRightGfphoneshock.visible = false;
															portraitRightBeno.visible = false;
															portraitRightBenoshocked.visible = false;
															portraitRightBenosad.visible = false;
															portraitRightBenodots.visible = false;
															portraitRightCutscene.visible = false;
															portraitRightCutscene2.visible = false;
															portraitRightJixshadow.visible = false;
															portraitRightJixreveal.visible = false;
															portraitRightNothing.visible = false;
															portraitRightJixtalk.visible = false;
															portraitRightJixhappy.visible = false;
															portraitLeftJixsad.visible = false;
															portraitRightCutscene3.visible = false;
															portraitRightCutscene4.visible = false;
															portraitRightCutscene5.visible = false;
															portraitRightCutscene6.visible = false;
															portraitRightCutscene7.visible = false;
															portraitRightCutscene8.visible = false;
															portraitRightCutscene10.visible = false;
															FlxG.sound.play(Paths.sound('clickText'), 0.4);
															box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
															swagDialogue.sounds = [FlxG.sound.load(Paths.sound('picoprologue_talktext'), 0.5)];
													swagDialogue.start(0.06, true);
															if (!portraitRightCutscene9.visible)
															{
																portraitRightCutscene9.visible = true;
																portraitRightCutscene9.animation.play('enter');
															}
												case 'cutscene10':
													portraitLeftJixsuspence.visible = false;
													portraitRight.visible = false;
													portraitRightGf.visible = false;
													portraitRightGfshock.visible = false;
													portraitRightGfphone.visible = false;
													portraitRightGfphoneshock.visible = false;
													portraitRightBeno.visible = false;
													portraitRightBenoshocked.visible = false;
													portraitRightBenosad.visible = false;
													portraitRightBenodots.visible = false;
													portraitRightCutscene.visible = false;
													portraitRightCutscene2.visible = false;
													portraitRightJixshadow.visible = false;
													portraitRightJixreveal.visible = false;
													portraitRightNothing.visible = false;
													portraitRightJixtalk.visible = false;
													portraitRightJixhappy.visible = false;
													portraitLeftJixsad.visible = false;
													portraitRightCutscene3.visible = false;
													portraitRightCutscene4.visible = false;
													portraitRightCutscene5.visible = false;
													portraitRightCutscene6.visible = false;
													portraitRightCutscene7.visible = false;
													portraitRightCutscene8.visible = false;
													portraitRightCutscene9.visible = false;
													swagDialogue.start(0.05, true);
													swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
													box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
													if (!portraitRightCutscene10.visible)
													{
														portraitRightCutscene10.visible = true;
														portraitRightCutscene10.animation.play('enter');
													}
														// yes the code above is bullshit, but it work.
	// don't ask why i have sooo much dialogue thing, just accept it bruh -Z
	// i'll redo the ENTIRE dialogue code for the full version, because yeah.. this one sucks -Z
	// please do NOT copy this type of code for portrait, wait for the full version when i redo the entire one -Z
	// THIS IS SO BAD DIALOGUE SYSTEM BUT IT WORK LMFAO I4M DYING AAAAAAAAAAAAAAAAAA -Z

// THIS IS ACT1 DIALOGUE CODE USE IHIS ONE

case 'clearcut':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	portraitkillme.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benostare');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'clearcut1':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	portraitkillme.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benofacelesstalk');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'gfblush1':
	portraitLeftone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRightone.frames = Paths.getSparrowAtlas('portraits/act1/gfblush');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfact1_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRightone.setGraphicSize(Std.int(portraitRightone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRightone.visible)
	{
		portraitRightone.visible = true;
		portraitRightone.animation.play('enter');
	}
case 'gfsad1':
	portraitLeftone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRightone.frames = Paths.getSparrowAtlas('portraits/act1/gfsad');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfact1_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRightone.setGraphicSize(Std.int(portraitRightone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRightone.visible)
	{
		portraitRightone.visible = true;
		portraitRightone.animation.play('enter');
	}
case 'gfshock1':
	portraitLeftone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRightone.frames = Paths.getSparrowAtlas('portraits/act1/gfshock');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfact1_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRightone.setGraphicSize(Std.int(portraitRightone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRightone.visible)
	{
		portraitRightone.visible = true;
		portraitRightone.animation.play('enter');
	}
case 'gf1':
	portraitLeftone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRightone.frames = Paths.getSparrowAtlas('portraits/act1/gftalk');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfact1_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRightone.setGraphicSize(Std.int(portraitRightone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRightone.visible)
	{
		portraitRightone.visible = true;
		portraitRightone.animation.play('enter');
	}
case 'bfconfused':
	portraitLeftone.visible = false;
	portraitRightone.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRighttwo.frames = Paths.getSparrowAtlas('portraits/act1/bfconfused');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRighttwo.setGraphicSize(Std.int(portraitRighttwo.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRighttwo.visible)
	{
		portraitRighttwo.visible = true;
		portraitRighttwo.animation.play('enter');
	}
case 'bfhappy':
	portraitLeftone.visible = false;
	portraitRightone.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRighttwo.frames = Paths.getSparrowAtlas('portraits/act1/bfhappy');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRighttwo.setGraphicSize(Std.int(portraitRighttwo.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRighttwo.visible)
	{
		portraitRighttwo.visible = true;
		portraitRighttwo.animation.play('enter');
	}
case 'bfsad':
	portraitLeftone.visible = false;
	portraitRightone.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRighttwo.frames = Paths.getSparrowAtlas('portraits/act1/bfsad');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRighttwo.setGraphicSize(Std.int(portraitRighttwo.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRighttwo.visible)
	{
		portraitRighttwo.visible = true;
		portraitRighttwo.animation.play('enter');
	}
case 'bfshock':
	portraitLeftone.visible = false;
	portraitRightone.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRighttwo.frames = Paths.getSparrowAtlas('portraits/act1/bfshock');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRighttwo.setGraphicSize(Std.int(portraitRighttwo.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRighttwo.visible)
	{
		portraitRighttwo.visible = true;
		portraitRighttwo.animation.play('enter');
	}
case 'bfsmug':
	portraitLeftone.visible = false;
	portraitRightone.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRighttwo.frames = Paths.getSparrowAtlas('portraits/act1/bfsmug');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRighttwo.setGraphicSize(Std.int(portraitRighttwo.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRighttwo.visible)
	{
		portraitRighttwo.visible = true;
		portraitRighttwo.animation.play('enter');
	}
case 'bf':
	portraitLeftone.visible = false;
	portraitRightone.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitRighttwo.frames = Paths.getSparrowAtlas('portraits/act1/bftalk');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('bf_talktext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitRighttwo.setGraphicSize(Std.int(portraitRighttwo.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitRighttwo.visible)
	{
		portraitRighttwo.visible = true;
		portraitRighttwo.animation.play('enter');
	}
case 'benopoint':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benopoint');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benostare':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benostare');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benotalk':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benotalk');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benofaceless':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benofaceless');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benofaceless1':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benofaceless');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	FlxG.sound.playMusic(Paths.music('Dead_Meat_Looped'), 0); // i'm doing this because it's midnight and that the only way i know for now :C
	FlxG.sound.music.fadeIn(1, 0, 0.8);
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}


case 'benopointfaceless':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benopointfaceless');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}



case 'benoangy': // Beno is mad >:C
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benoangy');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benosmug':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benosmug');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}


case 'benofacelesstalk':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benofacelesstalk');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benofacelesssmile': // offset can't be move
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benofacelesssmile');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benofacelesssmile1': // offset can't be move
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benofacelesssmile');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	FlxG.sound.playMusic(Paths.music('Its_Over_Looped'), 0); // i'm doing this because it's midnight and that the only way i know for now :C
	FlxG.sound.music.fadeIn(1, 0, 0.8);
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}


case 'benofacelesstwo':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benofacelesstwo');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benoturned':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benoturned');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}

case 'benolookback':
	portraitRightone.visible = false;
	portraitRighttwo.visible = false;
	FlxG.sound.play(Paths.sound('clickText'), 0.4);
	portraitLeftone.frames = Paths.getSparrowAtlas('portraits/act1/benolookback');
	swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
	swagDialogue.start(0.06, true);
	portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
	box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/the_box_trademarked');
	if (!portraitLeftone.visible)
	{
		portraitLeftone.visible = true;
		portraitLeftone.animation.play('enter');
	}
	// ... -Z

	// These cutscene are terrible, i spend a day coding and fixing them, some run on other cutscenes errors, i'm tired of this shit system, end me please :C -Z
	// SOME... I GUESS cause memory leak but Aaaa this is pain :C -Z
	case 'cut1':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/beachfadein');
		portraitkillme.animation.addByPrefix('enter', 'beachfadein idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut2':
		portraitkillme.offset.x -= 315;
		portraitkillme.offset.y -= 175;
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/reveal');
		portraitkillme.animation.addByPrefix('enter', 'reveal idle', 24, false);
		portraitkillme.animation.play('enter');
		portraitkillme.setGraphicSize(Std.int(portraitkillme.width * 1));
		portraitkillme.antialiasing = true;
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		FlxG.sound.playMusic(Paths.music('Familiar_Mask'), 0);
		FlxG.sound.music.fadeIn(1, 0, 0.8);
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut3':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/maskreveal');
		portraitkillme.animation.addByPrefix('enter', 'maskreveal idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut4':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/attack');
		portraitkillme.animation.addByPrefix('enter', 'attack idle', 12, false);
		portraitkillme.animation.play('enter');
		FlxG.sound.play(Paths.sound('fall_lmao'), 0.4);
		if (FlxG.random.bool(0.1))
{
	FlxG.sound.play(Paths.sound('dies'), 0.4);
}
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut5':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/benoonroad');
		portraitkillme.animation.addByPrefix('enter', 'benoonroad idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut6':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/omgcar');
		portraitkillme.animation.addByPrefix('enter', 'omgcar idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		FlxG.sound.music.stop();
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut7':
		portraitkillme.offset.x -= 315;
		portraitkillme.offset.y -= 175;
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/DEMONO');
		portraitkillme.animation.addByPrefix('enter', 'DEMONO idle', 24, false);
		portraitkillme.animation.play('enter');
		portraitkillme.setGraphicSize(Std.int(portraitkillme.width * 1));
		FlxG.sound.play(Paths.sound('GFDOES_A_DO'), 0.4);
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut8':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/benoondabridge');
		portraitkillme.animation.addByPrefix('enter', 'benoondabridge idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut9':
		portraitkillme.offset.x += 315;
		portraitkillme.offset.y += 175;
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.setGraphicSize(Std.int(portraitkillme.width * 0.80));
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/benoholdback');
		portraitkillme.animation.addByPrefix('enter', 'benoholdback idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut10':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/benotalkgf');
		portraitkillme.animation.addByPrefix('enter', 'benotalkgf idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut11':
		portraitkillme.offset.x -= 630;
		portraitkillme.offset.y -= 355;
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.setGraphicSize(Std.int(portraitkillme.width * 1));
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/bfgffuckoff');
		portraitkillme.animation.addByPrefix('enter', 'bfgffuckoff idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut12':
		portraitkillme.offset.x += 630;
		portraitkillme.offset.y += 355;
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.setGraphicSize(Std.int(portraitkillme.width * 0.51));
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/benoalone');
		portraitkillme.animation.addByPrefix('enter', 'benoalone idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

	case 'cut13':
		portraitRightone.visible = false;
		portraitRighttwo.visible = false;
		portraitLeftone.visible = false;
		FlxG.sound.play(Paths.sound('clickText'), 0.4);
		portraitkillme.frames = Paths.getSparrowAtlas('act/cutsceneshit/benocry');
		portraitkillme.animation.addByPrefix('enter', 'benocry idle', 24, false);
		portraitkillme.animation.play('enter');
		box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
		if (!portraitkillme.visible)
		{
			portraitkillme.visible = true;
			portraitkillme.animation.play('enter');
		}

		case 'nothing2':
			portraitRightone.visible = false;
			portraitRighttwo.visible = false;
			portraitLeftone.visible = false;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('beno_talkitext'), 0.5)];
			swagDialogue.start(0.06, true);
			portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
			box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
			if (!portraitRightNothing.visible)
			{
				portraitRightNothing.visible = true;
				portraitRightNothing.animation.play('enter');
			}

		case 'nothing3':
			portraitRightone.visible = false;
			portraitRighttwo.visible = false;
			portraitLeftone.visible = false;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfact1_talktext'), 0.5)];
			swagDialogue.start(0.06, true);
			portraitLeftone.setGraphicSize(Std.int(portraitLeftone.width * 0.5));
			box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
			if (!portraitRightNothing.visible)
			{
				portraitRightNothing.visible = true;
				portraitRightNothing.animation.play('enter');
			}

		//promise brubzklzjbkshf -Z

		case 'dadstare':
			portraitRight.visible = false;
			portraitRightGf.visible = false;
			portraitRightGfshock.visible = false;
			portraitRightGfphone.visible = false;
			portraitRightGfphoneshock.visible = false;
			portraitRightBeno.visible = false;
			portraitRightBenoshocked.visible = false;
			portraitRightBenosad.visible = false;
			portraitRightBenodots.visible = false;
			portraitRightBenohappy.visible = false;
			portraitRightCutscene.visible = false;
			portraitRightCutscene2.visible = false;
			portraitRightJixshadow.visible = false;
			portraitRightJixreveal.visible = false;
			portraitRightNothing.visible = false;
			portraitRightJixtalk.visible = false;
			portraitRightJixhappy.visible = false;
			portraitLeftJixsad.visible = false;
			portraitRightCutscene3.visible = false;
			portraitRightCutscene4.visible = false;
			portraitRightCutscene5.visible = false;
			portraitRightCutscene6.visible = false;
			portraitRightCutscene7.visible = false;
			portraitRightCutscene8.visible = false;
			portraitRightCutscene9.visible = false;
			portraitRightCutscene10.visible = false;

			FlxG.sound.play(Paths.sound('clickText'), 0.4);
			dadportrait.frames = Paths.getSparrowAtlas('portraits/DDstaring');
			if (!dadportrait.visible)
			{
				dadportrait.visible = true;
				dadportrait.animation.play('enter');
			}

		case 'dadtalk':
			portraitRight.visible = false;
			portraitRightGf.visible = false;
			portraitRightGfshock.visible = false;
			portraitRightGfphone.visible = false;
			portraitRightGfphoneshock.visible = false;
			portraitRightBeno.visible = false;
			portraitRightBenoshocked.visible = false;
			portraitRightBenosad.visible = false;
			portraitRightBenodots.visible = false;
			portraitRightBenohappy.visible = false;
			portraitRightCutscene.visible = false;
			portraitRightCutscene2.visible = false;
			portraitRightJixshadow.visible = false;
			portraitRightJixreveal.visible = false;
			portraitRightNothing.visible = false;
			portraitRightJixtalk.visible = false;
			portraitRightJixhappy.visible = false;
			portraitLeftJixsad.visible = false;
			portraitRightCutscene3.visible = false;
			portraitRightCutscene4.visible = false;
			portraitRightCutscene5.visible = false;
			portraitRightCutscene6.visible = false;
			portraitRightCutscene7.visible = false;
			portraitRightCutscene8.visible = false;
			portraitRightCutscene9.visible = false;
			portraitRightCutscene10.visible = false;

			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dd_talksound'), 0.5)];
			swagDialogue.start(0.06, true);
			FlxG.sound.play(Paths.sound('clickText'), 0.4);
			dadportrait.frames = Paths.getSparrowAtlas('portraits/DDtalkphone');
			if (!dadportrait.visible)
			{
				dadportrait.visible = true;
				dadportrait.animation.play('enter');
			}

			case 'dadcalling':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dd_talksound'), 0.5)];
				swagDialogue.start(0.06, true);
				FlxG.sound.play(Paths.sound('clickText'), 0.4);
				dadportrait.frames = Paths.getSparrowAtlas('portraits/DDtalkphone');
				FlxG.sound.play(Paths.sound('dialing'), 0.4);
				if (!dadportrait.visible)
				{
					dadportrait.visible = true;
					dadportrait.animation.play('enter');
				}

				case 'dadcallend':
					dadportrait.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
					box.frames = Paths.getSparrowAtlas('prologue/weeb/pixelUI/nothing');
					FlxG.sound.play(Paths.sound('callend'), 0.4);
					if (!dadportrait.visible)
					{
						dadportrait.visible = true;
						dadportrait.animation.play('enter');
					}

					case 'dadphone':
						swagDialogue.sounds = [FlxG.sound.load(Paths.sound('dd_talksound'), 0.5)];
						swagDialogue.start(0.06, true);
						FlxG.sound.play(Paths.sound('clickText'), 0.4);
						dadportrait.frames = Paths.getSparrowAtlas('portraits/DDtalkphone');
						FlxG.sound.play(Paths.sound('beepbopphon'), 0.4);
						if (!dadportrait.visible)
						{
							dadportrait.visible = true;
							dadportrait.animation.play('enter');
						}


	}
	}
		
	function skipDialogue():Void
	{
		if (!skippedDialogue)
		{
			kill();
			finishThing();
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}


//			case 'gf':
//				portraitLeft.visible = false;
//				portraitRight.visible = false;
//				portraitRightGfshock.visible = false;
//				portraitRightGfphone.visible = false;
//				portraitRightGfphoneshock.visible = false;
//				if (!portraitRightGf.visible)
//				{
//					portraitRightGf.visible = true;
//					portraitRightGf.animation.play('enter');
//				}
//
//				FlxG.sound.play(Paths.sound('Texttest'));