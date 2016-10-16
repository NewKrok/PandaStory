/**
 * Created by newkrok on 02/10/16.
 */
package net.fpp.pandastory.game.module.characteranimation
{
	import dragonBones.Armature;

	import net.fpp.common.starling.module.IUpdatableModule;

	public interface ICharacterAnimationModule extends IUpdatableModule
	{
		function buildArmature( name:String ):Armature;

		function getTextureDisplay( name:String ):Object;
	}
}