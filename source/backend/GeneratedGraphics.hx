package backend;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

class GeneratedGraphics
{
	public static inline var PREFIX:String = 'generated:';

	static final FRAME_W:Int = 360;
	static final FRAME_H:Int = 460;
	static final ICON_W:Int = 150;
	static final ICON_H:Int = 150;
	static final LOGO_W:Int = 500;
	static final LOGO_H:Int = 145;
	static final MODEL_W:Int = 360;
	static final MODEL_H:Int = 360;

	public static function isGenerated(id:String):Bool
		return id != null && id.startsWith(PREFIX);

	public static function atlas(id:String, ?allowGPU:Bool = true):FlxAtlasFrames
	{
		var kind:String = normalize(id);
		var names:Array<String> = ['idle', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'hey', 'confirm'];
		var bitmap:BitmapData = new BitmapData(FRAME_W * names.length, FRAME_H, true, 0x00000000);

		for (i in 0...names.length)
			drawCharacterFrame(bitmap, i * FRAME_W, 0, kind, names[i]);

		var graphic:FlxGraphic = Paths.cacheBitmap('images/generated/$kind.png', null, bitmap, allowGPU);
		return FlxAtlasFrames.fromSparrow(graphic, sparrowXml(names, FRAME_W, FRAME_H));
	}

	public static function icon(char:String, ?allowGPU:Bool = true):FlxGraphic
	{
		var kind:String = normalize(char);
		var names:Array<String> = ['normal', 'losing'];
		var bitmap:BitmapData = new BitmapData(ICON_W * names.length, ICON_H, true, 0x00000000);

		for (i in 0...names.length)
			drawIconFrame(bitmap, i * ICON_W, 0, kind, i == 1);

		return Paths.cacheBitmap('images/generated/icon-$kind.png', null, bitmap, allowGPU);
	}

	public static function storyMenuLogo(weekName:String, ?allowGPU:Bool = true):FlxGraphic
	{
		var text:String = switch (weekName)
		{
			case 'generated-shapes': 'TUTORIAL';
			case 'april-traffic': 'TRAFFIC';
			default: weekName.replace('-', ' ').toUpperCase();
		}
		var bitmap:BitmapData = new BitmapData(LOGO_W, LOGO_H, true, 0x00000000);
		drawBlockText(bitmap, text, 8, 22, 10, 0xFFFFFFFF, 0xFF000000);
		return Paths.cacheBitmap('images/generated/storymenu-$weekName.png', null, bitmap, allowGPU);
	}

	public static function modelProxy(id:String, ?allowGPU:Bool = true):FlxGraphic
	{
		var kind:String = normalize(id);
		var palette = getPalette(kind);
		var bitmap:BitmapData = new BitmapData(MODEL_W, MODEL_H, true, 0x00000000);

		rect(bitmap, 72, 90, 216, 170, palette.outline);
		rect(bitmap, 92, 110, 176, 130, palette.skin);
		rect(bitmap, 104, 248, 152, 26, palette.outline);
		rect(bitmap, 128, 274, 104, 40, palette.shirt);
		rect(bitmap, 88, 302, 184, 16, palette.pants);
		rect(bitmap, 122, 132, 116, 14, palette.outline);
		rect(bitmap, 122, 164, 116, 14, palette.outline);
		rect(bitmap, 122, 196, 116, 14, palette.outline);
		rect(bitmap, 150, 58, 60, 54, palette.mic);
		rect(bitmap, 166, 38, 28, 28, palette.outline);

		return Paths.cacheBitmap('images/generated/model-$kind.png', null, bitmap, allowGPU);
	}

	static function normalize(id:String):String
	{
		if (id == null || id.length < 1) return 'human';
		return id.startsWith(PREFIX) ? id.substr(PREFIX.length) : id;
	}

