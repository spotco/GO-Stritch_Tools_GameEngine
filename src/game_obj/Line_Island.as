package game_obj {

	public class Line_Island extends Base_Island {
		
		public var min_range:Number;
		public var max_range:Number;
		public var slope:Number;
		
		public function Line_Island(x1:Number, y1:Number, x2:Number, y2:Number) {
			this.min_range = x1;
			this.max_range = x2;
			
			this.startX = x1;
			this.startY = y1;
			
			this.endY = y2;
			this.endX = x2;
			
			this.slope = (endY - startY) / (endX - startX);
			
			this.graphics.lineStyle(2, 0x0000FF);
			this.graphics.moveTo(startX,Main.HEI-startY);
			this.graphics.lineTo(endX, Main.HEI-endY);
		}
		
		public override function get_height(pos:Number):Number {
			if (pos < min_range || pos > max_range) {
				return -1;
			} else {
				var val:Number = startY + (pos - startX) * slope;
				val = Common.cfpe(val);
				return val;
			}
		}
		
		public override function update_screen_pos(px:Number,py:Number) {
			//this.x = -(px - Main.init_pos_x);
			//this.y = -(Main.init_pos_y - py);
			
			this.x = -(px )+Player.SCR_X;
			this.y =   (py+Player.SCR_Y)-Main.HEI;
		}
		
		
	}
}