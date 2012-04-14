package {
	import flash.display.Sprite;
	import flash.events.Event;
	import com.adobe.serialization.json.*;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.*;
	import flash.utils.Timer;
	import game_obj.*;
	
	[SWF(backgroundColor = "#000000", frameRate = "60", width = "480", height = "320")]
	
	public class Main extends Sprite {
		
		public static var WID:Number = 480;
		public static var HEI:Number = 320;
		
		public static var is_mouse_down:Boolean = false;
		public static var is_key_down:uint = 0;
		public static var mouse_x:Number;
		public static var mouse_y:Number;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouse_down);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouse_up);
			
			//init_game_engine("load_me.map");
			init_level_editor();
		}
		
		private function init_level_editor() {
			clear();
			var level_editor:Level_Editor = new Level_Editor;
			level_editor.addEventListener(Event.ADDED_TO_STAGE, function() {
				level_editor.init();
			});
			this.addChild(level_editor);
		}
		
		private function init_game_engine(path:String) {
			var myRequest:URLRequest = new URLRequest(path);
			var myLoader = new URLLoader();
			myLoader.addEventListener(Event.COMPLETE, load_game_map_onload);
			myLoader.load(myRequest);
		}
		
		private function load_game_map_onload(evt:Event) {
			clear();
			var game_engine:Game_Engine = new Game_Engine;
			game_engine.addEventListener(Event.ADDED_TO_STAGE, function() {
				game_engine.init(evt.target.data);
			});
			this.addChild(game_engine);
		}
		
		private function clear() {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
		}
		
		private function key_up(e:KeyboardEvent) {
			is_key_down = 0;
		}
		
		private function key_down(e:KeyboardEvent) {
			is_key_down = e.keyCode;
		}
		
		private function mouse_down(e:Event) {
			is_mouse_down = true;
		}
		
		private function mouse_up(e:MouseEvent) {
			is_mouse_down = false;
		}
		
	}
	

	
}