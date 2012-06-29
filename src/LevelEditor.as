package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;

	public class LevelEditor extends Sprite {
		
		var current_x:Number = 0;
		var current_y:Number = 0;
		
		var pts:Array = new Array;
		var lines:Array = new Array;
		var objects:Array = new Array;
		var undo_stack:Array = new Array;
		
		var player_start_pt:ClickPoint = null;
		
		var obj_label_count:Number = 0;
		
		var cur_sel_pt:ClickPoint = null;
		
		public function LevelEditor() { this.addEventListener(Event.ADDED_TO_STAGE, function() { init();} ); }
		
		private function init() {
			draw_grid();
			add_controls();
			set_scroll_rect();
		}
		
		private function set_scroll_rect() {
			this.scrollRect = new Rectangle(current_x, current_y, Main.WID, Main.HEI);
		}
		
		private function draw_grid() {
			graphics.clear();
			
			var ct = 0;
			for (var i:int = Math.floor(current_y / 50) * 50 + Main.HEI; i >= current_y; i -= 50) {
				TextRenderer.render_text(graphics, -(i - Main.HEI) + "px", current_x, i);
				graphics.lineStyle(1, 0xFFFFFF, 0.3);
				graphics.moveTo(0, i);
				graphics.lineTo(current_x + Main.WID, i);
				graphics.lineStyle(0);
				
			}
			
			for (i = Math.floor(current_x / 50) * 50; i <= current_x + Main.WID; i += 50) {
				TextRenderer.render_text(graphics, i+"px", i, current_y+Main.HEI-20);
				graphics.lineStyle(1, 0xFFFFFF, 0.3);
				graphics.moveTo(i, Main.HEI);
				graphics.lineTo(i, current_y);
				graphics.lineStyle(0);
				
			}
		}
		
		private function add_controls() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent) {
			var click_x:Number = stage.mouseX+current_x;
			var click_y:Number = Main.HEI - stage.mouseY - current_y;
			
			if (e.shiftKey) {
				for each(var i:ClickPoint in pts) {
					if (Common.pt_fuzzy_eq(click_x, click_y, i.normal_x, i.normal_y) && e.shiftKey) {
						sel_pt(i);
						return;
					}
				}
				return;
			} else if (lastkey == Keyboard.W) {
				desel_all();
				if (player_start_pt != null) {
					removeChild(player_start_pt);
				}
				player_start_pt = new ClickPoint(click_x, click_y, 0xFFFF00, "Player Start");
				addChild(player_start_pt);
				BrowserOut.msg_to_browser("console.log", printf("Moved player startpt to (%f,%f)", player_start_pt.normal_x, player_start_pt.normal_y));
				lastkey = 0x000000;
			} else if (lastkey == Keyboard.Q) {
				desel_all();
				var newobj:ClickPoint = new ClickPoint(click_x, click_y, 0x00FFFF, String(obj_label_count));
				
				objects.push(newobj);
				addChild(newobj);
				lastkey = 0x000000;
				BrowserOut.msg_to_browser("console.log", printf("Added object (%i) at (%f,%f)",obj_label_count,click_x, click_y));
				obj_label_count++;
				undo_stack.push(newobj);
			} else {
				var pt_close:ClickPoint = null;
				for each(var i:ClickPoint in pts) {
					if (Common.pt_fuzzy_eq(click_x, click_y, i.normal_x, i.normal_y)) {
						pt_close = i;
						click_x = pt_close.normal_x;
						click_y = pt_close.normal_y;
						if (pt_close == cur_sel_pt) {
							return;
						}
						break;
					}
				}
				
				var added_line = false;
				var added_point = false;
				
				if (cur_sel_pt != null) {
					var nline:LineIsland = new LineIsland(cur_sel_pt.normal_x, cur_sel_pt.normal_y, click_x, click_y);
					lines.push(nline);
					addChild(nline);
					BrowserOut.msg_to_browser("console.log", printf("Added line from (%f,%f) to (%f,%f)", cur_sel_pt.normal_x, cur_sel_pt.normal_y, click_x, click_y));
					if (pt_close != null) {
						desel_all();
					}
					added_line = true;
					undo_stack.push(nline);
				}
				
				if (pt_close == null) {
					var npt:ClickPoint = new ClickPoint(click_x, click_y);
					pts.push(npt);
					addChild(npt);
					sel_pt(npt);
					BrowserOut.msg_to_browser("console.log", printf("Added point at (%f,%f)", click_x, click_y));
					added_point = true;
					undo_stack.push(npt);
				}
			}
		}
		
		private function sel_pt(pt:ClickPoint) {
			desel_all();
			cur_sel_pt = pt;
			pt.emphasize(true);
		}
		
		private function desel_all() {
			cur_sel_pt = null;
			for each(var i:ClickPoint in pts) {
				i.emphasize(false);
			}
		}
		
		private var lastkey:uint = 0x000000;
		private function onKeyDown(e:KeyboardEvent) {
			lastkey = e.keyCode;
			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT) {
				move(e);
			} else if (e.keyCode == Keyboard.ESCAPE) {
				desel_all();
			} else if (e.keyCode == Keyboard.Z) {
				undo();
			} else if (e.keyCode == Keyboard.P) {
				json_out();
			}
		}
		
		private function json_out() {
			BrowserOut.msg_to_browser("msg_out", get_current_json());
		}
		
		public function json_in(json:String) {
			lines = removeAll(lines);
			pts = removeAll(pts);
			objects = removeAll(objects);
		}
		
		private function removeAll(a:Array):Array {
			return a.filter(function(o) { removeChild(o); return false; } );
		}
		
		public function get_current_json():String {
			var p_start_x = 0;
			var p_start_y = 0;
			if (player_start_pt != null) {
				p_start_x = player_start_pt.normal_x;
				p_start_y = player_start_pt.normal_y;
			}
			
			var str:String = "{";
			str += printf('\n\t"startX":"%f",\n\t"startY":"%f",\n', p_start_x, p_start_y);
			
			str += '\t"islands":[\n';
			for (var i = 0; i < lines.length; i++) {
				var j:LineIsland = lines[i];
				str += printf('\t\t{"x1":"%f","y1":"%f","x2":"%f","y2":"%f"}', j.x1, j.y1, j.x2, j.y2);
				if (i != lines.length - 1) {
					str += ",";
				}
				str += "\n";
			}
			str += "\t],\n\n";
			
			str += '\t"objects":[\n';
			for (i = 0; i < objects.length; i++) {
				var o:ClickPoint = objects[i];
				str += printf('\t\t{"x":"%f","y":"%f","label":"%s"}', o.normal_x, o.normal_y, o.label);
				if (i != objects.length - 1) {
					str += ",";
				}
				str += "\n";
			}
			str += '\t]\n';
			
			
			str += "}";
			return str;
		}
		
		private function undo() {
			if (undo_stack.length == 0) {
				return;
			}
			var s:Sprite = undo_stack.pop();
			lines = Common.remove_from(s, lines);
			pts = Common.remove_from(s, pts);
			objects = Common.remove_from(s, objects);
			removeChild(s);
			desel_all();
		}
		
		
		private function move(e:KeyboardEvent) {
			var mov_val:Number = 5;
			if (e.ctrlKey) {
				mov_val *= 3;
			} else if (e.shiftKey) {
				mov_val *= 10;
			}
			
			if (e.keyCode == Keyboard.UP) {
				current_y -= mov_val;
			} else if (e.keyCode == Keyboard.DOWN) {
				current_y += mov_val;
			} else if (e.keyCode == Keyboard.LEFT) {
				current_x -= mov_val;
			} else if (e.keyCode == Keyboard.RIGHT) {
				current_x += mov_val;
			}
			
			current_x = Math.max(current_x, 0);
			current_y = Math.min(current_y, 0);
			
			draw_grid();
			set_scroll_rect();
		}
		
	}

}