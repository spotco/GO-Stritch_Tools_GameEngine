package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import game_obj.Base_Island;
	import game_obj.Line_Island;
	import flash.ui.Keyboard;
	import game_obj.Player;

	public class Level_Editor extends Sprite {
		
		private var timer:Timer;
		private var scroll_x:Number = 0;
		private var scroll_y:Number = 0;
		private var island_array:Array = new Array;
		private var player:Player;
		
		private var mouse_prev:Boolean = false;
		private var mouse_init_x:Number = -1;
		private var mouse_init_y:Number = -1;
		private var key_prev:uint = 0;
		
		public function init() {
			timer = new Timer(30);
			timer.addEventListener(TimerEvent.TIMER,update);
			timer.start();
			
			player = new Player();
			player.set_pos(Game_Engine.init_pos_x, Game_Engine.init_pos_y);
			player.update_screen_pos();
			player.x = player.get_x();
			player.y = Main.HEI - player.get_y();
			this.addChild(player);
			
		}
		
		private function just_pressed(key:uint):Boolean {
			if (Main.is_key_down == key && key_prev != key) {
				return true;
			} else {
				return false;
			}
		}
		
		private function update(e:Event) {
			if (Main.is_mouse_down && !mouse_prev) {
				mouse_init_x = stage.mouseX;
				mouse_init_y = stage.mouseY;
				mouse_prev = true;
			} else if (!Main.is_mouse_down && mouse_prev) {
				var new_i:Base_Island = new Line_Island(mouse_init_x+scroll_x,Main.HEI - mouse_init_y+scroll_y, stage.mouseX+scroll_x, Main.HEI - stage.mouseY+scroll_y);
				island_array.push(new_i);
				this.addChild(new_i);
				
				mouse_init_x = -1;
				mouse_init_y = -1;
				mouse_prev = false;
			}
			
			if (just_pressed(Keyboard.P)) {
				print_current_map();
			}
			
			if (island_array.length != 0 && just_pressed(Keyboard.Z)) {
				var i:Base_Island = island_array.pop();
				this.removeChild(i);z
			}
			
			if (Main.is_key_down == Keyboard.UP) {
				scroll_y += 5;
			} else if (Main.is_key_down == Keyboard.DOWN) {
				scroll_y -= 5;
			} else if (Main.is_key_down == Keyboard.LEFT) {
				scroll_x -= 5;
			} else if (Main.is_key_down == Keyboard.RIGHT) {
				scroll_x += 5;
			}
			
			mov_scroll();
			
			key_prev = Main.is_key_down;
		}
		
		private function mov_scroll() {
			for each(var i:Base_Island in island_array) {
				i.x = -scroll_x;
				i.y = scroll_y;
			}
			player.x = (Game_Engine.init_pos_x - scroll_x);
			player.y = Main.HEI - (Game_Engine.init_pos_y - scroll_y);
		}
		
		private function print_current_map() {
			var str:String = "[\n";
			var cnt:int = 0;
			for each(var i:Base_Island in island_array) {
				//{"x1":"0","y1":"0","x2":"300","y2":"60"},
				str += "{";
				str += '"x1":"' + i.startX + '",';
				str += '"y1":"' + i.startY + '",';
				str += '"x2":"' + i.endX + '",';
				str += '"y2":"' + i.endY + '"';
				str += '}';
				if (cnt != island_array.length-1) {
					str += ',';
				}
				str += "\n";
				cnt++;
			}
			str += "]\n";
			trace(str);
		}
		
	}

}