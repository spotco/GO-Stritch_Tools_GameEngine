package  
{
	public class Common {
		
		public static function cfpe(number:Number, precision:int = 3):Number { //correct floating pt error
			var correction:Number = Math.pow(10, precision);
			return Math.round(correction * number) / correction;
		}

		public static function f_eq(number1:Number, number2:Number, precision:int = 5):Boolean{ //fuzzyeq
			var difference:Number = number1 - number2;
			var range:Number = Math.pow(10, -precision);
			return difference < range && difference > -range;
		}
		
		public static var ls_x:Number = -1;
		public static var ls_y:Number = -1;
		
		public static function line_seg_intersection(a1_x:Number, a1_y:Number, 
			 a2_x:Number, a2_y:Number,
			 b1_x:Number, b1_y:Number,
			 b2_x:Number, b2_y:Number) {
				 
				 var Ax:Number = a1_x; var Ay:Number = a1_y;
				 var Bx:Number = a2_x; var By:Number = a2_y;
				 var Cx:Number = b1_x; var Cy:Number = b1_y;
				 var Dx:Number = b2_x; var Dy:Number = b2_y;
				 
				 var X:Number = 0; var Y:Number = 0;
				 var distAB:Number = 0;
				 var theCos:Number = 0;
				 var theSin:Number = 0;
				 var newX:Number = 0;
				 var ABpos:Number = 0;
				 
			if ((Ax == Bx && Ay == By) || (Cx == Dx && Cy == Dy)) {
				ls_x = -1; ls_y = -1;
				return;
			}
			if ((Ax == Cx && Ay == Cy) || (Bx == Cx && By == Cy) || (Ax == Dx && Ay == Dy) || (Bx == Dx && By == Dy)) {
				ls_x = -1; ls_y = -1;
				return;
			}

			Bx-=Ax; By-=Ay;//Translate the system so that point A is on the origin.
			Cx-=Ax; Cy-=Ay;
			Dx-=Ax; Dy-=Ay;

			distAB=Math.sqrt(Bx*Bx+By*By);//Discover the length of segment A-B.

			theCos=Bx/distAB;//Rotate the system so that point B is on the positive X axis.
			theSin=By/distAB;
			newX=Cx*theCos+Cy*theSin;
			Cy =Cy*theCos-Cx*theSin; Cx=newX;
			newX=Dx*theCos+Dy*theSin;
			Dy =Dy*theCos-Dx*theSin; Dx=newX;

			if ((Cy < 0. && Dy < 0.) || (Cy >= 0. && Dy >= 0.)) {
				ls_x = -1; ls_y = -1;
				return;
			}
			
			ABpos=Dx+(Cx-Dx)*Dy/(Dy-Cy);//Discover the position of the intersection point along line A-B.

			if (ABpos < 0. || ABpos > distAB) { 
				ls_x = -1; ls_y = -1;
				return;
			}
			
			X=Ax+ABpos*theCos;//Apply the discovered position to line A-B in the original coordinate system.
			Y=Ay+ABpos*theSin;
			
			
			ls_x = X; ls_y = Y;
		}
		
	}

}