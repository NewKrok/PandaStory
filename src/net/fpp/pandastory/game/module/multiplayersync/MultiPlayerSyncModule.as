/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.module.multiplayersync
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.game.module.character.ICharacterModule;
	import net.fpp.pandastory.game.service.websocketservice.IWebSocketService;

	import starling.display.DisplayObject;

	public class MultiPlayerSyncModule extends AModule implements IMultiPlayerSyncModule
	{
		[Inject]
		public var webSocketService:IWebSocketService;

		[Inject]
		public var characterModule:ICharacterModule;

		public function MultiPlayerSyncModule()
		{
		}

		public function onUpdate():void
		{
			var characterView:DisplayObject = this.characterModule.getView();

			var syncData:Object = {
				x: Math.round( characterView.x ),
				y: Math.round( characterView.y ),
				direction: this.characterModule.getDirection(),
				characterState: this.characterModule.getState()
			};

			this.webSocketService.sync( syncData );
		}

		public function getUpdateFrequency():int
		{
			return 20;
		}

		override public function dispose():void
		{
			this.webSocketService = null;

			this.characterModule = null;

			super.dispose();
		}
	}
}