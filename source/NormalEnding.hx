package;
import flixel.*;
/**
 * ...
 */
class NormalEnding extends MusicBeatState // if you change the name of the file, Change this too with no space or it will break everything
{

    var coolimage:FlxSprite = new FlxSprite();

    public function new()
    {
        super(); 
    }

    override public function create() // to create things like images -Z
    {
        super.create(); // don't delete -Z
        FlxG.mouse.visible = false; // glowy -Z
        FlxG.sound.playMusic(Paths.music('Normal', 'shared'));

        coolimage = new FlxSprite(0, -675).loadGraphic(Paths.image('act/endings/normal_ending', 'shared')); 
        coolimage.setGraphicSize(Std.int(coolimage.width * 0.35)); // to resize if you need -Z
        coolimage.antialiasing = true; // no blur -Z
        coolimage.screenCenter(X); // screen center it on X -Z
        coolimage.alpha = 0;
        add(coolimage); // add it, pretty simple right ? -Z

    }


    override public function update(elapsed:Float) // Update per frame -Z
    {
        super.update(elapsed); // don't delete -Z
        
        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.switchState(new MainMenuState()); // to go into MainMenuState state -Z
        }

        if (coolimage.alpha != 1)
            coolimage.alpha += 0.001;

    }



}