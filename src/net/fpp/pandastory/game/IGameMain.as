/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game
{
	import net.fpp.common.starling.module.IApplicationContext;

	public interface IGameMain extends IApplicationContext
	{
		function onWebSocketConnected():void;

		function onCharacterAnimationLoaded():void;
	}
}