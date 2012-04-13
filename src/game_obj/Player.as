package game_obj {
	import flash.display.Sprite
	
	public class Player extends Sprite {
		
		private var pos_x:Number;
		private var pos_y:Number;
		
		public var vx:Number;
		public var vy:Number;
		
		public static var SCR_X:Number = 240;
		public static var SCR_Y:Number = 160;
		
		public function Player() {
			vx = 0;
			vy = 0;
			
			this.graphics.lineStyle(2, 0x0000FF);
			this.graphics.drawCircle(0, -10, 10);
			
			this.graphics.beginFill(0x00FF00);
			this.graphics.drawCircle(0, 0, 2);
			this.graphics.endFill();
		}
		
		public function set_pos(x:Number, y:Number) {
			this.pos_x = x;
			this.pos_y = y;
		}
		
		public function get_x():Number {
			return this.pos_x;
		}
		
		public function get_y():Number {
			return this.pos_y;
		}
		
		public function update_screen_pos() {
			this.x = SCR_X;
			this.y = SCR_Y;
		}
		
	}

}