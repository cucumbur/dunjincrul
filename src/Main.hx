
import luxe.Input;
import luxe.Color;
import luxe.Vector;

import luxe.Parcel;
import luxe.ParcelProgress;

import luxe.Sprite;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

class Main extends luxe.Game {

    var player : Sprite;
    var anim : SpriteAnimation;
    var image : Texture;

    //these are altered by the screen size later
    var max_left : Float = 0;
    var max_right : Float = 0;
    var move_speed : Float = 0;

	override function ready() {

		Luxe.loadJSON('assets/parcel.json', function(json_asset) {

			//then create a parcel to load it for us
			var preload = new Parcel();
				preload.from_json(json_asset.json);

			//but, we also want a progress bar for the parcel,
			//this is a default one, you can do your own
			new ParcelProgress({
				parcel      : preload,
				background  : new Color(1,1,1,0.85),
				oncomplete  : assets_loaded
			});

			//go!
            preload.load();
		});

	} //ready

    //called when assets are done loading
    function assets_loaded(_) {

        create_player();
        create_player_animation();
        connect_input();

    } //assets_loaded

    function create_player() {

            //load the image
        image = Luxe.loadTexture('assets/characters/notlink.png');

            //keep pixels crisp
        image.filter = FilterType.nearest;

            //work out the correct size based on a ratio with the screen size
        var pixelRatio = 4;
        var frame_width = 16;
        var height = frame_width * pixelRatio;
        var width = frame_width * pixelRatio;

            //this is an arbitrary ratio I made up :)
        move_speed = width*1.5;

            //screen edge boundary for walking
        max_right = Luxe.screen.w - (width/2);
        max_left = (width/2);

            //start with the idle texture
        player = new Sprite({
            name: 'player',
            texture: image,
            pos : new Vector(Luxe.screen.mid.x, Luxe.screen.h - (height/1.75)),
            size: new Vector(width, height)
        });

    } //create_player

    function create_player_animation() {

            //create the animation from a simple json string,
            //the frameset structure allows us to specify things like
            //"animate frames 1-3 and then hold for 2 frames" etc.
        var anim_object = Luxe.resources.find_json('assets/anim.json');

            //create the animation component and add it to the sprite
        anim = player.add( new SpriteAnimation({ name:'anim' }) );

            //create the animations from the json
        anim.add_from_json_object( anim_object.json );

            //set the idle animation to active
        anim.animation = 'walkup';
        anim.play();

    } //create_player_animation

    function connect_input() {

        //here, we are going to bind A/left and D/right into a single named
        //input event, so that we can keep our movement code the same when changing keys

        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);

        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);

        Luxe.input.bind_key('up', Key.up);
        Luxe.input.bind_key('up', Key.key_w);

        Luxe.input.bind_key('down', Key.down);
        Luxe.input.bind_key('down', Key.key_s);


    } //connect_input

	override function onkeyup( e:KeyEvent ) {

		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		}

	} //onkeyup

    override function update( delta:Float ) {

        //this can get called while waiting, so if it's not
        //ready we just return!
        if(player == null) {
            return;
        }

        var moving = 0;

        if(Luxe.input.inputdown('left')) {

            player.pos.x -= move_speed * delta;
            player.flipx = true;

            moving = 4;

        } else if(Luxe.input.inputdown('right')) {

            player.pos.x += move_speed * delta;
            player.flipx = false;

            moving = 2;

        } //left/right

        if(Luxe.input.inputdown('up')) {

            player.pos.y -= move_speed * delta;

            moving = 1;

        } else if(Luxe.input.inputdown('down')) {

            player.pos.y += move_speed * delta;

            moving = 3;

        } //left/right

           //limit to the screen edges
        if(player.pos.x >= max_right) {
            player.pos.x = max_right;
            moving = 0;
        }
        if(player.pos.x <= max_left) {
            player.pos.x = max_left;
            moving = 0;
        }

            //set the correct animation
        if(moving==1) {
            if(anim.animation != 'walkup') {
                anim.animation = 'walkup';
            }
        } else if (moving==3){
            if(anim.animation != 'walkdown') {
                anim.animation = 'walkdown';
            }
        } else if (moving==2 || moving == 4){
            if(anim.animation != 'walkside') {
                anim.animation = 'walkside';
            }
        }

    } //update


} //Main
