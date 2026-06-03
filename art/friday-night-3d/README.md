Friday_Night_3D Unreal Assets
=============================

Source: https://github.com/Shadowhawk69420/Friday_Night_3D

The upstream project is an Unreal Engine 4.26 project. The Boyfriend assets copied here are `.uasset` files, which Psych Engine/HaxeFlixel cannot load directly.

UEViewer
--------

UEViewer was tested from `gildor2/UEViewer` using the included `umodel.exe`.

Working command/tag:

```powershell
umodel.exe -list "-game=ue4.25+" -path="<Friday_Night_3D>/Content" models/Characters/Boyfriend/Boyfriend.uasset
```

Results:
- UEViewer can list the BF mesh package and detects `SkeletalMesh Boyfriend`.
- UEViewer can export `textures/Boyfriend_Texture.uasset` as PNG.
- Exported texture preview is stored at `assets/shared/images/friday-night-3d/models/Characters/Boyfriend/textures/Boyfriend_Texture.png`.
- UEViewer could not export the BF skeletal mesh from this uncooked/editor asset. The mesh export failed with `Serializing behind stopper`.
- UEViewer could not export the BF animation packages as PSA/AnimSequence output; it reported unsupported `AnimSequence4`.

Texture export command:

```powershell
umodel.exe -export -png "-game=ue4.25+" -path="<Friday_Night_3D>/Content" -out="assets/shared/images/friday-night-3d" models/Characters/Boyfriend/textures/Boyfriend_Texture.uasset Boyfriend_Texture Texture2D
```

Because the mesh and animations failed in UEViewer, Unreal Engine 4.26 is still the reliable path for exporting the real BF model/animations.

Packaged Shadowing Build
------------------------

The packaged build at:

```text
C:\Users\mattf\Downloads\New folder (163)\friday_night_shadowing\Friday_night_shadowing\Windows\Friday_Night_3D\Content
```

contains cooked versions of the same kinds of assets.

Possible chart/timeline asset:

```text
charting\Shadow.uasset
charting\Shadow.uexp
```

Inspection notes:
- Raw strings identify it as a `/Script/LevelSequence` and `/Script/MovieScene` asset.
- It references `/Game/maps/Song_maps/Shadow_fight`.
- It references the audio stems:
  - `/Game/Music/Shadow/traffic_bf`
  - `/Game/Music/Shadow/traffic_inst`
  - `/Game/Music/Shadow/traffic_shadow`
  - `/Game/Music/Shadow/traffic_zavion`
- It references `PersistentLevel.Boyfriend_2`, `PersistentLevel.Girlfriend_2`, `PersistentLevel.Mannager_2`, and `PersistentLevel.Shadow_C_1`.
- It contains names like `Add_arrow_any`, `Add_arrow_custom`, and `Arrow_actions`, so it may drive notes/events through Unreal sequence events.
- It is not a plain Psych/FNF note chart and cannot be directly dropped into `assets/shared/data/traffic/`.
- UEViewer currently errors on this packaged asset with `UE4 LegacyVersion: unsupported value -8`.

Packaged BF model files:

```text
models\Characters\Boyfriend\Boyfriend.uasset
models\Characters\Boyfriend\Boyfriend.uexp
models\Characters\Boyfriend\Boyfriend_Skeleton.uasset
models\Characters\Boyfriend\Boyfriend_Skeleton.uexp
models\Characters\Boyfriend\textures\Boyfriend_Texture.uasset
models\Characters\Boyfriend\textures\Boyfriend_Texture.uexp
models\Characters\Boyfriend\textures\Boyfriend_Texture.ubulk
```

The packaged `Boyfriend.uasset` string table clearly names `SkeletalMesh`, `Skeleton`, `Boyfriend-Armature`, bones, morph targets, and materials, so this is the real cooked BF model package. UEViewer also fails on this packaged asset with `UE4 LegacyVersion: unsupported value -8`, so a different extractor or Unreal/asset tooling may be needed for the cooked build.

Current in-engine setup:
- `assets/shared/characters/april-bf-3d.json` is the playable Psych character.
- It uses `generated:april-bf-3d` as a temporary renderable proxy.
- The JSON keeps references to the Unreal source model, skeleton, texture, and main animation assets.
- `assets/shared/data/traffic/traffic.json` uses `april-bf-3d` as player 1.

To replace the proxy with the real 3D BF:
1. Install/open the source project in Unreal Engine 4.26.
2. Open the Boyfriend skeletal mesh and confirm these assets:
   - `Boyfriend.uasset`
   - `Boyfriend_Skeleton.uasset`
   - `textures/Boyfriend_Texture.uasset`
   - `animations/bf_idle.uasset`
   - `animations/bf_left.uasset`
   - `animations/bf_down.uasset`
   - `animations/bf_up.uasset`
   - `animations/Bf_right.uasset`
3. Export a Psych-compatible output:
   - Preferred: render animation frames to a PNG spritesheet plus Sparrow XML.
   - Alternative: export FBX/PNG workfiles, then render spritesheets in Blender or another tool.
4. Put the finished spritesheet/XML under `assets/shared/images/characters/`.
5. Update `assets/shared/characters/april-bf-3d.json`:
   - Change `image` from `generated:april-bf-3d` to the new `characters/...` asset.
   - Update animation `name` fields to match the exported XML prefixes.

The `.uasset` files are kept under `art/` so they are available as workfiles but are not packaged into the game build by `Project.xml`.
