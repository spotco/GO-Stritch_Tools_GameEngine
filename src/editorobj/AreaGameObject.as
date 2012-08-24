package editorobj  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	public class AreaGameObject extends GameObject {
		
		public var owidth:Number;
		public var oheight:Number;
		
		public function AreaGameObject(x1:Number,y1:Number,type:Class,width:Number,height:Number,label:String = "") {
			super(x1, y1, type, label);
			this.owidth = width;
			this.oheight = height;
			
			var bmd:BitmapData = (new type as Bitmap).bitmapData;
			bmd.colorTransform(bmd.rect, new ColorTransform(1, 1, 1, 0.3));
			graphics.beginBitmapFill(bmd);
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