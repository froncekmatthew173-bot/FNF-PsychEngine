package objects;

import openfl.Lib;
import openfl.display.Sprite;

#if desktop
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxCamera;
import openfl.display.Stage;
import away3d.containers.View3D;
import away3d.core.base.Object3D;
import away3d.cameras.Camera3D;
import away3d.lights.LightBase;
#end

/**
 * Minimal Away3D scene wrapper for PsychEngine.
 *
 * Note: Away3D FBX importing support varies by haxelib fork.
 * This class just provides a container View3D and update hooks.
 */
class Away3DScene extends Sprite
{
	#if desktop
	public var view:View3D;
	public var camera:Camera3D;
	var models:Array<Away3DModel> = [];

	public function new()
	{
		super();
		// Create a View3D. Away3D's Haxe API differs slightly between versions,
		// so this file is intentionally minimal.
		view = new View3D();
		addChild(Lib.current.stage == null ? cast view : cast view);

		camera = view.camera;
	}

	public inline function addModel(model:Away3DModel):Void
	{
		if(model == null) return;
		models.push(model);
		model.attach(view);
	}

	public function syncCameraFromFlxCamera(_cam:FlxCamera):Void
	{
		// Initial stub: let the user tune after first integration.
		// Proper mapping will be handled once we know the exact Away3D version.
	}

	public function update(elapsed:Float):Void
	{
		for(m in models) m.update(elapsed);
		// away3d's rendering is handled by its internal pipeline when view is on stage.
	}
	#else
	public function new() { super(); }
	public inline function addModel(model:Away3DModel):Void {}
	public inline function syncCameraFromFlxCamera(_cam:Dynamic):Void {}
	public inline function update(_elapsed:Float):Void {}
	#end
}

