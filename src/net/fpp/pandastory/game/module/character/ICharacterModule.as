/**
 * Created by newkrok on 12/09/16.
 */
package net.fpp.pandastory.game.module.character
{
	import Box2D.Dynamics.b2Body;

	import net.fpp.common.starling.module.IUpdatableModule;

	public interface ICharacterModule extends IUpdatableModule
	{
		function getCharacterPhysicsObject():b2Body;

		function getIsOnGround():Boolean;

		function setDirection( value:int ):void;

		function getDirection():int;

		function setState( value:String ):void;

		function getState():String;
	}
}