package  
{
	import flash.display.Sprite;
	
	public class LineIsland extends Sprite {
		
		public var x1:Number;
		public var y1:Number;
		public var x2:Number;
		public var y2:Number;
		
		public function LineIsland(x1:Number,y1:Number,x2:Number,y2:Number) {
			this.x1 = x1;
			this.x2 = x2;
			this.y1 = y1;
			this.y2 = y2;
			this.x = 0;
			this.y = 0;
			draw();
		}
		
		private function draw() {
			graphics.lineStyle(3, 0x0000FF);
			graphics.moveTo(x1, Common.normal_tofrom_stage_coord(y1));
			graphics.lineTo(x2, Common.normal_tofrom_stage_coord(y2));
			graphics.lineStyle(0);
		}
		
	}

}