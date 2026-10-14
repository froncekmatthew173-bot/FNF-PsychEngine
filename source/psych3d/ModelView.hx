package psych3d;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import away3d.animators.*;
import away3d.containers.*;
import away3d.controllers.*;
import away3d.debug.*;
import away3d.entities.*;
import away3d.events.*;
import away3d.library.*;
import away3d.library.assets.*;
import away3d.lights.*;
import away3d.loaders.parsers.*;
import away3d.materials.*;
import away3d.materials.lightpickers.*;
import away3d.materials.methods.*;
import away3d.primitives.*;
import away3d.utils.Cast;
import openfl.display.*;
import openfl.events.*;
import openfl.filters.*;
import openfl.geom.*;
import openfl.text.*;
import openfl.ui.*;
import openfl.utils.ByteArray;
import openfl.Assets;
import openfl.Vector;

/**
 * Psych3D — ports FPS Plus (Rozebud/doggy-dentures) Away3D model viewing.
 *
 * Composite strategy: the 3D Scene is rendered into a BitmapData (450x450)
 * that is re-loaded into a normal 2D FlxSprite every frame. Flixel's 2D
 * rendering (notes/UI) then draws on top, so the 3D models never get z-fight
 * behind the 2D layer. Models added with addModel() show up in the scene.
 */
class ModelView
{
	// Engine vars
	public var view:View3D;
	public var cameraController:HoverController;
	private var _lookAtPosition:Vector3D = new Vector3D();

	// Light objects
	private var light:DirectionalLight;

	public var lightPicker:StaticLightPicker;
	public var shadowMapMethod:FilteredShadowMapMethod;

	// Flx objects the engine uses
	private var bmd:BitmapData;
	public var sprite:FlxSprite = new FlxSprite();

	// Track models added
	public var addedModels:Array<ModelThing> = [];

	public function new()
	{
		view = new View3D();
		view.width = 450;
		view.height = 450;

		FlxG.addChildBelowMouse(view);

		view.camera.lens.far = 5000;
		cameraController = new HoverController(view.camera, null, 90, 0, 300);
		cameraController.lookAtPosition = _lookAtPosition;

		light = new DirectionalLight(-0.5, -1, -1);
		light.ambient = 0.4;
		lightPicker = new StaticLightPicker([light]);
		view.scene.addChild(light);

		shadowMapMethod = new FilteredShadowMapMethod(light);

		bmd = new BitmapData(Std.int(view.width), Std.int(view.height), true, 0x0);
		sprite.loadGraphic(bmd);
	}

	public function update()
	{
		view.backgroundAlpha = 0;
		view.renderer.queueSnapshot(bmd);
		view.render();
		view.backgroundAlpha = 1;

		sprite.loadGraphic(bmd);
		sprite.graphic.persist = true;
	}

	public function addModel(model:Mesh)
	{
		view.scene.addChild(model);
	}

	public function clear()
	{
		for (i in 0...view.scene.numChildren)
		{
			if (view.scene.getChildAt(i) != null)
				view.scene.removeChildAt(i);
		}
	}
}