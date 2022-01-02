package;
import flixel.*;
import flixel.util.FlxTimer;
/**
 * ...
 */
class SongState extends MusicBeatState // Thanksssss OptimumCashew#7788 for this !!!!! -Z
{
    
    var number:Int = 0;
    var sprite:FlxSprite = new FlxSprite(0, 0);

    public function new() 
    {
        super();
    }

    override public function create()
    {
        super.create();
        FlxG.mouse.visible = false; // glowy -Z

        FlxG.sound.playMusic(Paths.music('fuckkbh'));

                var screen:FlxSprite = new FlxSprite().loadGraphic(Paths.image("amongus/Hello.")); // bg bruh
                screen.frames = Paths.getSparrowAtlas('amongus/Hello.');
                screen.animation.addByPrefix('Piracy', "Piracy", 24);
                screen.animation.play('Piracy');
                screen.screenCenter();
                screen.setGraphicSize(Std.int(screen.width * 0.67));
                add(screen);

                sprite = new FlxSprite().loadGraphic(Paths.image('amongus/1'));
                add(sprite);
    }

    var MEGAAMONGUSSUS:Bool = false;
    var supersus:Bool = false;

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        sprite.loadGraphic(Paths.image('amongus/' + number));
        sprite.screenCenter();
        sprite.setGraphicSize(Std.int(sprite.width * 0.67));

        var website:Array<String>; // for website -Z
        website = ["https://gamebanana.com/mods/307587"]; // fuck you HTLM5 STEALERS GO download the game BRUH -Z

        if (FlxG.keys.justPressed.ENTER){
            MEGAAMONGUSSUS = true; // MONGUS ! -Z
        }

        if (MEGAAMONGUSSUS == true)
            {
                remove(sprite); // delete god dammit -Z
                number += 1;
                MEGAAMONGUSSUS = false;
                add(sprite);
            }

        if (number >= 20 && supersus == false)
        {
            supersus = true; // one time open. -Z
            FlxG.openURL(website[0]);
            trace('Open Site');
        }

    }



}