	static function sparrowXml(names:Array<String>, frameW:Int, frameH:Int):String
	{
		var xml:String = '<TextureAtlas imagePath="generated.png">';
		for (i in 0...names.length)
			xml += '<SubTexture name="${names[i]}0000" x="${i * frameW}" y="0" width="$frameW" height="$frameH"/>';
		return xml + '</TextureAtlas>';
	}

	static function drawCharacterFrame(bitmap:BitmapData, ox:Int, oy:Int, kind:String, pose:String):Void
	{
		var palette = getPalette(kind);
		var lean:Int = pose == 'singLEFT' ? -24 : (pose == 'singRIGHT' ? 24 : 0);
		var crouch:Int = pose == 'singDOWN' ? 28 : 0;
		var rise:Int = pose == 'singUP' || pose == 'hey' || pose == 'confirm' ? -24 : 0;
		var micX:Int = pose == 'singLEFT' ? -50 : (pose == 'singRIGHT' ? 50 : 0);
		var armY:Int = pose == 'singUP' || pose == 'hey' || pose == 'confirm' ? -54 : 0;

		switch(kind)
		{
			case 'animal', 'cat', 'dog':
				drawAnimalFrame(bitmap, ox, oy, palette, lean, crouch, rise, micX, armY);
				return;
			case 'monster', 'creature':
				drawMonsterFrame(bitmap, ox, oy, palette, lean, crouch, rise, micX, armY);
				return;
			case 'object', 'thing', 'prop':
				drawObjectFrame(bitmap, ox, oy, palette, lean, crouch, rise, micX);
				return;
		}

		rect(bitmap, ox + 92 + lean, oy + 112 + rise + crouch, 176, 24, palette.outline);
		rect(bitmap, ox + 116 + lean, oy + 136 + rise + crouch, 128, 96, palette.skin);
		rect(bitmap, ox + 104 + lean, oy + 232 + rise + crouch, 152, 148, palette.shirt);
		rect(bitmap, ox + 76 + lean, oy + 246 + rise + crouch + armY, 48, 138, palette.skin);
		rect(bitmap, ox + 236 + lean, oy + 246 + rise + crouch - armY, 48, 138, palette.skin);
		rect(bitmap, ox + 124 + lean, oy + 380 + rise + crouch, 52, 58, palette.pants);
		rect(bitmap, ox + 184 + lean, oy + 380 + rise + crouch, 52, 58, palette.pants);
		rect(bitmap, ox + 104 + lean, oy + 424 + rise + crouch, 76, 26, palette.outline);
		rect(bitmap, ox + 184 + lean, oy + 424 + rise + crouch, 76, 26, palette.outline);
		rect(bitmap, ox + 144 + lean, oy + 166 + rise + crouch, 18, 18, palette.outline);
		rect(bitmap, ox + 198 + lean, oy + 166 + rise + crouch, 18, 18, palette.outline);
		rect(bitmap, ox + 154 + lean, oy + 204 + rise + crouch, 52, 12, palette.outline);
		rect(bitmap, ox + 250 + lean + micX, oy + 306 + rise + crouch, 34, 34, palette.mic);
	}

