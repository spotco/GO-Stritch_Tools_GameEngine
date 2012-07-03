package  {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class ClickPoint extends Sprite {
		
		public var normal_x:Number;
		public var normal_y:Number;
		
		public var emph:Boolean = false;
		private var color:uint;
		public var label:String;
		
		private var mouseover_draw:Sprite = new Sprite;
		
		public function ClickPoint(x:Number,y:Number,color:uint = 0x00FF00,label:String = null) {
			normal_x = x;
			normal_y = y;
			this.color = color;
			this.label = label;
			this.x = x;
			this.y = Common.normal_tofrom_stage_coord(y);
			
			draw();
			
			mouseover_draw.alpha = 0.5;
			addChild(mouseover_draw);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouse_over);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouse_out);
		}
		
		private function mouse_over(e:MouseEvent) {
			if (
				(Main.spr.cur_sel_pt != null && Main.spr.cur_sel_pt != this && this.label == null) ||
				(e.shiftKey)
				) {
				
				mouseover_draw.graphics.lineStyle(3, 0xFF0000);
				mouseover_draw.graphics.drawCircle(0, 0, 10);
				mouseover_draw.graphics.lineStyle(0);
				
					
			}
		}
		
		private function mouse_out(e:MouseEvent) {
			this.mouseover_draw.graphics.clear();
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
			mouseover_draw.graphics.clear();
		}
		
	}

}