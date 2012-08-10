package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	[SWF(backgroundColor = "#000000", frameRate = "60", width = "1000", height = "650")]

	public class Main extends Sprite {
		
		public static var WID:Number = 1000;
		public static var HEI:Number = 650;
		public static var spr:LevelEditor;
		public static var preview_drawer:PreviewDrawer;
		
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
				ExternalInterface.addCallback("json_in", spr.json_in);
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
			} catch (e:Error) {
				TextRenderer.render_text(Main.spr.graphics, e.message, 50, 50, 10);
			}
		}
		
	}
	
}