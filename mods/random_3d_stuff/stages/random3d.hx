import psych3d.ModelView;
import psych3d.ModelThing;
import psych3d.AWDModel;

var modelView:ModelView;
var md2s:Array<ModelThing> = [];
var awd:AWDModel;

function create()
{
    modelView = new ModelView();
    md2s.push(new ModelThing('crash', modelView, 1.0, 100));
    md2s.push(new ModelThing('steve', modelView, 1.0, 100));
    awd = new AWDModel('skeleton', modelView, 1.0);

    if (modelView != null)
    {
        var spr = modelView.sprite;
        spr.scale.set(0.5, 0.5);
        spr.screenCenter();
        game.add(spr);
    }
}

function update(elapsed:Float)
{
    if (modelView != null) modelView.update();
    for (m in md2s)
    {
        if (m.fullyLoaded && m.mesh != null) m.addYaw(elapsed * 30);
    }
}

function updatePost(elapsed:Float) {}