	static function drawAnimalFrame(bitmap:BitmapData, ox:Int, oy:Int, palette:Dynamic, lean:Int, crouch:Int, rise:Int, micX:Int, armY:Int):Void
	{
		rect(bitmap, ox + 104 + lean, oy + 108 + rise + crouch, 48, 58, palette.outline);
		rect(bitmap, ox + 210 + lean, oy + 108 + rise + crouch, 48, 58, palette.outline);
		rect(bitmap, ox + 96 + lean, oy + 148 + rise + crouch, 166, 104, palette.skin);
		rect(bitmap, ox + 118 + lean, oy + 118 + rise + crouch, 24, 48, palette.skin);
		rect(bitmap, ox + 220 + lean, oy + 118 + rise + crouch, 24, 48, palette.skin);
		rect(bitmap, ox + 112 + lean, oy + 252 + rise + crouch, 140, 136, palette.shirt);
		rect(bitmap, ox + 62 + lean, oy + 270 + rise + crouch + armY, 52, 122, palette.skin);
		rect(bitmap, ox + 250 + lean, oy + 270 + rise + crouch - armY, 52, 122, palette.skin);
		rect(bitmap, ox + 126 + lean, oy + 388 + rise + crouch, 48, 56, palette.pants);
		rect(bitmap, ox + 190 + lean, oy + 388 + rise + crouch, 48, 56, palette.pants);
		rect(bitmap, ox + 244 + lean, oy + 350 + rise + crouch, 94, 24, palette.skin);
		rect(bitmap, ox + 140 + lean, oy + 184 + rise + crouch, 18, 18, palette.outline);
		rect(bitmap, ox + 202 + lean, oy + 184 + rise + crouch, 18, 18, palette.outline);
		rect(bitmap, ox + 168 + lean, oy + 208 + rise + crouch, 26, 20, palette.outline);
		rect(bitmap, ox + 250 + lean + micX, oy + 318 + rise + crouch, 34, 34, palette.mic);
	}

	static function drawMonsterFrame(bitmap:BitmapData, ox:Int, oy:Int, palette:Dynamic, lean:Int, crouch:Int, rise:Int, micX:Int, armY:Int):Void
	{
		rect(bitmap, ox + 92 + lean, oy + 98 + rise + crouch, 48, 70, palette.outline);
		rect(bitmap, ox + 220 + lean, oy + 98 + rise + crouch, 48, 70, palette.outline);
		rect(bitmap, ox + 100 + lean, oy + 142 + rise + crouch, 160, 112, palette.skin);
		rect(bitmap, ox + 96 + lean, oy + 252 + rise + crouch, 168, 154, palette.shirt);
		rect(bitmap, ox + 52 + lean, oy + 260 + rise + crouch + armY, 64, 148, palette.skin);
		rect(bitmap, ox + 244 + lean, oy + 260 + rise + crouch - armY, 64, 148, palette.skin);
		rect(bitmap, ox + 52 + lean, oy + 390 + rise + crouch + armY, 78, 24, palette.outline);
		rect(bitmap, ox + 230 + lean, oy + 390 + rise + crouch - armY, 78, 24, palette.outline);
		rect(bitmap, ox + 118 + lean, oy + 404 + rise + crouch, 56, 54, palette.pants);
		rect(bitmap, ox + 190 + lean, oy + 404 + rise + crouch, 56, 54, palette.pants);
		rect(bitmap, ox + 132 + lean, oy + 176 + rise + crouch, 30, 30, palette.outline);
		rect(bitmap, ox + 198 + lean, oy + 176 + rise + crouch, 30, 30, palette.outline);
		rect(bitmap, ox + 146 + lean, oy + 222 + rise + crouch, 70, 18, palette.outline);
		rect(bitmap, ox + 162 + lean, oy + 240 + rise + crouch, 16, 22, 0xFFFFFFFF);
		rect(bitmap, ox + 194 + lean, oy + 240 + rise + crouch, 16, 22, 0xFFFFFFFF);
		rect(bitmap, ox + 250 + lean + micX, oy + 320 + rise + crouch, 34, 34, palette.mic);
	}

