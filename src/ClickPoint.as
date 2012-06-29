package  {
	import flash.display.Sprite;
	public class ClickPoint extends Sprite {
		
		public var normal_x:Number;
		public var normal_y:Number;
		
		public var emph:Boolean = false;
		private var color:uint;
		public var label:String;
		
		public function ClickPoint(x:Number,y:Number,color:uint = 0x00FF00,label:String = null) {
			normal_x = x;
			normal_y = y;
			this.color = color;
			this.label = label;
			this.x = x;
			this.y = Common.normal_tofrom_stage_coord(y);
			
			draw();
		}
		
		private function draw() {
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
			
			if (this.label) {
				TextRenderer.render_text(graphics, label, 0, 0);
			}
			
			if (emph) {
				graphics.lineStyle(4, 0xFF0000);
				graphics.drawCircle(0, 0, 10);
				graphics.lineStyle(0);
			} 
		}
		
		public function emphasize(b:Boolean) {
			emph = b;
			draw();
		}
		
	}

}