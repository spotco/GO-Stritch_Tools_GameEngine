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
		
		
		public static function string_to_gameobjectclass(t:String) {
			if (GameObject.string_to_gameobj(t)) {
				return GameObject.string_to_gameobj(t);
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
