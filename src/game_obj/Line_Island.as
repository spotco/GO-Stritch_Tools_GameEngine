package game_obj {
	import flash.display.Bitmap;

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
			
			/*this.graphics.lineStyle(2, 0x0000FF);
			this.graphics.moveTo(startX,Main.HEI-startY);
			this.graphics.lineTo(endX, Main.HEI - endY);*/
			
			
			this.graphics.beginBitmapFill((new island_tex as Bitmap).bitmapData);
			var vert:Vector.<Number> = new Vector.<Number>();
			vert.push(startX); vert.push( Main.HEI-startY);
			vert.push(endX); vert.push(Main.HEI-endY);
			vert.push(endX); vert.push(Main.HEI - endY + 30);
			this.graphics.drawTriangles(vert);
			
			vert = new Vector.<Number>();
			
			vert.push(endX); vert.push(Main.HEI - endY + 30);
			vert.push(startX); vert.push(Main.HEI - startY + 30);
			vert.push(startX); vert.push( Main.HEI-startY);
			
			this.graphics.drawTriangles(vert);
			
			
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
		
		[Embed(source = "../../img/fg_tex.png")] public static var island_tex:Class;
	}
}