package;
import flixel.*;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import openfl.Lib; // for fps -Z

#if windows
import Discord.DiscordClient;
#end

import lime.app.Application;

/**
 * ...
 */
class BeforeCaching extends MusicBeatState // if you change the name of the file, Change this too with no space or it will break everything
{


    
    public function new()
    {
        super(); 
    }

    override public function create() // to create things like images -Z
    {
        #if windows
		DiscordClient.initialize();

		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		 });
		#end

        super.create(); // don't delete -Z

        var coolimage:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Caching_Prompt', 'shared'));
        coolimage.setGraphicSize(Std.int(coolimage.width * 0.65)); // to resize if you need -Z
        coolimage.antialiasing = true; // no blur -Z
        coolimage.screenCenter(X); // screen center it on X -Z
        coolimage.screenCenter(Y);
        add(coolimage); // add it, pretty simple right ? -Z

        FlxG.save.data.fpsCap = 60;
        (cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap); // fps lol -Z
        
    }


    override public function update(elapsed:Float) // Update per frame -Z
    {
        super.update(elapsed); // don't delete -Z
        
        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new Caching()); 
        }

        if (FlxG.keys.justPressed.SPACE)
			{
				FlxG.switchState(new TitleState()); // to go into title state -Z
			}

    }

}