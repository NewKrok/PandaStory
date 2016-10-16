/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.handler
{
	import net.fpp.common.starling.module.IHandler;
	import net.fpp.pandastory.game.IGameMain;
	import net.fpp.pandastory.game.module.characteranimation.ICharacterAnimationModule;
	import net.fpp.pandastory.game.module.characteranimation.event.CharacterAnimationModuleEvent;

	import starling.events.Event;

	public class CharacterAnimationLoadedHandler implements IHandler
	{
		[Inject]
		public var characterAnimationModule:ICharacterAnimationModule;

		[Inject]
		public var gameMain:IGameMain;

		public function onInited():void
		{
			this.characterAnimationModule.addEventListener( CharacterAnimationModuleEvent.COMPLETE, this.onCharacterAnimationLoaded );
		}

		private function onCharacterAnimationLoaded( e:Event ):void
		{
			this.gameMain.onCharacterAnimationLoaded();
		}

		public function dispose():void
		{
			this.characterAnimationModule.removeEventListener( CharacterAnimationModuleEvent.COMPLETE, this.onCharacterAnimationLoaded );
			this.characterAnimationModule = null;

			this.gameMain = null;
		}
	}
}