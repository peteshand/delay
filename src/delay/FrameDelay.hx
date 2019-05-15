package delay;

import haxe.Constraints.Function;
import utils.FunctionUtil;
/**
 * ...
 * @author P.J.Shand
 */
class FrameDelay implements IDelayObject
{
	public var callback:Function;
	public var complete(get, null):Bool;
	public var repeat:Int;
	public var fireCount:Int = 0;
	public var id:String;
	public var markedForRemoval:Bool = false;
	
	var params:Array<Dynamic>;
	var frames:Int;
	var count:Int = 0;
	
	public function new(frames:Int, callback:Function, params:Array<Dynamic>=null, repeat:Int=0, ?id:String) 
	{
		this.frames = frames;
		this.callback = callback;
		this.params = params;
		this.repeat = repeat;
		this.id = id;
	}
	
	function get_complete():Bool 
	{
		if (count++ >= frames) return true;
		return false;
	}
	
	public function dispatch():Void
	{
		FunctionUtil.dispatch(callback, params); 
	}
	
	public function reset():Void
	{
		count = 0;
	}
}