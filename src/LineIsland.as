package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class LineIsland extends Sprite {
		
		public static var NDIR_LEFT:String = "left";
		public static var NDIR_RIGHT:String = "right";
		
		public var x1:Number;
		public var y1:Number;
		public var x2:Number;
		public var y2:Number;
		public var ndir:String;
		public var can_fall:Boolean;
		public var label:String;
		public var hei:Number;
		
		public function LineIsland(x1:Number,y1:Number,x2:Number,y2:Number,dir:String = "left",label:String = "",hei:Number=50,can_fall:Boolean = true) {
			this.x1 = x1;
			this.x2 = x2;
			this.y1 = y1;
			this.y2 = y2;
			this.ndir = dir;
			this.hei = hei;
			this.can_fall = can_fall;
			this.x = 0;
			this.y = 0;
			this.label = label;
			draw();
			
			this.mouseEnabled = false;
		}
		
		public function get_jsonobject() {
			var o = { x1:x1, y1:y1, x2:x2, y2:y2, type:"line", hei:hei, ndir:ndir, can_fall:can_fall};
			if (label.length > 0) {
				o["label"] = label;
			}
			return o;
		}
		
		private function draw() {
			graphics.lineStyle(3, 0x0000FF);
			graphics.moveTo(x1, Common.normal_tofrom_stage_coord(y1));
			graphics.lineTo(x2, Common.normal_tofrom_stage_coord(y2));
			graphics.lineStyle();
			
			graphics.moveTo(0, 0);
			draw_arrowhead();
			draw_dirnormal();
			draw_label();
		}
		
		private function draw_label() {
			if (this.label == "") {
				return;
			}
			
			var pt_centre:Point = new Point((x2 + x1) / 2, Common.normal_tofrom_stage_coord((y2 + y1) / 2));
			var dir_vec:Vector3D = new Vector3D(x2 - x1, Common.normal_tofrom_stage_coord(y2) - Common.normal_tofrom_stage_coord(y1),0);
			var z_vec:Vector3D = new Vector3D(0, 0, 1);
			var normal_vec:Vector3D = dir_vec.crossProduct(z_vec);
			normal_vec.normalize();
			normal_vec.scaleBy(7);
			
			if (this.ndir == LineIsland.NDIR_RIGHT) {
				normal_vec.scaleBy( -1);
			}
			
			var msg:String = this.label;
			
			TextRenderer.render_text(graphics, msg, pt_centre.x - normal_vec.x - (14*msg.length)/2, pt_centre.y - normal_vec.y - 15/2);
		}
		
		private function draw_dirnormal() {
			var color:uint = 0x0000FF;
			var alpha:Number = 0.5;
			
			if (!can_fall) {
				color = 0xFF0000;
			}
			
			var dir_vec:Vector3D = new Vector3D(x2 - x1, Common.normal_tofrom_stage_coord(y2) - Common.normal_tofrom_stage_coord(y1),0);
			var z_vec:Vector3D = new Vector3D(0, 0, 1);
			var normal_vec:Vector3D = dir_vec.crossProduct(z_vec);
			
			normal_vec.normalize();
			normal_vec.scaleBy(Math.max(Math.min((dir_vec.length / 500) * 50, 50), 20));
			if (this.ndir == LineIsland.NDIR_LEFT) {
				normal_vec.scaleBy(1);
			} else if (this.ndir == LineIsland.NDIR_RIGHT) {
				normal_vec.scaleBy( -1);
			}
			
			var pt_centre:Point = new Point((x2 + x1) / 2, Common.normal_tofrom_stage_coord((y2 + y1) / 2));
			var top_pt:Point = new Point(pt_centre.x + normal_vec.x, pt_centre.y + normal_vec.y);
			
			graphics.lineStyle(2, color, alpha);
			graphics.moveTo(pt_centre.x, pt_centre.y);
			graphics.lineTo(top_pt.x, top_pt.y);
			graphics.lineStyle();
			
			var tri:Vector.<Number> = new Vector.<Number>();
			var tri_size:Number = normal_vec.length / 3;
			normal_vec.normalize();
			dir_vec.normalize();
			var tri_base:Point = new Point(top_pt.x - tri_size * normal_vec.x, top_pt.y - tri_size * normal_vec.y);
			
			tri.push(top_pt.x, top_pt.y);
			tri.push(tri_base.x + dir_vec.x * tri_size, tri_base.y + dir_vec.y * tri_size);
			tri.push(tri_base.x - dir_vec.x * tri_size, tri_base.y - dir_vec.y * tri_size);
			graphics.beginFill(color, alpha);
			graphics.drawTriangles(tri);
			graphics.endFill();
			
			draw_fillhei(normal_vec);
		}
		
		private function draw_fillhei(normal_vec:Vector3D) {
			normal_vec.normalize();
			normal_vec.scaleBy(-hei);
			
			var tri:Vector.<Number> = new Vector.<Number>();
			tri.push(x1, Common.normal_tofrom_stage_coord(y1));
			tri.push(x2, Common.normal_tofrom_stage_coord(y2));
			tri.push(x1 + normal_vec.x, Common.normal_tofrom_stage_coord(y1) + normal_vec.y);
			
			graphics.beginFill(0x0000FF, 0.4);
			graphics.drawTriangles(tri);
			
			tri = new Vector.<Number>();
			tri.push(x2, Common.normal_tofrom_stage_coord(y2));
			tri.push(x1 + normal_vec.x, Common.normal_tofrom_stage_coord(y1) + normal_vec.y);
			tri.push(x2 + normal_vec.x, Common.normal_tofrom_stage_coord(y2) + normal_vec.y);
			graphics.drawTriangles(tri);
			
			graphics.endFill();
			
		}
		
		private function draw_arrowhead() {
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