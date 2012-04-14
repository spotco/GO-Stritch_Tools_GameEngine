package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
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
		
		private var popup_up:Boolean = false;
		private var window:Sprite;
		
		private var game_prev_up:Boolean = false;
		private var game_window:Sprite;
		
		private var mouse_prev:Boolean = false;
		private var mouse_init_x:Number = -1;
		private var mouse_init_y:Number = -1;
		private var straight_line:Boolean = false;
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
		
		private function get_popup_window(txt:String):Sprite {
			var cover:Sprite = new Sprite;
			cover.graphics.beginFill(0xFFFFFF);
			cover.graphics.drawRect(0, 0, Main.WID, Main.HEI);
			
			var t:TextField = new TextField();
			t.border = true;
			t.text = txt;
			t.x = 5; t.y = 5;
			t.width = Main.WID - 10; t.height = Main.HEI-10;
			cover.addChild(t);
			return cover;
		}
		
		private function update(e:Event) {
			/*var game_engine:Game_Engine = new Game_Engine;
			game_engine.addEventListener(Event.ADDED_TO_STAGE, function() {
				game_engine.init(evt.target.data);
			});
			this.addChild(game_engine);*/
			
			if (just_pressed(Keyboard.SPACE) && !game_prev_up) {
				game_window = new Sprite;
				game_window.graphics.beginFill(0xFFFFFF);
				game_window.graphics.drawRect(0, 0, Main.WID, Main.HEI);
				
				game_prev_up = true;
				var game_prev:Game_Engine = new Game_Engine;
				game_prev.addEventListener(Event.ADDED_TO_STAGE, function() {
					game_prev.init(print_current_map());
				});
				game_window.addChild(game_prev);
				this.addChild(game_window);
				return;
			} else if (just_pressed(Keyboard.ESCAPE) && game_prev_up) {
				game_prev_up = false;
				this.removeChild(game_window);
				return;
			} else if (game_prev_up) {
				return;
			}
			
			this.graphics.clear();
			if (mouse_prev) {
				this.graphics.lineStyle(2, 0x0000FF, 0.5);
				this.graphics.moveTo(mouse_init_x, mouse_init_y);
				if (straight_line) {
					this.graphics.lineTo(stage.mouseX, mouse_init_y)
				} else {
					this.graphics.lineTo(stage.mouseX, stage.mouseY);
				}
			}
			
			if (popup_up && just_pressed(Keyboard.ESCAPE)) {
				removeChild(window);
				popup_up = false;
				return;
			} else if (popup_up) {
				return;
			}
			
			if (just_pressed(Keyboard.P) && !popup_up) {
				popup_up = true;
				window = get_popup_window(print_current_map());
				addChild(window);
			}
			
			if (Main.is_mouse_down && !mouse_prev) {
				mouse_init_x = stage.mouseX;
				mouse_init_y = stage.mouseY;
				mouse_prev = true;
				if (Main.is_key_down == Keyboard.SHIFT) {
					straight_line = true;
				} else {
					straight_line = false;
				}
			} else if (!Main.is_mouse_down && mouse_prev) {
				var new_i:Base_Island;
				if (straight_line) {
					new_i = new Line_Island(mouse_init_x+scroll_x,Main.HEI - mouse_init_y+scroll_y, stage.mouseX+scroll_x, Main.HEI - mouse_init_y+scroll_y);
				} else {
					new_i = new Line_Island(mouse_init_x+scroll_x,Main.HEI - mouse_init_y+scroll_y, stage.mouseX+scroll_x, Main.HEI - stage.mouseY+scroll_y);

				}
				island_array.push(new_i);
				this.addChild(new_i);
				
				mouse_init_x = -1;
				mouse_init_y = -1;
				mouse_prev = false;
			}
			
			if (island_array.length != 0 && just_pressed(Keyboard.Z)) {
				var i:Base_Island = island_array.pop();
				this.removeChild(i);z
			}
			
			if (Main.is_key_down == Keyboard.UP) {
				scroll_y += 5;
			} else if (Main.is_key_down == Keyboard.DOWN && scroll_y > 0) {
				scroll_y -= 5;
			} else if (Main.is_key_down == Keyboard.LEFT && scroll_x > 0) {
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
		
		private function print_current_map():String {
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
			return str;
		}
		
	}

}