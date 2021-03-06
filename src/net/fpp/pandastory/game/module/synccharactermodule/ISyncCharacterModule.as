/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.module.synccharactermodule
{
	import net.fpp.pandastory.vo.CharacterVO;

	public interface ISyncCharacterModule
	{
		function setCharacterDirection( direction:int ):void;

		function setCharacterState( characterState:String ):void;

		function setPosition( x:Number, y:Number ):void;

		function getXPosition():Number;

		function getYPosition():Number;

		function setCharacterVO( value:CharacterVO ):void;
	}
}