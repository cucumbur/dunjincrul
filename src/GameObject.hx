import luxe.Entity;

class GameObject extends Entity {


    public var oncerun : Bool = false;


    override function init() {
        trace('\tgameobject init');
    } //init

    override function onreset() {
        trace('\tgameobject reset');
    } //onreset

    override function ondestroy() {
        trace('\tgameobject destroyed');
    } //ondestroy

    override function update(dt:Float) {
        if(!oncerun){
            trace('\tgameobject first update ' + dt);
            oncerun = true;
        }
    } //update


} //FakeGameObject