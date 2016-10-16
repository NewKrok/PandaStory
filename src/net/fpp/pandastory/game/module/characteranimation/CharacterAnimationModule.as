/**
 * Created by newkrok on 02/10/16.
 */
package net.fpp.pandastory.game.module.characteranimation
{
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.factories.StarlingFactory;

	import flash.events.Event;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.asset.CharacterAssets;
	import net.fpp.pandastory.game.module.characteranimation.event.CharacterAnimationModuleEvent;

	public class CharacterAnimationModule extends AModule implements ICharacterAnimationModule
	{
		private const UPDATE_FREQUENCY:Number = 30;

		private var _dragonBonesFactory:StarlingFactory;

		public function CharacterAnimationModule()
		{
			this._dragonBonesFactory = new StarlingFactory();
			this._dragonBonesFactory.addEventListener( Event.COMPLETE, this.onCompleteHandler );
			this._dragonBonesFactory.parseData( CharacterAssets.getCharacterAssetsObject() );
		}

		private function onCompleteHandler( e:Event ):void
		{
			this._dragonBonesFactory.removeEventListener( Event.COMPLETE, this.onCompleteHandler );

			this.dispatchEventWith( CharacterAnimationModuleEvent.COMPLETE );
		}

		public function buildArmature( name:String ):Armature
		{
			return this._dragonBonesFactory.buildArmature( name );
		}

		public function getTextureDisplay( name:String ):Object
		{
			return this._dragonBonesFactory.getTextureDisplay( name );
		}

		public function onUpdate():void
		{
			WorldClock.clock.advanceTime( this.UPDATE_FREQUENCY / 1000 );
		}

		public function getUpdateFrequency():int
		{
			return this.UPDATE_FREQUENCY;
		}
	}
}