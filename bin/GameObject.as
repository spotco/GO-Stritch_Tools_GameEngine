package  {
	import flash.display.Bitmap;
	public class GameObject extends ClickPoint {
		
		[Embed(source = "../resc/spikes.png")] public static var SPIKE:Class;
		
		public function GameObject(x:Number,y:Number,type:String = "",label:String = "") {
			super(x, y, 0x00FFF0, label);
			trace("fuck");
		}
		
	}

}