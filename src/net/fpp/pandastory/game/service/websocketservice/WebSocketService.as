/**
 * Created by newkrok on 27/09/16.
 */
package net.fpp.pandastory.game.service.websocketservice
{
	import com.worlize.websocket.WebSocket;
	import com.worlize.websocket.WebSocketErrorEvent;
	import com.worlize.websocket.WebSocketEvent;
	import com.worlize.websocket.WebSocketMessage;

	import flash.external.ExternalInterface;

	import net.fpp.common.starling.module.AService;
	import net.fpp.pandastory.game.service.websocketservice.constant.CSocketHeader;
	import net.fpp.pandastory.game.service.websocketservice.event.WebSocketServiceEvent;
	import net.fpp.pandastory.game.service.websocketservice.parser.SyncDataParser;
	import net.fpp.pandastory.game.service.websocketservice.vo.WebSocketDataVO;

	public class WebSocketService extends AService implements IWebSocketService
	{
		private var _websocket:WebSocket;

		private var _parser:SyncDataParser;

		private var _clientId:Number = Math.floor( Math.random() * 10000 );
		private var _serverId:Number;

		override public function onInited():void
		{
			this._parser = new SyncDataParser();

			this._websocket = new WebSocket( "ws://88.99.14.215:8080/ws", "*" );
			this._websocket.addEventListener( WebSocketEvent.CLOSED, handleWebSocketClosed );
			this._websocket.addEventListener( WebSocketEvent.OPEN, handleWebSocketOpen );
			this._websocket.addEventListener( WebSocketEvent.MESSAGE, handleWebSocketMessage );
			this._websocket.addEventListener( WebSocketErrorEvent.CONNECTION_FAIL, handleConnectionFail );
		}

		private function handleWebSocketOpen( event:WebSocketEvent ):void
		{
			if ( ExternalInterface.available )
			{
				ExternalInterface.call( 'console.log', 'On Connected' );
			}
			trace( "On Connected" );
			this.dispatchEventWith( WebSocketServiceEvent.ON_CONNECTED );
		}

		private function handleWebSocketClosed( event:WebSocketEvent ):void
		{
			if ( ExternalInterface.available )
			{
				ExternalInterface.call( 'console.log', 'On Disconnected' );
			}
			trace( "Disconnected" );
		}

		private function handleConnectionFail( event:WebSocketErrorEvent ):void
		{
			trace( "Connection Failure: " + event.text );
		}

		private function handleWebSocketMessage( event:WebSocketEvent ):void
		{
			if ( ExternalInterface.available )
			{
				ExternalInterface.call( 'console.log', 'On Message: ' + event.message.type );
			}

			if( event.message.type === WebSocketMessage.TYPE_UTF8 )
			{
				try
				{
					var webSocketDataVO:Object = JSON.parse( event.message.utf8Data );
				}
				catch( e:Error )
				{
					trace( 'WARNING! Parsing error at: ', event.message.utf8Data );
					return;
				}

				switch( webSocketDataVO.header )
				{
					case CSocketHeader.JOIN:
						this._serverId = this._clientId;

						this.sendData( CSocketHeader.SET_SERVER_ID, {serverId: this._serverId} );
						break;

					case CSocketHeader.SET_SERVER_ID:
						this._serverId = webSocketDataVO.data.serverId;
						break;

					case CSocketHeader.SYNC:
						this.dispatchEventWith( WebSocketServiceEvent.ON_SYNC, false, this._parser.parse( webSocketDataVO.data ) );
						break;
				}
			}
		}

		public function connect():void
		{
			this._websocket.connect();
		}

		public function join():void
		{
			this.sendData( CSocketHeader.JOIN, {clientId: this._clientId} );
		}

		public function sync( data:Object ):void
		{
			//this.sendData( CSocketHeader.SYNC, data );
		}

		private function sendData( header:String, data:Object ):void
		{
			var webSocketDataVO:WebSocketDataVO = new WebSocketDataVO;
			webSocketDataVO.header = header;
			webSocketDataVO.data = data;

			var webSocketDataJSON:String = JSON.stringify( webSocketDataVO );

			if ( ExternalInterface.available )
			{
				ExternalInterface.call( 'console.log', 'Send Message: ' + webSocketDataJSON );
			}

			this._websocket.sendUTF( webSocketDataJSON );
		}

		override public function dispose():void
		{

		}
	}
}