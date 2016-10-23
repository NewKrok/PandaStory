/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.module.multiplayersync
{
	import flash.utils.Dictionary;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.config.CharacterDataSyncConfig;
	import net.fpp.pandastory.game.module.character.ICharacterModule;
	import net.fpp.pandastory.game.service.websocketservice.IWebSocketService;

	import starling.display.DisplayObject;

	public class MultiPlayerSyncModule extends AModule implements IMultiPlayerSyncModule
	{
		[Inject]
		public var webSocketService:IWebSocketService;

		[Inject]
		public var characterModule:ICharacterModule;

		private var _lastSendedData:Object;

		private var _syncKeys:Dictionary;

		public function MultiPlayerSyncModule( characterDataSyncConfig:CharacterDataSyncConfig )
		{
			this._lastSendedData = {x: -1, y: -1, direction: 0, characterState: ''};

			this._syncKeys = characterDataSyncConfig.getSyncKeyConfig();
		}

		public function onUpdate():void
		{
			var characterView:DisplayObject = this.characterModule.getView();

			var syncData:Object = new Object;
			var hasNewData:Boolean = false;

			if( this._lastSendedData.x != Math.round( characterView.x ) )
			{
				syncData.x = Math.round( characterView.x );
				hasNewData = true;
			}

			if( this._lastSendedData.y != Math.round( characterView.y ) )
			{
				syncData.y = Math.round( characterView.y );
				hasNewData = true;
			}

			if( this._lastSendedData.direction != this.characterModule.getDirection() )
			{
				syncData.direction = this.characterModule.getDirection();
				hasNewData = true;
			}

			if( this._lastSendedData.characterState != this.characterModule.getState() )
			{
				syncData.characterState = this.characterModule.getState();
				hasNewData = true;
			}

			if( hasNewData )
			{
				var convertedSyncData:Object = {};
				for( var key:String in syncData )
				{
					if( syncData[ key ] )
					{
						this._lastSendedData[ key ] = syncData[ key ];
						convertedSyncData[ this._syncKeys[ key ] ] = syncData[ key ];
					}
				}

				this.webSocketService.sync( convertedSyncData );
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