package;
import flixel.*;
/**
 * ...
 */
class NewFreeplaystate extends MusicBeatState // if you change the name of the file, Change this too with no space or it will break everything
{
    var curSelected:Int = 0;

    var bgweekpromise:FlxSprite;
    var bgweekprologue:FlxSprite;
    var bgweekact1:FlxSprite;
    var bg:FlxSprite;
    var select:FlxSprite;
    var lines:FlxSprite;

    // weeks images -Z
    var act1:FlxSprite;
    var act2:FlxSprite;
    var act3:FlxSprite;
    var act4:FlxSprite;
    var promise:FlxSprite;
    var prologue:FlxSprite;
    var bonussongs:FlxSprite;

    // code for freeplay when loading :D -Z

    public static var hipromisesongsplease:Bool = false;
    public static var hiprologuesongsplease:Bool = false;
    public static var hiact1songsplease:Bool = false;
    public static var hibonussongssongsplease:Bool = false;

    public function new()
    {
        super(); 
    }

    override public function create() // to create things like images -Z
    {
        super.create(); // don't delete -Z

		if (FlxG.sound.music.playing)
            {
                FlxG.sound.playMusic(Paths.music('trolling'));
            }

        bgweekpromise = new FlxSprite().loadGraphic(Paths.image('NewFreeplay/promise_header', 'shared'));
        bgweekpromise.setGraphicSize(Std.int(bgweekpromise.width * 0.7)); // to resize if you need -Z
        bgweekpromise.antialiasing = true; // no blur -Z
        bgweekpromise.screenCenter(X); // screen center it on X -Z
        bgweekpromise.screenCenter(Y);
        bgweekpromise.alpha = 0;
        add(bgweekpromise); // add it, pretty simple right ? -Z

        bgweekprologue = new FlxSprite().loadGraphic(Paths.image('NewFreeplay/prologue_header', 'shared'));
        bgweekprologue.setGraphicSize(Std.int(bgweekprologue.width * 0.7)); // to resize if you need -Z
        bgweekprologue.antialiasing = true; // no blur -Z
        bgweekprologue.screenCenter(X); // screen center it on X -Z
        bgweekprologue.screenCenter(Y);
        bgweekprologue.alpha = 0;
        add(bgweekprologue); // add it, pretty simple right ? -Z

        bgweekact1 = new FlxSprite().loadGraphic(Paths.image('NewFreeplay/act_1_header', 'shared'));
        bgweekact1.setGraphicSize(Std.int(bgweekact1.width * 0.7)); // to resize if you need -Z
        bgweekact1.antialiasing = true; // no blur -Z
        bgweekact1.screenCenter(X); // screen center it on X -Z
        bgweekact1.screenCenter(Y);
        bgweekact1.alpha = 0;
        add(bgweekact1); // add it, pretty simple right ? -Z

        // add things on top of it -Z

        bg = new FlxSprite().loadGraphic(Paths.image('NewFreeplay/freeplaybg', 'shared'));
        // bg.setGraphicSize(Std.int(coolimage.width * 1)); // to resize if you need -Z
        bg.antialiasing = true; // no blur -Z
        bg.screenCenter(X); // screen center it on X -Z
        bg.screenCenter(Y);
        add(bg); // add it, pretty simple right ? -Z

        //Top thing -Z

        select = new FlxSprite(0, -40).loadGraphic(Paths.image('NewFreeplay/SELECT AN ACT', 'shared'));
        select.setGraphicSize(Std.int(select.width * 0.7)); // to resize if you need -Z
        select.antialiasing = true; // no blur -Z
        select.screenCenter(X); // screen center it on X -Z
        add(select); // add it, pretty simple right ? -Z

        // thing 

        lines = new FlxSprite().loadGraphic(Paths.image('NewFreeplay/the bars that seperate the acts', 'shared'));
        // lines.setGraphicSize(Std.int(coolimage.width * 1)); // to resize if you need -Z
        lines.antialiasing = true; // no blur -Z
        lines.screenCenter(X); // screen center it on X -Z
        lines.screenCenter(Y);
        add(lines); // add it, pretty simple right ? -Z
        //weeks

        act1 = new FlxSprite(800, 250).loadGraphic(Paths.image('NewFreeplay/ACT 1', 'shared'));
        act1.setGraphicSize(Std.int(act1.width * 0.7)); // to resize if you need -Z
        act1.antialiasing = true; // no blur -Z
        add(act1); // add it, pretty simple right ? -Z

        act2 = new FlxSprite(-50, 475).loadGraphic(Paths.image('NewFreeplay/ACT 2', 'shared'));
        act2.setGraphicSize(Std.int(act2.width * 0.7)); // to resize if you need -Z
        act2.antialiasing = true; // no blur -Z
        add(act2); // add it, pretty simple right ? -Z

        act3 = new FlxSprite(375, 400).loadGraphic(Paths.image('NewFreeplay/ACT 3', 'shared'));
        act3.setGraphicSize(Std.int(act3.width * 0.7)); // to resize if you need -Z
        act3.antialiasing = true; // no blur -Z
        add(act3); // add it, pretty simple right ? -Z

        act4 = new FlxSprite(700, 485).loadGraphic(Paths.image('NewFreeplay/ACT 4', 'shared'));
        act4.setGraphicSize(Std.int(act4.width * 0.7)); // to resize if you need -Z
        act4.antialiasing = true; // no blur -Z
        add(act4); // add it, pretty simple right ? -Z

        promise = new FlxSprite(-50, 250).loadGraphic(Paths.image('NewFreeplay/PROMISE', 'shared'));
        promise.setGraphicSize(Std.int(promise.width * 0.7)); // to resize if you need -Z
        promise.antialiasing = true; // no blur -Z
        add(promise); // add it, pretty simple right ? -Z

        prologue = new FlxSprite(340, 175).loadGraphic(Paths.image('NewFreeplay/PROLOGUE', 'shared'));
        prologue.setGraphicSize(Std.int(prologue.width * 0.7)); // to resize if you need -Z
        prologue.antialiasing = true; // no blur -Z
        add(prologue); // add it, pretty simple right ? -Z

        bonussongs = new FlxSprite(0, 575).loadGraphic(Paths.image('NewFreeplay/BONUS SONGS', 'shared'));
        bonussongs.setGraphicSize(Std.int(bonussongs.width * 0.7)); // to resize if you need -Z
        bonussongs.antialiasing = true; // no blur -Z
        bonussongs.screenCenter(X); // screen center it on X -Z
        add(bonussongs); // add it, pretty simple right ? -Z

    }


