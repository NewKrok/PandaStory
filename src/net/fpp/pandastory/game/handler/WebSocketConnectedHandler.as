/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.handler
{
	import net.fpp.common.starling.module.IHandler;
	import net.fpp.pandastory.game.IGameMain;
	import net.fpp.pandastory.game.service.websocketservice.IWebSocketService;
	import net.fpp.pandastory.game.service.websocketservice.event.WebSocketServiceEvent;
	import net.fpp.pandastory.vo.PlayerInfoVO;

	import starling.events.Event;

	public class WebSocketConnectedHandler implements IHandler
	{
		[Inject]
		public var webSocketService:IWebSocketService;

		[Inject]
		public var gameMain:IGameMain;

		[Inject]
		public var playerInfoVO:PlayerInfoVO;

		public function onInited():void
		{
			this.webSocketService.addEventListener( WebSocketServiceEvent.ON_CONNECTED, this.onConnected );
		}

		private function onConnected( e:Event ):void
		{
			this.webSocketService.join( playerInfoVO.characterVO.name );

			this.gameMain.onWebSocketConnected();
		}

		public function dispose():void
		{
			this.webSocketService.removeEventListener( WebSocketServiceEvent.ON_CONNECTED, this.onConnected );
			this.webSocketService = null;

			this.gameMain = null;
		}
	}
}