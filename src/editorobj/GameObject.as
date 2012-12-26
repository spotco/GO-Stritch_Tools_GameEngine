package editorobj {
	import com.adobe.images.BitString;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	public class GameObject extends ClickPoint {
		
		[Embed(source = "../../bin/imgs/spike.png")] public static var OBJ_SPIKE:Class;
		[Embed(source = "../../bin/imgs/speedup.png")] public static var OBJ_SPEEDUP:Class;
		[Embed(source = "../../bin/imgs/game_end.png")] public static var OBJ_GAMEEND:Class;
		[Embed(source = "../../bin/imgs/checkpoint.png")] public static var OBJ_CHECKPOINT:Class;
		[Embed(source = "../../bin/imgs/dogcape.png")] public static var OBJ_CAPE:Class;
		[Embed(source = "../../bin/imgs/dogrocket.png")] public static var OBJ_ROCKET:Class;
		[Embed(source = "../../bin/imgs/dogbone.png")] public static var OBJ_BONE:Class;
		[Embed(source = "../../bin/imgs/jumppad.png")] public static var OBJ_JUMPPAD:Class;
		[Embed(source = "../../bin/imgs/water.png")] public static var OBJ_WATER:Class;
		[Embed(source = "../../bin/imgs/birdflock.png")] public static var OBJ_BIRDS:Class;
		[Embed(source = "../../bin/imgs/ground_detail.png")] public static var OBJ_GROUND_DETAIL:Class;
		[Embed(source = "../../bin/imgs/cavewall.png")] public static var OBJ_CAVEWALL:Class;
		[Embed(source = "../../bin/imgs/blocker.png")] public static var OBJ_BLOCKER:Class;
		[Embed(source = "../../bin/imgs/camera_area.png")] public static var OBJ_CAMERA_AREA:Class;
		[Embed(source = "../../bin/imgs/spikevine.png")] public static var OBJ_SPIKEVINE:Class;
		[Embed(source = "../../bin/imgs/breakable_wall.png")] public static var OBJ_BREAKABLE_WALL:Class;
		[Embed(source = "../../bin/imgs/island_fill.png")] public static var OBJ_ISLAND_FILL:Class;
		[Embed(source = "../../bin/imgs/swingvine.png")] public static var OBJ_SWINGVINE:Class;
		[Embed(source = "../../bin/imgs/robotminion.png")] public static var OBJ_ROBOTMINION:Class;
		
		public var img:DisplayObject;
		public var objtype:String;
		
		public function GameObject(x:Number,y:Number,type:Class,label:String = null) {
			super(x, y, 0x00FFFF, label);
			
			if (type == OBJ_SPIKE) {
				img = new OBJ_SPIKE as Bitmap;
				objtype = "spike";
			} else if (type == OBJ_GAMEEND) {
				img = new OBJ_GAMEEND as Bitmap;
				objtype = "game_end";
			} else if (type == OBJ_CHECKPOINT) {
				img = new OBJ_CHECKPOINT as Bitmap;
				objtype = "checkpoint";
			} else if (type == OBJ_CAPE) {
				img = new OBJ_CAPE as Bitmap;
				objtype = "dogcape";
			} else if (type == OBJ_ROCKET) {
				img = new OBJ_ROCKET as Bitmap;
				objtype = "dogrocket";
			} else if (type == OBJ_BONE) {
				img = new OBJ_BONE as Bitmap;
				objtype = "dogbone";
			} else if (type == OBJ_JUMPPAD) {
				img = new OBJ_JUMPPAD as Bitmap;
				objtype = "jumppad";
			} else if (type == OBJ_WATER) {
				img = new OBJ_WATER as Bitmap;
				objtype = "water";
			} else if (type == OBJ_SPEEDUP) {
				img = new OBJ_SPEEDUP as Bitmap;
				objtype = "speedup";
			} else if (type == OBJ_BIRDS) {
				img = new OBJ_BIRDS as Bitmap;
				objtype = "birdflock";
			} else if (type == OBJ_ROBOTMINION) {
				img = new OBJ_ROBOTMINION as Bitmap;
				objtype = "robotminion";
			} else if (type == OBJ_BREAKABLE_WALL) {
				img = new OBJ_BREAKABLE_WALL as Bitmap;
				objtype = "breakable_wall"
			} else if (type == OBJ_SPIKEVINE) {
				img = new OBJ_SPIKEVINE as Bitmap;
				objtype = "spikevine";
			} else if (type == OBJ_GROUND_DETAIL) {
				objtype = "ground_detail";
			} else if (type == OBJ_BLOCKER) {
				objtype = "blocker";
			} else if (type == OBJ_CAVEWALL) {
				objtype = "cavewall";
			} else if (type == OBJ_CAMERA_AREA) {
				objtype = "camera_area";
			} else if (type == OBJ_ISLAND_FILL) {
				objtype = "island_fill";
			} else if (type == OBJ_SWINGVINE) {
				img = new OBJ_SWINGVINE as Bitmap;
				objtype = "swingvine";
			} else {
				objtype = "";
				TextRenderer.render_text(Main.spr.graphics, "gobj_err in gameobject.as:"+type, 50, 50, 10);
			}
			
			if (img) {
				addChild(img);
				img.scaleX = 0.5;
				img.scaleY = 0.5;
				img.x = -img.width / 2;
				img.y = -img.height / 2;
				img.alpha = 0.7;
			}
		}
		
		public function get_jsonobject() {
			var o = { type:objtype, x:normal_x, y:normal_y };
			if (label) {
				o["label"] = label;
			}
			return o;
		}
		
	}

}