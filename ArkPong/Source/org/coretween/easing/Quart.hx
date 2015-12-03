﻿
package org.coretween.easing;

class Quart {
	public static function easeIn(t:Float, b:Float, c:Float, d:Float, aa:Float, bb:Float):Float {
		return c*(t/=d)*t*t*t + b;
	}
	public static function easeOut(t:Float, b:Float, c:Float, d:Float, aa:Float, bb:Float):Float {
		return -c *((t=t/d-1)*t*t*t - 1)+ b;
	}
	public static function easeInOut(t:Float, b:Float, c:Float, d:Float, aa:Float, bb:Float):Float {
		if((t/=d/2)<1)return c/2*t*t*t*t + b;
		return -c/2 *((t-=2)*t*t*t - 2)+ b;
	}
}