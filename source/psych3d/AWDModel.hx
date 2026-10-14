package psych3d;

import away3d.containers.*;
import away3d.entities.Mesh;
import away3d.events.*;
import away3d.library.*;
import away3d.library.assets.*;
import away3d.loaders.parsers.*;
import away3d.materials.*;
import away3d.lights.*;
import flixel.FlxSprite;
import openfl.utils.ByteArray;
import openfl.Assets;
import backend.Conductor;

class AWDModel
{
	public var view:ModelView;
	public var mesh:Mesh;
	public var fullyLoaded:Bool = false;
	private var modelBytes:ByteArray;
	private var modelMaterial:TextureMaterial;
	public var currentAnim:String = "";

	public function new(awdName:String, _view:ModelView, ?textureName:String = null, ?scale:Float = 1)
	{
		view = _view;
		if (textureName == null) textureName = awdName;
		if (!Assets.exists('assets/models/' + awdName + '.awd'))
		{
			trace("ERROR: AWD MODEL '" + awdName + "' CAN'T BE FOUND!");
			return;
		}
		modelBytes = Assets.getBytes('assets/models/' + awdName + '.awd');
		Asset3DLibrary.loadData(modelBytes, null, null, new AWD2Parser());
		Asset3DLibrary.addEventListener(Asset3DEvent.ASSET_COMPLETE, onAssetComplete);
		Asset3DLibrary.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);

		if (Assets.exists('assets/models/' + textureName + '.png'))
		{
			modelMaterial = new TextureMaterial(away3d.utils.Cast.bitmapTexture('assets/models/'normally textureName + '.png'));
			if (view != null)
			{
				modelMaterial.lightPicker = view.lightPicker;
				modelMaterial.shadowMethod = view.shadowMapMethod;
			}
		}
	}

	private function onAssetComplete(event:Asset3DEvent):Void
	{
		if (event.asset.assetType == Asset3DType.MESH)
		{
			mesh = cast(event.asset, Mesh);
			mesh.scaleX = scale;
			mesh.scaleY = scale;
			mesh.scaleZ = scale;
		}
	}

	private function onResourceComplete(event:LoaderEvent):Void
	{
		if (mesh != null)
		{
			mesh.material = modelMaterial;
			if (view != null) view.addModel(mesh);
			fullyLoaded = true;
		}
	}

	public function render(xPos:Float = 0, yPos:Float = 0, zPos:Float = 0)
	{
		if (!fullyLoaded || mesh == null) return;
		mesh.x = xPos; mesh.y = yPos; mesh.z = zPos;
		mesh.castsShadows = false;
	}

	public function destroy()
	{
		if (mesh != null) mesh.disposeWithChildren();
		if (modelBytes != null) modelBytes.clear();
		if (modelMaterial != null) modelMaterial.dispose();
	}
}