	static function drawObjectFrame(bitmap:BitmapData, ox:Int, oy:Int, palette:Dynamic, lean:Int, crouch:Int, rise:Int, micX:Int):Void
	{
		rect(bitmap, ox + 94 + lean, oy + 132 + rise + crouch, 172, 172, palette.outline);
		rect(bitmap, ox + 110 + lean, oy + 148 + rise + crouch, 140, 140, palette.skin);
		rect(bitmap, ox + 128 + lean, oy + 178 + rise + crouch, 24, 24, palette.outline);
		rect(bitmap, ox + 208 + lean, oy + 178 + rise + crouch, 24, 24, palette.outline);
		rect(bitmap, ox + 150 + lean, oy + 236 + rise + crouch, 62, 16, palette.outline);
		rect(bitmap, ox + 72 + lean, oy + 280 + rise + crouch, 62, 34, palette.shirt);
		rect(bitmap, ox + 226 + lean, oy + 280 + rise + crouch, 62, 34, palette.shirt);
		rect(bitmap, ox + 130 + lean, oy + 324 + rise + crouch, 46, 58, palette.pants);
		rect(bitmap, ox + 188 + lean, oy + 324 + rise + crouch, 46, 58, palette.pants);
		rect(bitmap, ox + 250 + lean + micX, oy + 292 + rise + crouch, 34, 34, palette.mic);
	}

	static function drawIconFrame(bitmap:BitmapData, ox:Int, oy:Int, kind:String, losing:Bool):Void
	{
		var palette = getPalette(kind);
		if(kind == 'animal' || kind == 'cat' || kind == 'dog')
		{
			rect(bitmap, ox + 24, oy + 10, 34, 44, palette.outline);
			rect(bitmap, ox + 92, oy + 10, 34, 44, palette.outline);
		}
		else if(kind == 'monster' || kind == 'creature')
		{
			rect(bitmap, ox + 18, oy + 8, 34, 52, palette.outline);
			rect(bitmap, ox + 98, oy + 8, 34, 52, palette.outline);
		}
		rect(bitmap, ox + 18, oy + 18, 114, 114, palette.outline);
		rect(bitmap, ox + 28, oy + 28, 94, 94, losing ? palette.shirt : palette.skin);
		rect(bitmap, ox + 46, oy + 54, 14, 14, palette.outline);
		rect(bitmap, ox + 90, oy + 54, 14, 14, palette.outline);
		rect(bitmap, ox + 52, oy + (losing ? 98 : 90), 46, 10, palette.outline);
	}

	static function drawBlockText(bitmap:BitmapData, text:String, x:Int, y:Int, size:Int, outline:Int, fill:Int):Void
	{
		var cursor:Int = x;
		for (i in 0...text.length)
		{
			var letter:String = text.charAt(i);
			if(letter == ' ')
			{
				cursor += size * 3;
				continue;
			}

			var pattern:Array<String> = letterPattern(letter);
			for (row in 0...pattern.length)
			{
				for (col in 0...pattern[row].length)
				{
					if(pattern[row].charAt(col) != '1') continue;
					var px:Int = cursor + col * size;
					var py:Int = y + row * size;
					rect(bitmap, px - 4, py - 4, size + 8, size + 8, outline);
					rect(bitmap, px, py, size, size, fill);
				}
			}
			cursor += size * 6;
		}
	}

	static function letterPattern(letter:String):Array<String>
	{
		return switch(letter)
		{
			case 'A': ['01110', '10001', '10001', '11111', '10001', '10001', '10001'];
			case 'B': ['11110', '10001', '10001', '11110', '10001', '10001', '11110'];
			case 'C': ['01111', '10000', '10000', '10000', '10000', '10000', '01111'];
			case 'D': ['11110', '10001', '10001', '10001', '10001', '10001', '11110'];
			case 'E': ['11111', '10000', '10000', '11110', '10000', '10000', '11111'];
			case 'F': ['11111', '10000', '10000', '11110', '10000', '10000', '10000'];
			case 'G': ['01111', '10000', '10000', '10111', '10001', '10001', '01111'];
			case 'H': ['10001', '10001', '10001', '11111', '10001', '10001', '10001'];
			case 'I': ['11111', '00100', '00100', '00100', '00100', '00100', '11111'];
			case 'L': ['10000', '10000', '10000', '10000', '10000', '10000', '11111'];
			case 'M': ['10001', '11011', '10101', '10101', '10001', '10001', '10001'];
			case 'N': ['10001', '11001', '10101', '10011', '10001', '10001', '10001'];
			case 'O': ['01110', '10001', '10001', '10001', '10001', '10001', '01110'];
			case 'P': ['11110', '10001', '10001', '11110', '10000', '10000', '10000'];
			case 'R': ['11110', '10001', '10001', '11110', '10100', '10010', '10001'];
			case 'S': ['01111', '10000', '10000', '01110', '00001', '00001', '11110'];
			case 'T': ['11111', '00100', '00100', '00100', '00100', '00100', '00100'];
			case 'U': ['10001', '10001', '10001', '10001', '10001', '10001', '01110'];
			case 'Y': ['10001', '10001', '01010', '00100', '00100', '00100', '00100'];
			default: ['11111', '10001', '00010', '00100', '00100', '00000', '00100'];
		}
	}

