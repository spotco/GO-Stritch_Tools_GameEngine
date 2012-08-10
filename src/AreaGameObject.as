package  {
	import flash.display.Bitmap;
	public class AreaGameObject extends GameObject {
		
		public var owidth:Number;
		public var oheight:Number;
		
		public function AreaGameObject(x1:Number,y1:Number,type:Class,width:Number,height:Number,label:String = "") {
			super(x1, y1, type, label);
			this.owidth = width;
			this.oheight = height;
			
			//graphics.beginFill(0x00FFFF, 0.6);
			graphics.beginBitmapFill((new type as Bitmap).bitmapData, null, true);
			graphics.drawRect(0, 0, owidth, -oheight);
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