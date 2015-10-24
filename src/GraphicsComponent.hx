import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Entity;
import luxe.Color;
import luxe.Particles;
import luxe.options.ParticleOptions;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

// Component function: Handles graphics and animation for the (sprite) entity

class GraphicsComponent extends Component {
	var image : Texture;
	var anim : SpriteAnimation;

	var sprite : Sprite;

	var particles:ParticleSystem;
	var emitter:ParticleEmitter;

	override function onadded() {
		sprite = cast entity;


			//load the image
		image = Luxe.resources.texture('assets/characters/notlink.png');

			//keep pixels crisp
		image.filter_min = image.filter_mag = FilterType.nearest;

			//work out the correct size based on a ratio with the screen size
		var pixelRatio = 4;
		var frame_width = 16;
		var height = frame_width * pixelRatio;
		var width = frame_width * pixelRatio;

		sprite.texture = image;
		//sprite.pos = new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y);
		//sprite.size = new Vector(width, height);

		sprite.pos = new Vector(300, 200);
		sprite.size = new Vector(width, height);
		sprite.depth = 1;
			//create the animation from a simple json string,
			//the frameset structure allows us to specify things like
			//"animate frames 1-3 and then hold for 2 frames" etc.
		var anim_object = Luxe.resources.json('assets/anim.json');

			//create the animation component and add it to the sprite
		anim = sprite.add( new SpriteAnimation({ name:'anim' }) );

			//create the animations from the json
		anim.add_from_json_object( anim_object.asset.json );

			//set the idle animation to active
		anim.animation = 'walkup';
		anim.play();

		particles = new ParticleSystem({name: 'attackparticles'});
		var template:ParticleEmitterOptions = {
			name: 'particleemitter',
			emit_time: 0.2,
			emit_count: 3,
			direction: 0,
			direction_random: 297,
			speed: 2.4,
			speed_random: 0,
			end_speed: 0,
			life: 0.9,
			life_random: 0,
			rotation: 40,
			rotation_random: 130,
			end_rotation: 0,
			end_rotation_random: 0,
			rotation_offset: 0,
			pos_offset: new Vector(0, 0),
			pos_random: new Vector(5, 5),
			gravity: new Vector(0, -90),
			start_size: new Vector(32, 32),
			start_size_random: new Vector(0, 0),
			end_size: new Vector(8, 8),
			end_size_random: new Vector(0, 0),
			start_color: new ColorHSV(180, 1, 0.5, 1),
			end_color: new ColorHSV(159, 1, 0.5, 1),
			depth : 2
		}
		particles.add_emitter(template);
		emitter = particles.get('particleemitter');
		emitter.init();
		emitter.stop();

	}

	override function update( dt:Float ) {
		var moving = entity.get('playerInputComp').moving;
		var slashing = entity.get('playerInputComp').slashing;
		

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

		if (slashing){
		particles.pos = sprite.pos;
		emitter.start(.2);
		}

	} //update

}