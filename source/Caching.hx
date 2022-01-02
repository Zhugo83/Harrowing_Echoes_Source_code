package;

import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import sys.FileSystem;
import sys.io.File;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import openfl.Lib; // for fps -Z

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class Caching extends MusicBeatState
{
    var toBeDone = 0;
    var done = 0;

    var text:FlxText;
    var kadeLogo:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Caching...", null);
		#end

        FlxG.save.data.fpsCap = 1;
        (cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap); // found how fps works yay :D -Z

        FlxG.mouse.visible = false;
        FlxG.worldBounds.set(0,0);

        text = new FlxText(FlxG.width / 2, FlxG.height / 2 + 300,0,"Please wait it's loading..."); //Create the text in that position and have the normal text as "Please wait it's loading..." -Shadow
        text.size = 34; //Make size 34 -Shadow
        text.alignment = FlxTextAlign.CENTER; //Center the alignment -Shadow
        text.alpha = 0; //Make alpha 0(Invisible) -Shadow

        kadeLogo = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(Paths.image('lomgo')); //Make a sprite and load HE Story Picture -Shadow
        kadeLogo.x -= kadeLogo.width / 2; //Make the X the normal x minus half of the width -Shadow
        kadeLogo.y -= kadeLogo.height / 2; //Same thing but the Y instead of X and height instead of width -Shadow
        text.y -= kadeLogo.height / 2 + 300; //Make the X minus half the width plus 300 pixels -Shadow
        text.x -= kadeLogo.width / 2 - 210;//Same thing but the Y instead of X and height instead of width also - 210 pixels -Shadow
        kadeLogo.setGraphicSize(Std.int(kadeLogo.width * 1)); //Set the logo graphic size to be the width times 1(I might be stupid but isnt this the same?) -Shadow

        kadeLogo.alpha = 0; //Make the alpha 0(Invisible) -Shadow

        kadeLogo.alpha = 0;

        add(kadeLogo);
        add(text);

        trace('starting caching..');
        
        sys.thread.Thread.create(() -> {
            cache();
        });


        super.create();
    }

    var calledDone = false;

    override function update(elapsed) 
    {

        if (toBeDone != 0 && done != toBeDone)
        {
            var alpha = HelperFunctions.truncateFloat(done / toBeDone * 100,2) / 100;
            kadeLogo.alpha = alpha;
            text.alpha = alpha;
            text.text = "Please wait it's loading... (" + done + "/" + toBeDone + ")";
        }

        super.update(elapsed);
    }


    function cache()
    {

        var images = [];
        var music = [];

        trace("caching images...");

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
        {
            if (!i.endsWith(".png"))
                continue;
            images.push(i);
        }

        trace("caching music...");

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
        {
            music.push(i);
        }

        toBeDone = Lambda.count(images) + Lambda.count(music);

        trace("LOADING: " + toBeDone + " OBJECTS.");

        for (i in images)
        {
            var replaced = i.replace(".png","");
            FlxG.bitmap.add(Paths.image("characters/" + replaced,"shared"));
            trace("cached " + replaced);
            done++;
        }

        for (i in music)
        {
            FlxG.sound.cache(Paths.inst(i));
            FlxG.sound.cache(Paths.voices(i));
            trace("cached " + i);
            done++;
        }
        trace("We are finished with caching..."); //Trace in PowerShell/Command Prompt we finished caching -Shadow
        FlxG.sound.cache(Paths.sound('missnote1', 'shared'));
        FlxG.sound.cache(Paths.sound('missnote2', 'shared'));
        FlxG.sound.cache(Paths.sound('missnote3', 'shared')); // continue caching HEAVY stuff !!! -Z
        // CONTINUE YOU IDIOT !!! -Z

        FlxG.switchState(new TitleState());


       
    }

}