package delay;

import haxe.Constraints.Function;
import time.EnterFrame;
import time.TimeUnit;

/**
 * ...
 * @author P.J.Shand
 */

class Delay 
{
	private static var delayObjects:Array<IDelayObject>;
	static var initialized:Bool = false;

	static function init() { 
		
		if (initialized) return;
		initialized = true;
		delayObjects = new Array<IDelayObject>();
		EnterFrame.add(OnTick);
  }
	
	static private function OnTick() 
	{
		for (delayObject in delayObjects){
			if (delayObject.complete) {
				delayObject.dispatch();
				if (delayObject.repeat != -1 && delayObject.fireCount >= delayObject.repeat){
					delayObject.markedForRemoval = true;
				} else {
					delayObject.fireCount++;
					delayObject.reset();
				}
			}
		}
		

		var i:Int = delayObjects.length-1;
		while (i >= 0) 
		{
			if (delayObjects[i] == null || delayObjects[i].markedForRemoval){
				delayObjects.splice(i, 1);
			}
			i--;
		}
	}
	
	public function new() { }
	
	public static function nextFrame(callback:Function, params:Array<Dynamic>=null):Void
	{
		Delay.byFrames(1, callback, params);
	}
	
	public static function byFrames(frames:Int, callback:Function, ?params:Array<Dynamic>=null, ?repeat:Int=0):Void 
	{
		Delay.init();
		delayObjects.push(new FrameDelay(frames, callback, params, repeat));
	}
	
	public static function byTime(duration:Float, callback:Function, ?params:Array<Dynamic>=null, ?timeUnit:TimeUnit=null, ?repeat:Int=0):Void 
	{
		Delay.init();
		if (timeUnit == null) timeUnit = TimeUnit.SECONDS;
		delayObjects.push(new TimeDelay(duration, callback, params, timeUnit, repeat, id));
	}
	
	public static function killDelay(callback:Function):Void 
	{
		Delay.init();
		var i = delayObjects.length - 1;
		while (i >= 0) {
			if (delayObjects[i].callback == callback) {
				delayObjects.splice(i, 1);
			}
			i--;
		}
	}
}