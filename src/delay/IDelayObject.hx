package delay;

import haxe.Constraints.Function;
/**
 * @author P.J.Shand
 */
interface IDelayObject 
{
	private var params:Array<Dynamic>;
	var callback:Function;
	var complete(get, never):Bool;
	var repeat:Int;
	var fireCount:Int;
	var id:String;
	var markedForRemoval:Bool;
	function dispatch():Void;
	function reset():Void;
}