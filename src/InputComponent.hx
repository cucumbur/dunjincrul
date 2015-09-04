import luxe.Component;
import luxe.Sprite;
import luxe.Input;
import luxe.States;


// comp function: Make the attached entity respond to user input

class InputComponent extends Component {

	var move_speed : Float = 100;
	var sprite : Sprite;
	var moving = 0;
	var slashing = 0;
	var walkingMachine : States;



	override function onadded() {
		sprite = cast entity;
		setupStateMachine();

		//binding input to some predefined keys.
		//could generalize this
		Luxe.input.bind_key('left', Key.left);
		Luxe.input.bind_key('left', Key.key_a);

		Luxe.input.bind_key('right', Key.right);
		Luxe.input.bind_key('right', Key.key_d);

		Luxe.input.bind_key('up', Key.up);
		Luxe.input.bind_key('up', Key.key_w);

		Luxe.input.bind_key('down', Key.down);
		Luxe.input.bind_key('down', Key.key_s);

		Luxe.input.bind_key('attack', Key.key_z);


	}

	override function update( dt:Float ) {
		
		if(Luxe.input.inputdown('attack')) {
			slashing = 1;
		}

		else{ 
			slashing = 0;
		}


		if(Luxe.input.inputdown('left')) {

			sprite.pos.x -= move_speed * dt;
			sprite.flipx = true;

			moving = 4;

		} else if(Luxe.input.inputdown('right')) {

			sprite.pos.x += move_speed * dt;
			sprite.flipx = false;

			moving = 2;

		} //left/right

		if(Luxe.input.inputdown('up')) {

			sprite.pos.y -= move_speed * dt;

			moving = 1;

		} else if(Luxe.input.inputdown('down')) {

			sprite.pos.y += move_speed * dt;

			moving = 3;

		} //up/down

		if (!(Luxe.input.inputdown('left') || Luxe.input.inputdown('right') || Luxe.input.inputdown('up') || Luxe.input.inputdown('down'))){
			moving = 0;
		} // when not moving

	} //update

	private function setupStateMachine(){
		// walkingMachine = new States({name:'walkingstates'});
		// walkingMachine.add(new State('walkingup'));
		// walkingMachine.add(new State('walkingside'));
		// walkingMachine.add(new State('walkingdown'));
		// walkingMachine.add(new State('idle'));
		// walkingMachine.set('idle');
	}

} //InputComponent

