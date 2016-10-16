/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.handler
{
	import net.fpp.common.starling.module.IHandler;
	import net.fpp.pandastory.game.module.synccharactermodule.ISyncCharacterModule;
	import net.fpp.pandastory.game.service.websocketservice.IWebSocketService;
	import net.fpp.pandastory.game.service.websocketservice.event.WebSocketServiceEvent;
	import net.fpp.pandastory.game.service.websocketservice.vo.CharacterModuleSyncDataVO;

	import starling.events.Event;

	public class WebSocketSyncHandler implements IHandler
	{
		[Inject]
		public var webSocketService:IWebSocketService;

		[Inject]
		public var syncCharacterModule:ISyncCharacterModule;

		public function onInited():void
		{
			this.webSocketService.addEventListener( WebSocketServiceEvent.ON_SYNC, this.onSync );
		}

		private function onSync( e:Event ):void
		{
			var characterModuleData:CharacterModuleSyncDataVO = e.data as CharacterModuleSyncDataVO;

			this.syncCharacterModule.setPosition( characterModuleData.x, characterModuleData.y );
			this.syncCharacterModule.setCharacterDirection( characterModuleData.direction );
			this.syncCharacterModule.setCharacterState( characterModuleData.characterState );
		}

		public function dispose():void
		{
			this.webSocketService = null;
			this.webSocketService.removeEventListener( WebSocketServiceEvent.ON_SYNC, this.onSync );

			this.syncCharacterModule = null;
		}
	}
}