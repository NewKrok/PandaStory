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

		private var _lastSendedData:Object = { x:0, y:0, direction:1, characterState:'' };

		public function MultiPlayerSyncModule()
		{
		}

		public function onUpdate():void
		{
			var characterView:DisplayObject = this.characterModule.getView();

			var syncData:Object = {};
			var hasNewData:Boolean = false;

			if ( this._lastSendedData.x != Math.round( characterView.x ) )
			{
				syncData.x = Math.round( characterView.x );
				this._lastSendedData.x = syncData.x;
				hasNewData = true;
			}

			if ( this._lastSendedData.y != Math.round( characterView.y ) )
			{
				syncData.y = Math.round( characterView.y );
				this._lastSendedData.y = syncData.y;
				hasNewData = true;
			}

			if ( this._lastSendedData.direction != this.characterModule.getDirection() )
			{
				syncData.direction = this.characterModule.getDirection();
				this._lastSendedData.direction = syncData.direction;
				hasNewData = true;
			}

			if ( this._lastSendedData.characterState != this.characterModule.getState() )
			{
				syncData.characterState = this.characterModule.getState();
				this._lastSendedData.characterState = syncData.characterState;
				hasNewData = true;
			}

			if ( hasNewData )
			{
				this.webSocketService.sync( syncData );
				this._lastSendedData = syncData;
			}
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