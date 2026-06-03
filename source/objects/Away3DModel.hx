package objects;

#if desktop
import away3d.core.base.Object3D;
import away3d.containers.ObjectContainer3D;
import openfl.display.Sprite;
#end

/**
 * Wrapper around an Away3D Object3D.
 *
 * This is intentionally version-light because Away3D FBX loading APIs differ
 * between forks/haxelibs.
 */
class Away3DModel extends Sprite
{
	#if desktop
	public var object3d:Object3D;
	public var loaded:Bool = false;

	var _pendingAttach:Bool = false;

	public function new()
	{
		super();
	}

	/**
	 * Attach to an Away3D View3D.
	 * Actual FBX loading is performed by loadFBX() in this wrapper.
	 */
	public function attach(view:Dynamic):Void
	{
		// view type differs by Away3D versions; keep generic.
		if(view == null) return;
		if(object3d == null) {
			_pendingAttach = true;
			return;
		}

		// Typical Away3D pattern: view.scene.addChild(object3d) or view.scene.addChild(container)
		try {
			if(Reflect.hasField(view, 'scene')) {
				var scene:Dynamic = Reflect.field(view, 'scene');
				if(Reflect.hasField(scene, 'addChild')) scene.addChild(object3d);
			}
		} catch(e:Dynamic) {}
		_pendingAttach = false;
	}

	/**
	 * Loads an FBX model.
	 *
	 * IMPORTANT: FBX import support depends on the exact Away3D haxelib.
	 *
	 * For now, this method is a stub that must be wired to your importer.
	 */
	public function loadFBX(_fbxPath:String):Void
	{
		loaded = false;
		// FBX import support depends on additional importer tooling.
		// With only base Away3D (5.0.9), FBX parsing is typically not available out-of-the-box.
		//
		// If your FBX importing path exists, wire it here and set:
		// - object3d = loaded mesh/container
		// - loaded = true
		//
		// For now we keep it as a stub so compilation succeeds.
		#if debug
		throw 'Away3DModel.loadFBX() stub: FBX importer not wired for this build. Provide an importer or use a pre-converted Away3D mesh format.';
		#end
	}


	public function update(_elapsed:Float):Void
	{
		// stub; some importers require per-frame updates
	}

	// Convenience setters
	public inline function setPosition3D(x:Float, y:Float, z:Float):Void
	{
		#if desktop
		if(object3d != null) {
			object3d.x = x;
			object3d.y = y;
			object3d.z = z;
		}
		#end
	}
	public inline function setRotation3D(x:Float, y:Float, z:Float):Void
	{
		#if desktop
		if(object3d != null) {
			object3d.rotationX = x;
			object3d.rotationY = y;
			object3d.rotationZ = z;
		}
		#end
	}
	public inline function setScale3D(x:Float, y:Float, z:Float):Void
	{
		#if desktop
		if(object3d != null) {
			object3d.scaleX = x;
			object3d.scaleY = y;
			object3d.scaleZ = z;
		}
		#end
	}
	#else
	public function new() { super(); }
	public inline function attach(_view:Dynamic):Void {}
	public inline function loadFBX(_fbxPath:String):Void {}
	public inline function update(_elapsed:Float):Void {}
	#end
}