	static function rect(bitmap:BitmapData, x:Int, y:Int, w:Int, h:Int, color:Int):Void
		bitmap.fillRect(new Rectangle(x, y, w, h), color);

	static function getPalette(kind:String):Dynamic
	{
		return switch (kind)
		{
			case 'animal', 'cat', 'dog':
				{
					outline: 0xFF241B18,
					skin: 0xFFD8894A,
					shirt: 0xFF5BC2A8,
					pants: 0xFF2E5E50,
					mic: 0xFF2B2D42
				};
			case 'bot', 'robot', 'blockbot':
				{
					outline: 0xFF172033,
					skin: 0xFF8EE3FF,
					shirt: 0xFF3A7BD5,
					pants: 0xFF253858,
					mic: 0xFFE7F6FF
				};
			case 'april-bf-3d', 'bf-3d':
				{
					outline: 0xFF131628,
					skin: 0xFFFFD0A3,
					shirt: 0xFFFF3B52,
					pants: 0xFF2E6BE6,
					mic: 0xFF202336
				};
			case 'shadow', 'april-shadow':
				{
					outline: 0xFF0E0E14,
					skin: 0xFF323247,
					shirt: 0xFFB51F32,
					pants: 0xFF171923,
					mic: 0xFFDCD7E8
				};
			case 'zavion', 'april-zavion':
				{
					outline: 0xFF181216,
					skin: 0xFF894CFF,
					shirt: 0xFF35D0FF,
					pants: 0xFF222447,
					mic: 0xFFFFD35E
				};
			case 'raven', 'april-raven':
				{
					outline: 0xFF15111A,
					skin: 0xFF5B4B85,
					shirt: 0xFFE870A0,
					pants: 0xFF28213A,
					mic: 0xFFEAE7FF
				};
			case 'monster', 'creature':
				{
					outline: 0xFF1B1418,
					skin: 0xFFA8E85E,
					shirt: 0xFF8145A8,
					pants: 0xFF3A264B,
					mic: 0xFFFFDF5E
				};
			case 'object', 'thing', 'prop':
				{
					outline: 0xFF222222,
					skin: 0xFFFFD166,
					shirt: 0xFF06D6A0,
					pants: 0xFF118AB2,
					mic: 0xFF073B4C
				};
			case 'april-mic', 'shadow-mic':
				{
					outline: 0xFF101018,
					skin: 0xFFDCD7E8,
					shirt: 0xFF5C5F78,
					pants: 0xFF252635,
					mic: 0xFFFF4F70
				};
			case 'april-guitar', 'shadow-guitar':
				{
					outline: 0xFF130F12,
					skin: 0xFFB51F32,
					shirt: 0xFF2A2330,
					pants: 0xFFE3B65A,
					mic: 0xFFEDE7F4
				};
			default:
				{
					outline: 0xFF1F1D24,
					skin: 0xFFFFC28A,
					shirt: 0xFFE94F64,
					pants: 0xFF2D5DA8,
					mic: 0xFF30323D
				};
		}
	}
}
