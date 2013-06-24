package editorobj {
	import flash.display.Bitmap;
	
	public class GroundDetailGameObject extends GameObject {
		
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_1.png")] public static var DETAIL_1:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_2.png")] public static var DETAIL_2:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_3.png")] public static var DETAIL_3:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_4.png")] public static var DETAIL_4:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_5.png")] public static var DETAIL_5:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_6.png")] public static var DETAIL_6:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_7.png")] public static var DETAIL_7:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_8.png")] public static var DETAIL_8:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_9.png")] public static var DETAIL_9:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_10.png")] public static var DETAIL_10_SIGN_VINES:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_11.png")] public static var DETAIL_11_SIGN_WARNING:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_12.png")] public static var DETAIL_12_SIGN_ROCKS:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_13.png")] public static var DETAIL_13_SIGN_WATER:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_14.png")] public static var DETAIL_14_SIGN_SPIKES:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_15.png")] public static var DETAIL_15_DOGBUSH:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_16.png")] public static var DETAIL_16_DOGBUSH2:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_17.png")] public static var DETAIL_17_DOGSTATUE:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_18.png")] public static var DETAIL_18_EMPTYBUSH:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_19.png")] public static var DETAIL_19_SIGN_SPIKES:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_20.png")] public static var DETAIL_20_FLOWER1:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_21.png")] public static var DETAIL_21_FLOWER2:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_22.png")] public static var DETAIL_22_FLOWER3:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_23.png")] public static var DETAIL_23_FLOWER4:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_24.png")] public static var DETAIL_24_FLOWER6:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_25.png")] public static var DETAIL_25_GRASS:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_26.png")] public static var DETAIL_26_GRASS1:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_27.png")] public static var DETAIL_27_GRASS2:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_28.png")] public static var DETAIL_28_GRASS3:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_29.png")] public static var DETAIL_29_MUSHROOMBUSH:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_30.png")] public static var DETAIL_30_ROCK0:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_31.png")] public static var DETAIL_31_ROCK1:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_32.png")] public static var DETAIL_32_ROCK2:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_33.png")] public static var DETAIL_33_ROCK3:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_34.png")] public static var DETAIL_34_ROCK4:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_35.png")] public static var DETAIL_35_ROCK5:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_36.png")] public static var DETAIL_36_ROCK6:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_37.png")] public static var DETAIL_37_ROUNDBUSH:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_38.png")] public static var DETAIL_38_TALLBUSH:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_39.png")] public static var DETAIL_39_TREE0:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_40.png")] public static var DETAIL_40_TREE1:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_41.png")] public static var DETAIL_41_TREE2:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_42.png")] public static var DETAIL_42_TREE3:Class;
		[Embed(source = "../../bin/imgs/BG1_ground_detail/BG1_detail_43.png")] public static var DETAIL_43_TREE4:Class;
		
		
		
		private static var details:Array = [null,
			DETAIL_1, 
			DETAIL_2, 
			DETAIL_3, 
			DETAIL_4, 
			DETAIL_5, 
			DETAIL_6, 
			DETAIL_7,
			DETAIL_8,
			DETAIL_9,
			DETAIL_10_SIGN_VINES,
			DETAIL_11_SIGN_WARNING,
			DETAIL_12_SIGN_ROCKS,
			DETAIL_13_SIGN_WATER,
			DETAIL_14_SIGN_SPIKES,
			DETAIL_15_DOGBUSH,
			DETAIL_16_DOGBUSH2,
			DETAIL_17_DOGSTATUE,
			DETAIL_18_EMPTYBUSH,
			DETAIL_19_SIGN_SPIKES,
			DETAIL_20_FLOWER1,
			DETAIL_21_FLOWER2,
			DETAIL_22_FLOWER3,
			DETAIL_23_FLOWER4,
			DETAIL_24_FLOWER6,
			DETAIL_25_GRASS,
			DETAIL_26_GRASS1,
			DETAIL_27_GRASS2,
			DETAIL_28_GRASS3,
			DETAIL_29_MUSHROOMBUSH,
			DETAIL_30_ROCK0,
			DETAIL_31_ROCK1,
			DETAIL_32_ROCK2,
			DETAIL_33_ROCK3,
			DETAIL_34_ROCK4,
			DETAIL_35_ROCK5,
			DETAIL_36_ROCK6,
			DETAIL_37_ROUNDBUSH,
			DETAIL_38_TALLBUSH,
			DETAIL_39_TREE0,
			DETAIL_40_TREE1,
			DETAIL_41_TREE2,
			DETAIL_42_TREE3,
			DETAIL_43_TREE4
		];
		
		public static function get_num_ground_details():int {
			return details.length - 1;
		}
		
		public var img_n:Number;
		
		public function GroundDetailGameObject(x:Number, y:Number, img:Number, label:String) {
			super(x, y, GameObject.OBJ_GROUND_DETAIL, label);
			this.img_n = img;
			var bmpd:Class = details[img];
			if (bmpd) {
				this.img = new bmpd as Bitmap;
				this.img.scaleX = 0.5;
				this.img.scaleY = 0.5;
				this.img.x = -this.img.width / 2;
				this.img.y = -this.img.height;
				this.img.alpha = 0.7;
				this.addChild(this.img);
			} else {
				BrowserOut.msg_to_browser("console.log", "bad ground_detail img #");
			}
		}
		
		public override function get_jsonobject() {
			var o = super.get_jsonobject();
			o["img"] = this.img_n;
			return o;
		}
		
	}

}