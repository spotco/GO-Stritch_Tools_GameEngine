package  {
	import flash.display.Bitmap;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.adobe.serialization.json.*;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.*;
	import flash.utils.Timer;
	import game_obj.*;

	public class Game_Engine extends Sprite {
		
		public static var init_pos_x:Number = 50;
		public static var init_pos_y:Number = 50;
		
		private var islands_array:Array = new Array;
		private var player:Player;
		private var timer:Timer;
		
		public function init(lvl_data:String) {
			var data:Object = JSON.decode(lvl_data);
			var i:int = 0;
			while (data[i]) { //convert to Number
				var new_i:Line_Island;
				if (Number(data[i].x1) > Number(data[i].x2)) {
					new_i = new Line_Island(data[i].x2, data[i].y2, data[i].x1, data[i].y1);
				} else {
					new_i = new Line_Island(data[i].x1, data[i].y1, data[i].x2, data[i].y2);
				}
				this.islands_array.push(new_i);
				this.addChild(new_i);
				i++;
			}
			player = new Player();
			player.set_pos(init_pos_x, init_pos_y);
			player.vx = 5;
			this.addChild(player);
			timer = new Timer(20);
			timer.addEventListener(TimerEvent.TIMER, update);
			timer.start();
		}
		
		public function destroy() {
			timer.stop();
		}
		
		private function sort_islands() {
			islands_array.sort(island_comparator);
		}
		
		private function island_comparator(a:Object, b:Object, fields:Array = null):int {
			var first:Number = (a as Base_Island).get_height(player.get_x());
			var second:Number = (b as Base_Island).get_height(player.get_x());
			if (first < second) {
				return 1;
			} else if (first > second) {
				return -1
			} else {
				return 0;
			}
		}
		
		private function update(e:Event) {
			if (!this.stage) {
				destroy();
				return;
			}
			
			var pos_x:Number = player.get_x();
			var pos_y:Number = player.get_y();
			
			//pos_x = Common.cfpe(pos_x);
			//pos_y = Common.cfpe(pos_y);
			
			var tmp:Number = Number.MAX_VALUE;
			for each(var i:Base_Island in islands_array) {
				var h:Number = i.get_height(pos_x);
				if (h > tmp) {
					this.sort_islands();
					break;
				}
				tmp = h;
			}
			var pre_y:Number = pos_y;
			var post_y:Number = pos_y + player.vy;
			var is_contact:Boolean = false;
			var contact_island:Base_Island;
			
			//var test:String = "[";
			for each(var i:Base_Island in islands_array) {
				var h:Number = i.get_height(pos_x);
				if (h != -1) {
					//test += h;
				}
				if (h != -1 && h <= pre_y && h >= post_y) {
					is_contact = true;
					post_y = h;
					contact_island = i;
					break;
				}
			}
			//test += "]";
			
			if (is_contact) {
				//trace("CONTACT pre:"+pre_y + " post:" + post_y + " " + test);
				var rise_one = contact_island.get_height(pos_x + 1) - contact_island.get_height(pos_x);
				var dx = player.vx * Math.cos(Math.atan(rise_one));
				var mov_h = contact_island.get_height(pos_x + dx);
				if (mov_h != -1 && contact_island.get_height(pos_x + player.vx) != -1) {
					pos_x = pos_x + dx;
					pos_y = mov_h;
				} else {
					pos_x = pos_x + player.vx;
					if (rise_one > 0) { //apply these changes to real version
						pos_y = pos_y + rise_one * player.vx;
					} else {
						pos_y = post_y;
					}
				}
				var ang = Math.atan((contact_island.endY - contact_island.startY) / (contact_island.endX - contact_island.startX)) * (180 / Math.PI);
				player.rotation = -ang;
				player.vy = 0;
				
				if (Main.is_mouse_down) {
					player.vy = 10;
				}
				
			} else {
				//trace("pre:"+pre_y + " post:" + post_y + " " + test);
				pos_y += player.vy;
				player.vy -= 0.5;
				
				player.rotation = player.rotation * 0.9;
				
				var pre_x:Number = pos_x;
				var post_x:Number = pos_x + player.vx;
				var has_hit_x:Boolean = false;
				for each(var i:Base_Island in islands_array) {
					Common.line_seg_intersection(pre_x,pos_y,  post_x,pos_y,  i.startX,i.startY, i.endX,i.endY);
					if (Common.ls_x != -1 && Common.ls_y != -1) {
						pos_x = Common.ls_x;
						pos_y = i.get_height(pos_x);
						has_hit_x = true;
						break;
					}
					
				}
				
				if (!has_hit_x) {
					pos_x = post_x;
				}
			}
			player.set_pos(pos_x, pos_y);
			player.anim_update();
			if (pos_y < 0) {
				player.set_pos(init_pos_x, init_pos_y);
				player.vy = 0;
			}
			
			for each(var i:Base_Island in islands_array) {
				i.update_screen_pos(player.get_x(),player.get_y());
			}
			player.update_screen_pos();
		}
		
	}

}