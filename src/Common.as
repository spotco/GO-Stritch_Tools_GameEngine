package  {
	import flash.geom.Point;
	import editorobj.*;

	public class Common {
		
		public static function normal_tofrom_stage_coord(normal_coord_y:Number):Number {
			return Main.HEI*(1/Main.spr.scaleY) - normal_coord_y;
		}	
		
		public static function pt_fuzzy_eq(x1:Number, y1:Number, x2:Number, y2:Number, d:Number = 10):Boolean {
			return Math.sqrt(Math.pow(y2 - y1, 2) + Math.pow(x2 - x1, 2)) < d;
		}
		
		public static function remove_from(tar:Object, vec:Array):Array {
			return vec.filter(function(o) { return o != tar; });
		}
		
		
		public static function string_to_gameobjectclass(t:String):Class {
			if (t == "spike") {
				return GameObject.OBJ_SPIKE;
			} else if (t == "jumppad") {
				return GameObject.OBJ_JUMPPAD;
			} else if (t == "dogbone") {
				return GameObject.OBJ_BONE;
			} else if (t == "dogcape") {
				return GameObject.OBJ_CAPE;
			} else if (t == "dogrocket") {
				return GameObject.OBJ_ROCKET;
			} else if (t == "checkpoint") {
				return GameObject.OBJ_CHECKPOINT;
			} else if (t == "water") {
				return GameObject.OBJ_WATER;
			} else if (t == "game_end") {
				return GameObject.OBJ_GAMEEND;
			} else if (t == "speedup") {
				return GameObject.OBJ_SPEEDUP;
			} else if (t == "birdflock") {
				return GameObject.OBJ_BIRDS;
			} else if (t == "ground_detail") {
				return GameObject.OBJ_GROUND_DETAIL;
			} else if (t == "cavewall") {
				return GameObject.OBJ_CAVEWALL;
			} else if (t == "blocker") {
				return GameObject.OBJ_BLOCKER;
			} else if (t == "camera_area") {
				return GameObject.OBJ_CAMERA_AREA;
			} else if (t == "spikevine") {
				return GameObject.OBJ_SPIKEVINE;
			} else if (t == "breakable_wall") {
				return GameObject.OBJ_BREAKABLE_WALL;
			} else if (t == "island_fill") {
				return GameObject.OBJ_ISLAND_FILL;
			} else if (t == "swingvine") {
				return GameObject.OBJ_SWINGVINE;
			} else if (t == "robotminion") {
				return GameObject.OBJ_ROBOTMINION;
			} else if (t == "launcherrobot") {
				return GameObject.OBJ_LAUNCHERROBOT;
			} else if (t == "copter") {
				return GameObject.OBJ_COPTER;
			} else if (t == "labwall") {
				return GameObject.OBJ_LABWALL;
			} else {
				BrowserOut.msg_to_browser("console.log", "error in str_to_gameobj in common");
				return null;
			}
		}
		
		public static function roundDecimal(num:Number, precision:int):Number{
			var decimal:Number = Math.pow(10, precision);
			return Math.round(decimal* num) / decimal;
		}
		
	}

}