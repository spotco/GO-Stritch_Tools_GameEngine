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
		[Embed(source = "../../bin/imgs/rocketwall.png")] public static var OBJ_ROCKETWALL:Class;
		[Embed(source = "../../bin/imgs/blocker.png")] public static var OBJ_BLOCKER:Class;
		[Embed(source = "../../bin/imgs/camera_area.png")] public static var OBJ_CAMERA_AREA:Class;
		[Embed(source = "../../bin/imgs/spikevine.png")] public static var OBJ_SPIKEVINE:Class;
		[Embed(source = "../../bin/imgs/breakable_wall.png")] public static var OBJ_BREAKABLE_WALL:Class;
		[Embed(source = "../../bin/imgs/island_fill.png")] public static var OBJ_ISLAND_FILL:Class;
		[Embed(source = "../../bin/imgs/swingvine.png")] public static var OBJ_SWINGVINE:Class;
		[Embed(source = "../../bin/imgs/robotminion.png")] public static var OBJ_ROBOTMINION:Class;
		[Embed(source = "../../bin/imgs/launcherrobot.png")] public static var OBJ_LAUNCHERROBOT:Class;
		[Embed(source = "../../bin/imgs/copter.png")] public static var OBJ_COPTER:Class;
		[Embed(source = "../../bin/imgs/labwall.png")] public static var OBJ_LABWALL:Class;
		[Embed(source = "../../bin/imgs/electricwall.png")] public static var OBJ_ELECTRICWALL:Class;
		[Embed(source = "../../bin/imgs/labentrance.png")] public static var OBJ_LABENTRANCE:Class;
		[Embed(source = "../../bin/imgs/labexit.png")] public static var OBJ_LABEXIT:Class;
		[Embed(source = "../../bin/imgs/enemyalert.png")] public static var OBJ_ENEMYALERT:Class;
		[Embed(source = "../../bin/imgs/tutorial.png")] public static var OBJ_TUTORIAL:Class;
		[Embed(source = "../../bin/imgs/tutorialend.png")] public static var OBJ_TUTORIALEND:Class;
		[Embed(source = "../../bin/imgs/coin.png")] public static var OBJ_COIN:Class;
		
		
		private static var GAMEOBJS = {
			"spike":OBJ_SPIKE,
			"game_end":OBJ_GAMEEND,
			"checkpoint":OBJ_CHECKPOINT,
			"dogcape":OBJ_CAPE,
			"dogrocket":OBJ_ROCKET,
			"dogbone":OBJ_BONE,
			"jumppad":OBJ_JUMPPAD,
			"water":OBJ_WATER,
			"speedup":OBJ_SPEEDUP,
			"birdflock":OBJ_BIRDS,
			"robotminion":OBJ_ROBOTMINION,
			"breakable_wall":OBJ_BREAKABLE_WALL,
			"spikevine":OBJ_SPIKEVINE,
			"ground_detail":OBJ_GROUND_DETAIL,
			"blocker":OBJ_BLOCKER,
			"rocketwall":OBJ_ROCKETWALL,
			"camera_area":OBJ_CAMERA_AREA,
			"island_fill":OBJ_ISLAND_FILL,
			"swingvine":OBJ_SWINGVINE,
			"launcherrobot":OBJ_LAUNCHERROBOT,
			"copter":OBJ_COPTER,
			"labwall":OBJ_LABWALL,
			"electricwall":OBJ_ELECTRICWALL,
			"labentrance":OBJ_LABENTRANCE,
			"labexit":OBJ_LABEXIT,
			"enemyalert":OBJ_ENEMYALERT,
			"tutorial":OBJ_TUTORIAL,
			"tutorialend":OBJ_TUTORIALEND,
			"coin":OBJ_COIN
		};
		
		private static var AREAGAMEOBJS:Array = [
			GameObject.OBJ_BLOCKER,
			GameObject.OBJ_ROCKETWALL, 
			GameObject.OBJ_WATER, 
			GameObject.OBJ_CAMERA_AREA, 
			GameObject.OBJ_ISLAND_FILL, 
			GameObject.OBJ_LABWALL,
			GameObject.OBJ_ENEMYALERT
		];
		
		private static var DIRECTEDGAMEOBJS:Array = [
			GameObject.OBJ_JUMPPAD, 
			GameObject.OBJ_SPEEDUP,
			GameObject.OBJ_LAUNCHERROBOT
		];
		
		private static var LINEGAMEOBJS:Array = [
			GameObject.OBJ_BREAKABLE_WALL, 
			GameObject.OBJ_SPIKEVINE,
			GameObject.OBJ_SWINGVINE,
			GameObject.OBJ_ELECTRICWALL
		];
		
		/*
		 * other special types:
			 * Bone
			 * CameraArea
			 * GroundDetail
		*/
		
		public static function init() {
			var tmp = { };
			for (var key:String in GAMEOBJS) {
				tmp[GAMEOBJS[key].toString()] = key;
			}
			for (var okey:String in tmp) {
				GAMEOBJS[okey] = tmp[okey];
			}
		}
		
		public static function get_game_objs():Array {
			var t:Array = [];
			for (var key:String in GAMEOBJS) {
				if (key.indexOf("[") == -1) {
					t.push(key);
				}
			}
			return t;
		}
		
		public static function string_to_gameobj(t:String):Class {
			return GAMEOBJS[t];
		}
		
		public static function gameobj_to_string(c:Class):String {
			var cl = c;
			return GAMEOBJS[cl.toString()];
		}
		
		public static function is_areagameobject(c:Class):Boolean {
			return AREAGAMEOBJS.indexOf(c) != -1;
		}
		
		public static function is_directedgameobject(c:Class):Boolean {
			return DIRECTEDGAMEOBJS.indexOf(c) != -1;
		}
		
		public static function is_linegameobject(c:Class):Boolean {
			return LINEGAMEOBJS.indexOf(c) != -1;
		}
		
		public var img:DisplayObject;
		public var objtype:String;
		
		public function GameObject(x:Number,y:Number,type:Class,label:String = null) {
			super(x, y, 0x00FFFF, label);
			
			if (GameObject.gameobj_to_string(type)) {
				if (type != GameObject.OBJ_GROUND_DETAIL && !GameObject.is_areagameobject(type)) {
					img = new type as Bitmap;
				}
				objtype = GameObject.gameobj_to_string(type);
			} else {
				objtype = "";
				TextRenderer.render_text(Main.spr.graphics, "gobj_err in gameobject.as:" + type, 50, 50, 10);
				BrowserOut.msg_to_browser("console.log", "gobj_err in gameobject.as:" + type);
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