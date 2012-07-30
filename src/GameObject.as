package  {
	import com.adobe.images.BitString;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	public class GameObject extends ClickPoint {
		
		[Embed(source = "../resc/spikes.png")] public static var OBJ_SPIKE:Class;
		[Embed(source = "../resc/boost3.png")] public static var OBJ_BOOST:Class;
		[Embed(source = "../resc/checkerfloor.png")] public static var OBJ_GAMEEND:Class;
		[Embed(source = "../resc/checkpoint1.png")] public static var OBJ_CHECKPOINT:Class;
		[Embed(source = "../resc/dogcape.png")] public static var OBJ_CAPE:Class;
		[Embed(source = "../resc/dogrocket.png")] public static var OBJ_ROCKET:Class;
		[Embed(source = "../resc/goldenbone.png")] public static var OBJ_BONE:Class;
		[Embed(source = "../resc/jumppads.png")] public static var OBJ_JUMPPAD:Class;
		[Embed(source = "../resc/water.png")] public static var OBJ_WATER:Class;
		
		var img:DisplayObject;
		var objtype:String;
		
		public function GameObject(x:Number,y:Number,type:Class,label:String = "") {
			super(x, y, 0x00FFFF, label);
			
			if (type == OBJ_SPIKE) {
				img = new OBJ_SPIKE as Bitmap;
				objtype = "spike";
			} else if (type == OBJ_BOOST) {
				img = new OBJ_BOOST as Bitmap;
				objtype = "boost";
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