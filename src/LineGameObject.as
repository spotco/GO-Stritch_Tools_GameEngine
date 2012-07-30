package  {
	public class LineGameObject extends GameObject {
		
		var owidth:Number = 10;
		var oheight:Number = 10;
		
		public function LineGameObject(x:Number,y:Number,type:Class,width:Number,height:Number,label:String = "") {
			super(x, y, type, label);
			this.owidth = width;
			this.oheight = height;
			graphics.beginFill(0x000FFF, 0.5);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		public override function get_jsonobject() {
			var o = super.get_jsonobject();
			o["width"] = owidth;
			o["height"] = oheight;
			return o;
		}
		
	}

}