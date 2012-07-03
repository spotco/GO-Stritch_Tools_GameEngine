package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
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
			
			this.mouseEnabled = false;
		}
		
		private function draw() {
			graphics.lineStyle(3, 0x0000FF);
			graphics.moveTo(x1, Common.normal_tofrom_stage_coord(y1));
			graphics.lineTo(x2, Common.normal_tofrom_stage_coord(y2));
			graphics.lineStyle(0);
			
			graphics.moveTo(0, 0);
			
			
			graphics.beginFill(0x0000FF);
			var tri:Vector.<Number> = new Vector.<Number>();
			var local_x2:Number = x2;
			var local_y2:Number = Common.normal_tofrom_stage_coord(this.y2);
			var size:Number = 10;
			
			var line_vec:Vector3D = new Vector3D(x2 - x1, Common.normal_tofrom_stage_coord(y2) - Common.normal_tofrom_stage_coord(y1));
			line_vec.normalize();
			var normal_to_line:Vector3D = line_vec.crossProduct(new Vector3D(0, 0, 1, 0));
			normal_to_line.normalize();
			var tri_base:Point = new Point(local_x2, local_y2);
			tri_base.x -= line_vec.x * size*1.5;
			tri_base.y -= line_vec.y * size*1.5;
			
			tri.push(local_x2, local_y2);
			tri.push(tri_base.x + normal_to_line.x * size, tri_base.y + normal_to_line.y * size);
			tri.push(tri_base.x - normal_to_line.x * size, tri_base.y - normal_to_line.y * size);
			graphics.drawTriangles(tri);
			graphics.endFill();
		}
		
	}

}