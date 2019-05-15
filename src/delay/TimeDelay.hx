package delay;

import haxe.Constraints.Function;
import utils.FunctionUtil;
import time.TimeUtils;
import time.TimeUnit;
import time.GlobalTime;
/**
 * ...
 * @author P.J.Shand
 */
class TimeDelay implements IDelayObject
{
	public var callback:Function;
	public var complete(get, null):Bool;
	public var repeat:Int;
	public var fireCount:Int = 0;
	public var id:String;
	public var markedForRemoval:Bool = false;
	
	var params:Array<Dynamic>;
	var startTime:Float;
	var endTime:Float;
	var millisecondsDuration:Float;
	
	public function new(duration:Float, callback:Function, params:Array<Dynamic>=null, timeUnit:TimeUnit=null, repeat:Int=0, ?id:String) 
	{
		this.callback = callback;
		this.params = params;
		this.repeat = repeat;
		this.id = id;

		if (timeUnit == TimeUnit.MILLISECONDS) millisecondsDuration = duration;
		else if (timeUnit == TimeUnit.SECONDS) millisecondsDuration = TimeUtils.secondsToMil(duration);
		else if (timeUnit == TimeUnit.MINUTES) millisecondsDuration = TimeUtils.minutesToMil(duration);
		else if (timeUnit == TimeUnit.HOURS) millisecondsDuration = TimeUtils.hoursToMil(duration);
		else if (timeUnit == TimeUnit.DAYS) millisecondsDuration = TimeUtils.daysToMil(duration);
		
		reset();
	}
	
	function get_complete():Bool 
	{
		if (GlobalTime.nowTime() >= endTime) return true;
		return false;
	}
	
	public function dispatch():Void
	{
		FunctionUtil.dispatch(callback, params); 
	}
	
	public function reset():Void
	{
		startTime = GlobalTime.nowTime();
		endTime = startTime + millisecondsDuration;
	}
}