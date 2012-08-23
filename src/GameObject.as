package  {
	import com.adobe.images.BitString;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	public class GameObject extends ClickPoint {
		
		[Embed(source = "../resc/spikes.png")] public static var OBJ_SPIKE:Class;
		[Embed(source = "../resc/boost3.png")] public static var OBJ_SPEEDUP:Class;
		[Embed(source = "../resc/checkerfloor.png")] public static var OBJ_GAMEEND:Class;
		[Embed(source = "../resc/checkpoint1.png")] public static var OBJ_CHECKPOINT:Class;
		[Embed(source = "../resc/dogcape.png")] public static var OBJ_CAPE:Class;
		[Embed(source = "../resc/dogrocket.png")] public static var OBJ_ROCKET:Class;
		[Embed(source = "../resc/goldenbone.png")] public static var OBJ_BONE:Class;
		[Embed(source = "../resc/jumppads.png")] public static var OBJ_JUMPPAD:Class;
		[Embed(source = "../resc/water.png")] public static var OBJ_WATER:Class;
		[Embed(source = "../resc/birds.png")] public static var OBJ_BIRDS:Class;
		[Embed(source = "../resc/ground_detail.png")] public static var OBJ_GROUND_DETAIL:Class;
		[Embed(source = "../resc/cavewall.png")] public static var OBJ_CAVEWALL:Class;
		[Embed(source = "../resc/blocker.png")] public static var OBJ_BLOCKER:Class;
		
		var img:DisplayObject;
		public var objtype:String;
		
		public function GameObject(x:Number,y:Number,type:Class,label:String = "") {
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
			} else if (type == OBJ_GROUND_DETAIL) {
				img = new OBJ_GROUND_DETAIL as Bitmap;
				objtype = "ground_detail";
			} else if (type == OBJ_BLOCKER) {
				objtype = "blocker";
			} else if (type == OBJ_CAVEWALL) {
				objtype = "cavewall";
			} else {
				objtype = "";
				TextRenderer.render_text(Main.spr.graphics, "gobj_err:"+type, 50, 50, 10);
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
			return { type:objtype, x:normal_x, y:normal_y, label:label };
		}
		
	}

}