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
				ExternalInterface.addCallback("json_out", spr.json_out);
				ExternalInterface.addCallback("undo", spr.undo);
				ExternalInterface.addCallback("change_ndir", spr.change_ndir);
				ExternalInterface.addCallback("toggle_line_labels", spr.toggle_line_labels);
				ExternalInterface.addCallback("toggle_can_fall", function() {
					spr.CAN_FALL_THROUGH_LINE = !spr.CAN_FALL_THROUGH_LINE;
					return spr.CAN_FALL_THROUGH_LINE;
				});
				ExternalInterface.addCallback("change_object_type",function(t) {
					if (t == "spike") {
						spr.cur_obj_type = GameObject.OBJ_SPIKE;
					} else if (t == "jumppad") {
						spr.cur_obj_type = GameObject.OBJ_JUMPPAD;
					} else if (t == "bone") {
						spr.cur_obj_type = GameObject.OBJ_BONE;
					} else if (t == "cape") {
						spr.cur_obj_type = GameObject.OBJ_CAPE;
					} else if (t == "rocket") {
						spr.cur_obj_type = GameObject.OBJ_ROCKET;
					} else if (t == "checkpoint") {
						spr.cur_obj_type = GameObject.OBJ_CHECKPOINT;
					} else if (t == "boost") {
						spr.cur_obj_type = GameObject.OBJ_BOOST;
					} else if (t == "water") {
						spr.cur_obj_type = GameObject.OBJ_WATER;
					} else if (t == "game_end") {
						spr.cur_obj_type = GameObject.OBJ_GAMEEND;
					} else {
						TextRenderer.render_text(Main.spr.graphics, "obj sel error:"+t, 50, 50, 10);
					}
				});
			} catch (e:Error) {
				TextRenderer.render_text(Main.spr.graphics, e.message, 50, 50, 10);
			}
		}
		
	}
	
}