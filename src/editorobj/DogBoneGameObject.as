package editorobj {
	public class DogBoneGameObject extends GameObject {
		
		public var bid:Number;
		
		public function DogBoneGameObject(x:Number, y:Number, bid:Number) {
			super(x, y, GameObject.OBJ_BONE, "BID:"+String(bid));
			this.bid = bid;
		}
		
		public override function get_jsonobject() {
			var o = super.get_jsonobject();
			o["bid"] = this.bid;
			return o;
		}
		
	}

}