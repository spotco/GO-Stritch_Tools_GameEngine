package game_obj {
	import flash.display.Bitmap;
	import flash.display.Sprite
	import flash.geom.Rectangle;
	
	public class Player extends Sprite {
		
		private var pos_x:Number;
		private var pos_y:Number;
		
		public var vx:Number;
		public var vy:Number;
		public var display_img:Bitmap;
		
		public static var SCR_X:Number = 240;
		public static var SCR_Y:Number = 160;
		
		public function Player() {
			vx = 0;
			vy = 0;
			
			/*this.graphics.lineStyle(2, 0x0000FF);
			this.graphics.drawCircle(0, -10, 10);
			
			this.graphics.beginFill(0x00FF00);
			this.graphics.drawCircle(0, 0, 2);
			this.graphics.endFill();*/
			
			this.display_img = new bird1_run1_ss as Bitmap;
			this.display_img.x = -32;
			this.display_img.y = -82;
			this.addChild(this.display_img);
			//this.display_img.mask = 
			this.display_img.scrollRect = new Rectangle(0, 0, 72, 87);
		}
		
		/*
		 * for (int i = 1; i<=6; i++) {
CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(72*(i-1), 0, 72, 87)];
[animFrames addObject:frame];
}
*/

		
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
		
		var frame:int = 0;
		var delay:int = 0;
		public function anim_update() {
			delay++
			if (delay > 5) {
				delay = 0;
				frame++;
				if (frame >= 6) {
					frame = 0;
				}
				this.display_img.scrollRect = new Rectangle(72*(frame), 0, 72, 87);
			}
		}
		
		public function update_screen_pos() {
			this.x = SCR_X;
			this.y = SCR_Y;
		}
		
		
		
		[Embed(source = "../../img/bird1_run1_ss.png")] public static var bird1_run1_ss:Class;
		
	}

}