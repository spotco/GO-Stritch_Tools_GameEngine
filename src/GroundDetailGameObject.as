package  {
	public class GroundDetailGameObject extends GameObject {
		
		public var img_n:Number;
		
		public function GroundDetailGameObject(x:Number,y:Number,img:Number,label:String) {
			super(x, y, GameObject.OBJ_GROUND_DETAIL, printf("(%s)gd_img:%1.0f", label, img));
			this.img_n = img;
		}
		
		public override function get_jsonobject() {
			var o = super.get_jsonobject();
			o["img"] = this.img_n;
			return o;
		}
		
	}

}