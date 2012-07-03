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
			} catch (e:Error) {
				TextRenderer.render_text(Main.spr.graphics, e.message, 50, 50, 10);
			}
		}
		
	}
	
}