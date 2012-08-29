package editorobj {
	public class LineObject extends GameObject {
		
		public var x2:Number;
		public var y2:Number;
		
		public function LineObject(x1:Number, y1:Number, x2:Number, y2:Number, type:Class, label:String = "") {
			super(x1, y1, type, label);
			this.normal_x = x1;
			this.normal_y = y1;
			this.x2 = x2;
			this.y2 = y2;
			draw();
		}
		
		public override function position(normal_x:Number, normal_y:Number) {
			x2 += normal_x - this.normal_x;
			y2 += normal_y - this.normal_y;
			super.position(normal_x, normal_y);
		}
		
		private function draw() {
			graphics.lineStyle(3, 0x0088FF);
			graphics.moveTo(0, 0);
			graphics.lineTo(x2 - normal_x, Common.normal_tofrom_stage_coord(y2) - Common.normal_tofrom_stage_coord(normal_y));
		}
		
		public override function get_jsonobject() {
			var o = super.get_jsonobject();
			o["x2"] = this.x2;
			o["y2"] = this.y2;
			return o;
		}
		
	}

}