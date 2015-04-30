import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Entity;

import luxe.Sprite;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

// Component function: Handles graphics and animation for the (sprite) entity

class GraphicsComponent extends Component {
	var image : Texture;
	var anim : SpriteAnimation;

	var sprite : Sprite;

	override function onadded() {
		sprite = cast entity;


			//load the image
		image = Luxe.loadTexture('assets/characters/notlink.png');

			//keep pixels crisp
		image.filter = FilterType.nearest;

			//work out the correct size based on a ratio with the screen size
		var pixelRatio = 4;
		var frame_width = 16;
		var height = frame_width * pixelRatio;
		var width = frame_width * pixelRatio;

		sprite.texture = image;
		sprite.pos = new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y);
		sprite.size = new Vector(width, height);

			//create the animation from a simple json string,
			//the frameset structure allows us to specify things like
			//"animate frames 1-3 and then hold for 2 frames" etc.
		var anim_object = Luxe.resources.find_json('assets/anim.json');

			//create the animation component and add it to the sprite
		anim = sprite.add( new SpriteAnimation({ name:'anim' }) );

			//create the animations from the json
		anim.add_from_json_object( anim_object.json );

			//set the idle animation to active
		anim.animation = 'walkup';
		anim.play();



	}

	override function update( dt:Float ) {
		var moving = entity.get('playerInputComp').moving;



		//set the correct animation

		switch moving {
			case 1: {
				if(!anim.playing) anim.play();
				if (anim.animation != 'walkup')
					anim.animation = 'walkup';
			}
			case (2 | 4 ): {
				if(!anim.playing) anim.play();
				if (anim.animation != 'walkside')
					anim.animation = 'walkside';
			}
			case 3: {
				if(!anim.playing) anim.play();
				if (anim.animation != 'walkdown')
					anim.animation = 'walkdown';
			}
			case 0: {
				if (anim.playing)
					anim.stop();
			}
		}
	} //update

}