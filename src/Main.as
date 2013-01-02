package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import editorobj.*;
	
	[SWF(backgroundColor = "#000000", frameRate = "60", width = "1000", height = "650")]

	public class Main extends Sprite {
		
		public static var WID:Number = 1000;
		public static var HEI:Number = 650;
		public static var spr:LevelEditor;
		public static var preview_drawer:PreviewDrawer;
		
		//to add object, add to Common, Add bitmap class to gameobject and add to gameobj constructor
		//change in leveleditor if area/line object (both onmouseup and json_in
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			spr = new LevelEditor;
			stage.addChild(spr);
			
			Security.allowDomain("*");
			try {
				ExternalInterface.addCallback("json_in", function(t) {
					try {
						spr.json_in(t as String);
					} catch (e:Error) {
						BrowserOut.msg_to_browser("console.log", e.name + " " + e.message);
					}
				});
				ExternalInterface.addCallback("json_out", function() {
					try {
						spr.json_out();
					} catch (e:Error) {
						BrowserOut.msg_to_browser("console.log", e.message);
					}
				});
				ExternalInterface.addCallback("undo", spr.undo);
				ExternalInterface.addCallback("change_ndir", spr.change_ndir);
				ExternalInterface.addCallback("toggle_line_labels", spr.toggle_line_labels);
				ExternalInterface.addCallback("toggle_can_fall", function() {
					spr.CAN_FALL_THROUGH_LINE = !spr.CAN_FALL_THROUGH_LINE;
					return spr.CAN_FALL_THROUGH_LINE;
				});
				ExternalInterface.addCallback("push_island_hei", function(t) {
					spr.cur_island_hei = Number(t);
				});
				ExternalInterface.addCallback("change_ground_detail_val", function(val) {
					spr.cur_ground_detail_val = Number(val);
					BrowserOut.msg_to_browser("console.log", "ground_detail_val changed to:" + val);
				});
				ExternalInterface.addCallback("change_object_type", function(t) {
					t = Common.string_to_gameobjectclass(t);
					if (t == null) {
						TextRenderer.render_text(Main.spr.graphics, "obj sel error:"+t, 50, 50, 10);
					} else {
						spr.cur_obj_type = t;
					}
				});
				ExternalInterface.addCallback("shift_all", function(t) {
					spr.shift_all(t);
				});
				ExternalInterface.addCallback("change_zoom", function(t) {
					spr.change_camerastate(t);
				});
				ExternalInterface.addCallback("change_ground_type_val", function(t) {
					if (t == "open") {
						spr.change_ground_mode(LineIsland.GROUND_TYPE_OPEN);
					} else if (t == "cave") {
						spr.change_ground_mode(LineIsland.GROUND_TYPE_CAVE);
					} else if (t == "cloud") {
						BrowserOut.msg_to_browser("console.log", "invalid ground type");
					} else if (t == "bridge") {
						spr.change_ground_mode(LineIsland.GROUND_TYPE_BRIDGE);
					} else if (t == "lab") {
						spr.change_ground_mode(LineIsland.GROUND_TYPE_LAB);
					} else {
						BrowserOut.msg_to_browser("console.log", "invalid ground type");
					}
				});
				ExternalInterface.addCallback("zoom", function(t) {
					spr.zoom(t);
				});
			} catch (e:Error) {
				TextRenderer.render_text(Main.spr.graphics, e.message, 50, 50, 10);
			}
			
			//var a:String = '{"start_x": 0,"connect_pts": {}, "start_y": 0,"assert_links": 0,"islands": [],"objects": [{"label": "0", "x": 284, "y": 464, "y2": 612, "x2": 357, "type": "spikevine"}]}';
			//var b:String = '{"assert_links": 0,"objects": [],"start_y": 0,"islands": [{"y2": 309, "type": "line", "ndir": "left", "x1": 690, "hei": 50, "y1": 524, "can_fall": true, "x2": 403}],"start_x": 0}';
			//spr.json_in(a);
		}
		
	}
	
}