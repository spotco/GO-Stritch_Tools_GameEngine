package editorobj {
	import flash.geom.Vector3D;
	import flash.geom.Point;
	public class DirectionalGameObject extends GameObject {
		
		var dir;
		
		public function DirectionalGameObject(x:Number,y:Number,type:Class,dir:Object,label:String = null) {
			super(x, y, type, label);
			this.dir = dir;
			draw();
		}
		
		private function draw() {
			graphics.lineStyle(3, 0x7777FF);
			graphics.moveTo(0, 0);
			graphics.lineTo(dir.x*25, -dir.y*25);
			graphics.lineStyle();
			draw_arrowhead();
		}
		
		private function draw_arrowhead() {
			graphics.beginFill(0x7777FF);
			var tri:Vector.<Number> = new Vector.<Number>();
			var local_x2:Number = dir.x*25;
			var local_y2:Number = -dir.y*25;
			var size:Number = 4;
			
			var line_vec:Vector3D = new Vector3D(dir.x*25, -dir.y*25);
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
		
		public override function get_jsonobject() {
			var o = super.get_jsonobject();
			o["dir"] = this.dir;
			return o;
		}
		
	}

}