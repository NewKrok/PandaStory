/**
 * Created by newkrok on 23/10/16.
 */
package net.fpp.pandastory.game.handler
{
	import net.fpp.common.starling.module.IHandler;
	import net.fpp.pandastory.game.module.synccharactermodule.ISyncCharacterModule;
	import net.fpp.pandastory.game.service.websocketservice.IWebSocketService;
	import net.fpp.pandastory.game.service.websocketservice.event.WebSocketServiceEvent;
	import net.fpp.pandastory.helper.CharacterVOHelper;
	import net.fpp.pandastory.vo.PlayerInfoVO;

	import starling.events.Event;

	public class OnPlayerJoinedHandler implements IHandler
	{
		[Inject]
		public var syncCharacterModule:ISyncCharacterModule;

		[Inject]
		public var webSocketService:IWebSocketService;

		[Inject]
		public var playerInfoVO:PlayerInfoVO;

		public function onInited():void
		{
			this.webSocketService.addEventListener( WebSocketServiceEvent.ON_PLAYER_JOINED, this.onPlayerJoined );
		}

		private function onPlayerJoined( e:Event ):void
		{
			this.webSocketService.removeEventListener( WebSocketServiceEvent.ON_PLAYER_JOINED, this.onPlayerJoined );

			this.syncCharacterModule.setCharacterVO( CharacterVOHelper.instance.getCharacterVOByName( e.data as String ) );

			this.webSocketService.join( playerInfoVO.characterVO.name );
		}

		public function dispose():void
		{
			this.webSocketService = null;
			this.webSocketService.removeEventListener( WebSocketServiceEvent.ON_PLAYER_JOINED, this.onPlayerJoined );

			this.syncCharacterModule = null;

			this.playerInfoVO = null;
		}
	}
}