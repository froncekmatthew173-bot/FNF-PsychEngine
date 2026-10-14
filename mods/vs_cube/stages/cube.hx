import psych3d.ModelView;
import psych3d.ModelThing;

var modelView:ModelView;
var model:ModelThing;

function create()
{
	modelView = new ModelView();
	model = new ModelThing("cube", modelView, 1.0, 100);
	if (model != null) model.render(0, 0, 0);

	if (modelView != null)
	{
		var spr:FlxSprite = modelView.sprite;
		spr.screenCenter();
		spr.scale.set(0.6, 0.6);
		game.add(spr);
	}
}

function update(elapsed:Float)
{
	if (modelView != null) modelView.update();
	// model rotation
	if (model != null && model.mesh != null)
	{
		model.addYaw(elapsed * 180);
	}
}