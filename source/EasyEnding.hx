package;
import flixel.*;
import flixel.util.FlxTimer; // for uh timer for frenzied -Z
/**
 * ...
 */
class EasyEnding extends MusicBeatState // if you change the name of the file, Change this too with no space or it will break everything
{
   
    var coolimage:FlxSprite;
    var coolimage2:FlxSprite;

    public function new()
    {
        super(); 
    }

    override public function create() // to create things like images -Z
    {
        super.create(); // don't delete -Z
        FlxG.mouse.visible = false; // glowy -Z
        FlxG.sound.playMusic(Paths.music('Easy', 'shared'));

        coolimage = new FlxSprite().loadGraphic(Paths.image('act/endings/easy_ending', 'shared')); 
        coolimage.setGraphicSize(Std.int(coolimage.width * 0.30)); // to resize if you need -Z
        coolimage.antialiasing = true; // no blur -Z
        coolimage.screenCenter(X); // screen center it on X -Z
        coolimage.screenCenter(Y); // ^ -Z
        coolimage.alpha = 0;
        add(coolimage); // add it, pretty simple right ? -Z

        coolimage2 = new FlxSprite().loadGraphic(Paths.image('act/endings/freeplayfrenzied', 'shared')); 
        coolimage2.setGraphicSize(Std.int(coolimage2.width * 0.30)); // to resize if you need -Z
        coolimage2.antialiasing = true; // no blur -Z
        coolimage2.screenCenter(X); // screen center it on X -Z
        coolimage2.screenCenter(Y); // ^ -Z
        coolimage2.alpha = 0;
        add(coolimage2); // add it, pretty simple right ? -Z

    }


    override public function update(elapsed:Float) // Update per frame -Z
    {
        super.update(elapsed); // don't delete -Z
        
        if (FlxG.keys.justPressed.ENTER)
        {
            PlayState.SONG = Song.loadFromJson('frenzied-hard', 'Frenzied');
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 2;
			PlayState.storyWeek = 1;
			new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
           // FlxG.switchState(new MainMenuState()); // to go into MainMenuState state -Z
        }

        if (coolimage.alpha != 1 && FreeplayState.frenziedfreeplay == false)
            coolimage.alpha += 0.001;
        if (coolimage2.alpha != 1 && FreeplayState.frenziedfreeplay == true)
            coolimage2.alpha += 0.001;

    }



}