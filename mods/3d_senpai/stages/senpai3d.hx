@'
import psych3d.AWDModel;
import psych3d.ModelView;

var modelView:ModelView;
var model:AWDModel;

function create()
{
    modelView = new ModelView();
    model = new AWDModel('senpai', modelView, 1.0);
    if (modelView != null)
    {
        var spr:FlxSprite = modelView.sprite;
        spr.scale.set(0.35, 0.35);
        game.add(spr);
    }
}

function update(elapsed:Float)
{
    if (modelView != null) modelView.update();
    if (model != null && model.mesh != null)
    {
        // no animation methods; rotate for preview
    }
}
'@