    override public function update(elapsed:Float) // Update per frame -Z
    {
        super.update(elapsed); // don't delete -Z
        
		if (controls.BACK)
            {
                FlxG.switchState(new MainMenuState());
            }
        
		if (controls.LEFT_P)
            {
                curSelected -= 1;
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
            }
		if (controls.RIGHT_P)
            {
                curSelected += 1;
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
            }
        if (FlxG.keys.justPressed.ENTER)
        {
            FlxG.sound.play(Paths.sound('confirmMenu'));
            FlxG.switchState(new FreeplayState()); // to go into title state -Z
        }

// code for selecting, looking good !!!! -Z

        //for sound -Z

        if (curSelected < 0) // just to reset -Z
            {
                curSelected = 7;
            }

            if (curSelected == 0)
                { 
                promise.alpha = 1;
            act1.alpha = 1;
            act2.alpha = 1;
            act3.alpha = 1;
            act4.alpha = 1;
            prologue.alpha = 1;
            bonussongs.alpha = 1;
            lines.alpha = 1;
            hipromisesongsplease = true;
            hiprologuesongsplease = false;
            hiact1songsplease = false;
            hibonussongssongsplease = false;
            if (bgweekpromise.alpha != 0)
                bgweekpromise.alpha -= 0.01;
            if (bg.alpha != 1)
                bg.alpha += 0.01;
            if (bgweekprologue.alpha != 0)
                bgweekprologue.alpha -= 0.01;
            if (bgweekact1.alpha != 0)
                bgweekact1.alpha -= 0.01;
            }
                    if (curSelected == 1)
                   {
                    promise.alpha = 1;
                    act1.alpha = 0.25;
                    act2.alpha = 0.25;
                    act3.alpha = 0.25;
                    act4.alpha = 0.25;
                    prologue.alpha = 0.25;
                    bonussongs.alpha = 0.25;
                    //bg.alpha = 1;
                    //bgweekpromise.alpha = 0;
                    //bgweekprologue.alpha = 0;
                    //bgweekact1.alpha = 0;
                    lines.alpha = 0.25;
                    hipromisesongsplease = true;
                    hiprologuesongsplease = false;
                    hiact1songsplease = false;
                    hibonussongssongsplease = false;

                        if (bgweekpromise.alpha != 1)
                            bgweekpromise.alpha += 0.01;
                        if (bg.alpha != 0)
                            bg.alpha -= 0.01;
                        if (bgweekprologue.alpha != 0)
                            bgweekprologue.alpha -= 0.01;
                        if (bgweekact1.alpha != 0)
                            bgweekact1.alpha -= 0.01;
                  }



            if (curSelected == 2) //
                {
                promise.alpha = 0.25;
                prologue.alpha = 1;
                act1.alpha = 0.25;
                act2.alpha = 0.25;
                act3.alpha = 0.25;
                act4.alpha = 0.25;
                bonussongs.alpha = 0.25;
                //bg.alpha = 0;
                //bgweekpromise.alpha = 1;
                //bgweekact1.alpha = 0;
                //bgweekprologue.alpha = 0;
                lines.alpha = 0.25;
                hipromisesongsplease = false;
                hiprologuesongsplease = true;
                hiact1songsplease = false;
                hibonussongssongsplease = false;
                    if (bgweekpromise.alpha != 0)
                        bgweekpromise.alpha -= 0.01;
                    if (bg.alpha != 0)
                        bg.alpha -= 0.01;
                    if (bgweekprologue.alpha != 1)
                        bgweekprologue.alpha += 0.01;
                    if (bgweekact1.alpha != 0)
                        bgweekact1.alpha -= 0.01;

            }

            if (curSelected == 3) //
                {
                promise.alpha = 0.25;
                act1.alpha = 1;
                act2.alpha = 0.25;
                act3.alpha = 0.25;
                act4.alpha = 0.25;
                prologue.alpha = 0.25;
                bonussongs.alpha = 0.25;
                //bg.alpha = 0;
                //bgweekpromise.alpha = 0;
                //bgweekprologue.alpha = 1;
                //bgweekact1.alpha = 0;
                lines.alpha = 0.25;
                hipromisesongsplease = false;
                hiprologuesongsplease = false;
                hiact1songsplease = true;
                hibonussongssongsplease = false;
                    if (bgweekpromise.alpha != 0)
                        bgweekpromise.alpha -= 0.01;
                    if (bgweekprologue.alpha != 0)
                        bgweekprologue.alpha -= 0.01;
                    if (bgweekact1.alpha != 1)
                        bgweekact1.alpha += 0.01;
                    if (bg.alpha != 0)
                        bg.alpha -= 0.01;
                }

            if (curSelected == 4) //
                {
                promise.alpha = 0.25;
                act1.alpha = 0.25;
                act2.alpha = 1;
                act3.alpha = 0.25;
                act4.alpha = 0.25;
                prologue.alpha = 0.25;
                bonussongs.alpha = 0.25;
                //bg.alpha = 1;
                //bgweekpromise.alpha = 0;
                //bgweekprologue.alpha = 0;
                //bgweekact1.alpha = 0;
                lines.alpha = 0.25;
                if (bgweekpromise.alpha != 0)
                    bgweekpromise.alpha -= 0.01;
                if (bg.alpha != 1)
                    bg.alpha += 0.01;
                if (bgweekprologue.alpha != 0)
                    bgweekprologue.alpha -= 0.01;
                if (bgweekact1.alpha != 0)
                    bgweekact1.alpha -= 0.01;
                hibonussongssongsplease = true;
                }
            
                if (curSelected == 5) //
                {
                promise.alpha = 0.25;
                act1.alpha = 0.25;
                act2.alpha = 0.25;
                act3.alpha = 1;
                act4.alpha = 0.25;
                prologue.alpha = 0.25;
                bonussongs.alpha = 0.25;
                //bg.alpha = 1;
                //bgweekpromise.alpha = 0;
                //bgweekprologue.alpha = 0;
                //bgweekact1.alpha = 0;
                lines.alpha = 0.25;
                if (bgweekpromise.alpha != 0)
                    bgweekpromise.alpha -= 0.01;
                if (bg.alpha != 1)
                    bg.alpha += 0.01;
                if (bgweekprologue.alpha != 0)
                    bgweekprologue.alpha -= 0.01;
                if (bgweekact1.alpha != 0)
                    bgweekact1.alpha -= 0.01;
                hibonussongssongsplease = true;
                }
            
                if (curSelected == 6) //
                {
                promise.alpha = 0.25;
                act1.alpha = 0.25;
                act2.alpha = 0.25;
                act3.alpha = 0.25;
                act4.alpha = 1;
                prologue.alpha = 0.25;
                bonussongs.alpha = 0.25;
                //bg.alpha = 1;
                //bgweekpromise.alpha = 0;
                //bgweekprologue.alpha = 0;
                //bgweekact1.alpha = 0;
                lines.alpha = 0.25;
                if (bgweekpromise.alpha != 0)
                    bgweekpromise.alpha -= 0.01;
                if (bg.alpha != 1)
                    bg.alpha += 0.01;
                if (bgweekprologue.alpha != 0)
                    bgweekprologue.alpha -= 0.01;
                if (bgweekact1.alpha != 0)
                    bgweekact1.alpha -= 0.01;
                hibonussongssongsplease = true;
                }

            if (curSelected == 7) //
                {
                promise.alpha = 0.25;
                act1.alpha = 0.25;
                act2.alpha = 0.25;
                act3.alpha = 0.25;
                act4.alpha = 0.25;
                prologue.alpha = 0.25;
                bonussongs.alpha = 1;
                //bg.alpha = 1;
                //bgweekpromise.alpha = 0;
                //bgweekprologue.alpha = 0;
                //bgweekact1.alpha = 0;
                lines.alpha = 0.25;
                hipromisesongsplease = false;
                hiprologuesongsplease = false;
                hiact1songsplease = false;
                hibonussongssongsplease = true;
                    if (bgweekpromise.alpha != 0)
                        bgweekpromise.alpha -= 0.01;
                    if (bg.alpha != 1)
                        bg.alpha += 0.01;
                    if (bgweekprologue.alpha != 0)
                        bgweekprologue.alpha -= 0.01;
                    if (bgweekact1.alpha != 0)
                        bgweekact1.alpha -= 0.01;
                }

            if (curSelected > 7) // reset if more -Z
                curSelected = 0;


    }
    

}