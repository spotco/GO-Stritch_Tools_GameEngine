package game_obj {
	import flash.display.Sprite

	public class Base_Island extends Sprite {
		
		public var startX:Number;
		public var startY:Number;
		public var endX:Number;
		public var endY:Number;
		
		public function get_height(pos:Number):Number {
			return -1;
		}
		
		public function update_screen_pos(px:Number,py:Number) {
		}
		
		
		
	}

}