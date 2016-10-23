/**
 * Created by newkrok on 12/09/16.
 */
package net.fpp.pandastory.game.module.character
{
	import Box2D.Dynamics.b2Body;

	import net.fpp.common.geom.SimplePoint;
	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.pandastory.vo.CharacterVO;

	public interface ICharacterModule extends IUpdatableModule
	{
		function setCharacterVO( value:CharacterVO ):void

		function getCharacterPhysicsObject():b2Body;

		function getIsOnGround():Boolean;

		function setDirection( value:int ):void;

		function getDirection():int;

		function setState( value:String ):void;

		function getState():String;

		function getCharacterVO():CharacterVO;

		function setPosition( startPoint:SimplePoint ):void;
	}
}