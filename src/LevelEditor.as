package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import com.adobe.serialization.json.*;

	public class LevelEditor extends Sprite {
		
		public var LINE_LABELS_ON:Boolean = false;
		public var CAN_FALL_THROUGH_LINE:Boolean = true;
		
		public var cur_obj_type = GameObject.OBJ_BONE;
		public var cur_ground_detail_val = 1;
		public var cur_island_hei = 50;
		
		var current_x:Number = 0;
		var current_y:Number = 0;
		
		public var pts:Array = new Array;
		var lines:Array = new Array;
		var objects:Array = new Array;
		var undo_stack:Array = new Array;
		var line_ndir_mode:String = LineIsland.NDIR_LEFT;
		
		var player_start_pt:ClickPoint = null;
		public var obj_label_count:Number = 0;
		public var line_label_count:Number = 0;
		public var cur_sel_pt:ClickPoint = null;
		public var lastkey:uint = 0x000000;
		
		
		private var grid_draw:Sprite;
		private var preview_draw:PreviewDrawer;
		
		public function LevelEditor() { this.addEventListener(Event.ADDED_TO_STAGE, function() { init();} ); }
		
		private function init() {
			this.grid_draw = new Sprite();
			addChild(this.grid_draw);
			
			this.preview_draw = new PreviewDrawer(this);
			addChildAt(this.preview_draw,0);
			draw_grid();
			add_controls();
			set_scroll_rect();
			BrowserOut.msg_to_browser("toggle_ndir", line_ndir_mode);
		}
		
		private function set_scroll_rect() {
			this.scrollRect = new Rectangle(current_x, current_y, Main.WID, Main.HEI);
		}
		
		private function draw_grid() {
			grid_draw.graphics.clear();
			
			var ct = 0;
			for (var i:int = Math.floor(current_y / 50) * 50 + Main.HEI; i >= current_y; i -= 50) {
				TextRenderer.render_text(grid_draw.graphics, -(i - Main.HEI) + "px", current_x, i);
				grid_draw.graphics.lineStyle(1, 0xFFFFFF, 0.3);
				grid_draw.graphics.moveTo(0, i);
				grid_draw.graphics.lineTo(current_x + Main.WID, i);
				grid_draw.graphics.lineStyle();
				
			}
			
			for (i = Math.floor(current_x / 50) * 50; i <= current_x + Main.WID; i += 50) {
				TextRenderer.render_text(grid_draw.graphics, i+"px", i, current_y+Main.HEI-20);
				grid_draw.graphics.lineStyle(1, 0xFFFFFF, 0.3);
				grid_draw.graphics.moveTo(i, Main.HEI);
				grid_draw.graphics.lineTo(i, current_y);
				grid_draw.graphics.lineStyle();
				
			}
		}
		
		private function add_controls() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onClick);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp );
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
				
				
				var newobj:GameObject;
				if (cur_obj_type == GameObject.OBJ_WATER && pts[0]) {
					var wid = pts[pts.length-1].x - click_x;
					newobj = new LineGameObject(click_x, click_y, cur_obj_type, wid, cur_island_hei, String(obj_label_count));
					BrowserOut.msg_to_browser("console.log", String(wid));
				
				} else if (pts[0] && (cur_obj_type == GameObject.OBJ_BLOCKER || cur_obj_type == GameObject.OBJ_CAVEWALL)) {
					var wid = pts[pts.length - 1].x - click_x;
					var hei = Common.normal_tofrom_stage_coord(click_y) - pts[pts.length - 1].y;
					newobj = new AreaGameObject(click_x, click_y, cur_obj_type, wid, hei, String(obj_label_count));
					
				} else if (cur_obj_type == GameObject.OBJ_GROUND_DETAIL) {
					newobj = new GroundDetailGameObject(click_x, click_y, cur_ground_detail_val, String(obj_label_count));
					
				} else {
					newobj = new GameObject(click_x, click_y, cur_obj_type, String(obj_label_count));
				}
				
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
					var nline:LineIsland;
					if (LINE_LABELS_ON) {
						nline = new LineIsland(cur_sel_pt.normal_x, cur_sel_pt.normal_y, click_x, click_y, line_ndir_mode, String(line_label_count),cur_island_hei,CAN_FALL_THROUGH_LINE);
						line_label_count++;
					} else {
						nline = new LineIsland(cur_sel_pt.normal_x, cur_sel_pt.normal_y, click_x, click_y, line_ndir_mode,"",cur_island_hei,CAN_FALL_THROUGH_LINE);
					}
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
		
		public function toggle_line_labels():Boolean {
			LINE_LABELS_ON = !LINE_LABELS_ON;
			return LINE_LABELS_ON;
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
		
		private function toggle_line_ndir_mode() {
			if (line_ndir_mode == LineIsland.NDIR_LEFT) {
				line_ndir_mode = LineIsland.NDIR_RIGHT;
			} else if (line_ndir_mode == LineIsland.NDIR_RIGHT) {
				line_ndir_mode = LineIsland.NDIR_LEFT;
			}
			BrowserOut.msg_to_browser("toggle_ndir", line_ndir_mode);
		}
		
		public function change_ndir(tar:String) {
			line_ndir_mode = tar;
		}
		
		private function onKeyUp(e:KeyboardEvent) { 
			lastkey = 0x000000;
			if (e.keyCode == Keyboard.TAB) {
				toggle_line_ndir_mode();
			}
		}
		
		private function onKeyDown(e:KeyboardEvent) {
			lastkey = e.keyCode;
			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT) {
				move(e);
			} else if (e.keyCode == Keyboard.ESCAPE) {
				desel_all();
				this.lastkey = 0x000000;
			} else if (e.keyCode == Keyboard.Z) {
				undo();
			} else if (e.keyCode == Keyboard.P) {
				json_out();
			}
		}
		
		public function json_out() {
			BrowserOut.msg_to_browser("msg_out", get_current_json());
		}
		
		//json_in('{"start_x":"0","start_y":"0","assert_links":"0","islands":[{"type":"line","x1":"107","y1":"357","x2":"296","y2":"202"},{"type":"line","x1":"296","y1":"202","x2":"557","y2":"299"}],}');
		public function json_in(json:String) {
			this.draw_grid();
			var json_o:Object;
			try {
				json_o = JSON.decode(json);
			} catch (e:Error) {
				BrowserOut.msg_to_browser("console.log", "JSON parse error: " + e.message);
				TextRenderer.render_text(Main.spr.graphics, "JSON parse error: " + e.message, 50, 50, 10);
				return;
			}
			BrowserOut.msg_to_browser("console.log", "JSON parsed, loading level...");
			lines = removeAll(lines);
			pts = removeAll(pts);
			objects = removeAll(objects);
			undo_stack = new Array();
			cur_sel_pt = null;
			var pts_hash:Object = new Object();
			for each(var i:Object in json_o.islands) {
				var pt1:ClickPoint;
				var pt2:ClickPoint;
				var pt1hash:String = i.x1 + "," + i.y1;
				var pt2hash:String = i.x2 + "," + i.y2;
				
				if (pts_hash[pt1hash]) {
					pt1 = pts_hash[pt1hash];
				} else {
					pt1 = new ClickPoint(i.x1, i.y1);
					pts_hash[pt1hash] = pt1;
					addChild(pt1);
					pts.push(pt1);
				}
				
				if (pts_hash[pt2hash]) {
					pt2 = pts_hash[pt2hash];
				} else {
					pt2 = new ClickPoint(i.x2, i.y2);
					pts_hash[pt2hash] = pt2;
					addChild(pt2);
					pts.push(pt2);
				}
				
				var nline:LineIsland = new LineIsland(pt1.normal_x, pt1.normal_y, pt2.normal_x, pt2.normal_y, i.ndir, i.label, 50, i.can_fall == "true");
				lines.push(nline);
				addChild(nline);
				BrowserOut.msg_to_browser("console.log", printf("PT1(%f,%f) -> PT2(%f,%f)",pt1.normal_x,pt1.normal_y,pt2.normal_x,pt2.normal_y));
			}
			
			for each(var o:Object in json_o.objects) {
				var x:Number = Number(o.x);
				var y:Number = Number(o.y);
				var label:String = o.label || "";
				var nobj:ClickPoint = new ClickPoint(x, y, 0x00FFFF, label);
				objects.push(nobj);
				addChild(nobj);
				BrowserOut.msg_to_browser("console.log", printf("Object label(%s) at(%f,%f)", nobj.label,nobj.normal_x, nobj.normal_y));
			}
			
			var pstartx:Number = 0;
			var pstarty:Number = 0;
			if (json_o.start_x) {
				pstartx = json_o.start_x;
			}
			if (json_o.start_y) {
				pstarty = json_o.start_y;
			}
			
			var playerstart:ClickPoint = new ClickPoint(pstartx, pstarty, 0xFFFF00, "Player Start");
			BrowserOut.msg_to_browser("console.log", printf("Player start at(%f,%f)",playerstart.normal_x, playerstart.normal_y));
			this.player_start_pt = playerstart;
			addChild(playerstart);
			
			BrowserOut.msg_to_browser("console.log", "Successfully parsed json.");
		}
		
		private function removeAll(a:Array):Array {
			return a.filter(function(o) { removeChild(o); return false; } );
		}
		
		public function get_current_json():String {
			var jso:Object = { };
			
			jso["start_x"] = player_start_pt != null ? player_start_pt.x : 0;
			jso["start_y"] = player_start_pt != null ? Common.normal_tofrom_stage_coord(player_start_pt.y) : 0;
			jso["assert_links"] = 0;
			
			jso["islands"] = [];
			for (var i = 0; i < lines.length; i++) {
				jso["islands"].push(lines[i].get_jsonobject());
			}
			
			jso["objects"] = [];
			for (i = 0; i < objects.length; i++) {
				jso["objects"].push(objects[i].get_jsonobject());
			}
			
			return JSON.encode(jso, true,120);
		}
		
		public function undo() {
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
				mov_val *= 11;
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