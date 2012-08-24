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
		private static var details:Array = [null,DETAIL_1, DETAIL_2, DETAIL_3, DETAIL_4, DETAIL_5, DETAIL_6, DETAIL_7];
		
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