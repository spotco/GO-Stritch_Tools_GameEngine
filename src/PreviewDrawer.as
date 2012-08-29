package  {
	import editorobj.LineIsland;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	public class PreviewDrawer extends Sprite{
		
		var editor:LevelEditor;
		var timer:Timer;
		
		public function PreviewDrawer(editor:LevelEditor) {
			this.editor = editor;
			this.timer = new Timer(100);
			this.timer.addEventListener(TimerEvent.TIMER, timer_update);
			this.timer.start();
			
			this.alpha = 0.6;
		}
		
		private function timer_update(e:TimerEvent) {
			this.graphics.clear();
			
			if (editor.lastkey == Keyboard.SHIFT) {
				return;
			}
			
			if (Main.spr.move_tars.length > 0) {
				Main.spr.move_tars.forEach(function(i) {
					if (i.pt == null) {
						graphics.beginFill(0xFFFF00,0.7);
						graphics.drawCircle(i.obj.x, i.obj.y, 10);
						graphics.drawCircle(Main.spr.mouseX,Main.spr.mouseY, 10);
					} else {
						graphics.lineStyle(3, 0xFFFF00,0.7);
						if (i.pt == LineIsland.PT1) {
							graphics.moveTo(i.obj.x2, Common.normal_tofrom_stage_coord(i.obj.y2));
							graphics.lineTo(Main.spr.mouseX, Main.spr.mouseY);
						} else if (i.pt == LineIsland.PT2) {
							graphics.moveTo(i.obj.x1, Common.normal_tofrom_stage_coord(i.obj.y1));
							graphics.lineTo(Main.spr.mouseX, Main.spr.mouseY);
						}
					}
				});
			} else if (editor.lastkey == Keyboard.W) {
				this.graphics.beginFill(0xFFFF00);
				this.graphics.drawCircle(Main.spr.mouseX, Main.spr.mouseY, 5);
				TextRenderer.render_text(this.graphics, "Player Start", Main.spr.mouseX, Main.spr.mouseY);
				this.graphics.endFill();
			} else if (editor.lastkey == Keyboard.Q) {
				this.graphics.beginFill(0x00FFFF);
				this.graphics.drawCircle(Main.spr.mouseX, Main.spr.mouseY, 5);
				TextRenderer.render_text(this.graphics, String(editor.obj_label_count), Main.spr.mouseX, Main.spr.mouseY);
				this.graphics.endFill();
			} else if (editor.cur_sel_pt != null) {
				this.graphics.lineStyle(3, 0x0000FF);
				this.graphics.moveTo(editor.cur_sel_pt.x, editor.cur_sel_pt.y);
				this.graphics.lineTo(Main.spr.mouseX, Main.spr.mouseY);
				this.graphics.lineStyle(0);
				
			}
		}
		
	}

}