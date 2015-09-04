import luxe.Input;
import luxe.Color;
import luxe.Vector;

import luxe.Component;
import luxe.Entity;

import luxe.Parcel;
import luxe.ParcelProgress;

import luxe.Sprite;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

class Main extends luxe.Game {

	//var playerChar = new GameObject( {name:'playerChar'})
	var image : Texture;
	var player : Sprite;


	//these are altered by the screen size later
	var max_left : Float = 0;
	var max_right : Float = 0;

	override function ready() {

		//create a parcel that preloads the package

		var preload = new Parcel({
	        jsons:[ { id:'assets/anim.json' },
	        { id:'assets/particles.json' } ],
	        textures : [
	            { id: 'assets/characters/notlink.png' }
	        ],
        });



			//progress bar for preloading parcel
		new ParcelProgress({
			parcel      : preload,
			background  : new Color(1,1,1,0.85),
			oncomplete  : assets_loaded
		});


		preload.load();

	} //ready

	//called when assets are done loading
	function assets_loaded(_) {
		image = Luxe.resources.texture('assets/characters/notlink.png');
		player = new Sprite({
                name : "playerSprite",
				texture : image,
				pos : new Vector( 300, 200),
				size : new Vector(192,192)
			});
		//create_player();
		var playerInputComp = new InputComponent({name: 'playerInputComp'});
		var playerGraphicsComp = new GraphicsComponent({name: 'playerGraphicsComp'});
		player.add(playerInputComp);
		player.add(playerGraphicsComp);

	} //assets_loaded


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

	} //update


} //Main
