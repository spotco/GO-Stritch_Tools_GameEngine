package  {
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
			
			if (editor.lastkey == Keyboard.W) {
				this.graphics.beginFill(0xFFFF00);
				this.graphics.drawCircle(stage.mouseX + editor.current_x, stage.mouseY + editor.current_y, 5);
				TextRenderer.render_text(this.graphics, "Player Start", stage.mouseX + editor.current_x, stage.mouseY + editor.current_y);
				this.graphics.endFill();
			} else if (editor.lastkey == Keyboard.Q) {
				this.graphics.beginFill(0x00FFFF);
				this.graphics.drawCircle(stage.mouseX + editor.current_x, stage.mouseY + editor.current_y, 5);
				TextRenderer.render_text(this.graphics, String(editor.obj_label_count), stage.mouseX + editor.current_x, stage.mouseY + editor.current_y);
				this.graphics.endFill();
			} else if (editor.cur_sel_pt != null) {
				this.graphics.lineStyle(3, 0x0000FF);
				this.graphics.moveTo(editor.cur_sel_pt.x, editor.cur_sel_pt.y);
				this.graphics.lineTo(stage.mouseX+editor.current_x, stage.mouseY+editor.current_y);
				this.graphics.lineStyle(0);
				
				/*var click_x:Number = stage.mouseX + editor.current_x;
				var click_y:Number = stage.mouseY + editor.current_y;
				for each(var i:ClickPoint in editor.pts) {
					if (i != editor.cur_sel_pt && Common.pt_fuzzy_eq(click_x, click_y, i.x, i.y)) {
						click_x = i.normal_x;
						click_y = i.normal_y;
						this.graphics.lineStyle(3, 0xFF0000);
						this.graphics.drawCircle(i.x, i.y, 10);
						this.graphics.lineStyle(0);
						break;
					}
				}*/
				
			}
		}
		
	}

}