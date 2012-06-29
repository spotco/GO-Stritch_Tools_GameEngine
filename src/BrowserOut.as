package  {
	import flash.external.ExternalInterface;

	public class BrowserOut {
		
		public static function msg_to_browser(func:String, param:String) {
			try {
				if (ExternalInterface.available) {
					ExternalInterface.call(func, param);
				}
			} catch (e:Error) {
				TextRenderer.render_text(Main.spr.graphics, e.message, 50, 50, 20);
			}
			trace(printf("JSCALL FUNC:%s PARAMS:%f", func, param));
		}
		
	}

}