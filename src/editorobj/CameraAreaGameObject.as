package editorobj  {
	public class CameraAreaGameObject extends AreaGameObject {
		
		var camera_state:Object;
		
		public function CameraAreaGameObject(x1:Number,y1:Number,type:Class,width:Number,height:Number,camera_state:Object) {
			super(x1, y1, type, width, height, printf("CAM(%f,%f,%f)", camera_state.x, camera_state.y, camera_state.z));
			this.camera_state = { x:camera_state.x, y:camera_state.y, z:camera_state.z };
		}
		
		public override function get_jsonobject() {
			var o = super.get_jsonobject();
			o["camera"] = camera_state;
			return o;
		}
		
	}

}