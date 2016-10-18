/**
 * Created by newkrok on 12/09/16.
 */
package net.fpp.pandastory.game.module.charactercontroller
{
	import net.fpp.common.starling.module.AModel;

	public class CharacterControllerModel extends AModel
	{
		public var isLeftActive:Boolean;
		public var isRightActive:Boolean;
		public var isJumpActive:Boolean;

		public var isJumpTriggered:Boolean;

		public var jumpActivateTime:Number = 0;
	}
}