/**
 * Created by newkrok on 26/07/16.
 */
package net.fpp.pandastory.game
{
	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.module.AApplicationContext;
	import net.fpp.pandastory.asset.CommonAssets;
	import net.fpp.pandastory.config.CharacterDataSyncConfig;
	import net.fpp.pandastory.config.level.Level1VO;
	import net.fpp.pandastory.constant.CSkinId;
	import net.fpp.pandastory.game.events.GameMainEvent;
	import net.fpp.pandastory.game.handler.CharacterAnimationLoadedHandler;
	import net.fpp.pandastory.game.handler.OnApplicationReady;
	import net.fpp.pandastory.game.handler.OnPlayerJoinedHandler;
	import net.fpp.pandastory.game.handler.WebSocketConnectedHandler;
	import net.fpp.pandastory.game.handler.WebSocketSyncHandler;
	import net.fpp.pandastory.game.module.camera.CameraModule;
	import net.fpp.pandastory.game.module.camera.ICameraModule;
	import net.fpp.pandastory.game.module.character.CharacterModule;
	import net.fpp.pandastory.game.module.character.ICharacterModule;
	import net.fpp.pandastory.game.module.characteranimation.CharacterAnimationModule;
	import net.fpp.pandastory.game.module.characteranimation.ICharacterAnimationModule;
	import net.fpp.pandastory.game.module.charactercontroller.CharacterControllerModule;
	import net.fpp.pandastory.game.module.charactercontroller.ICharacterControllerModule;
	import net.fpp.pandastory.game.module.multiplayersync.IMultiPlayerSyncModule;
	import net.fpp.pandastory.game.module.multiplayersync.MultiPlayerSyncModule;
	import net.fpp.pandastory.game.module.physicsworld.IPhysicsWorldModule;
	import net.fpp.pandastory.game.module.physicsworld.PhysicsWorldModule;
	import net.fpp.pandastory.game.module.synccharactermodule.ISyncCharacterModule;
	import net.fpp.pandastory.game.module.synccharactermodule.SyncCharacterModule;
	import net.fpp.pandastory.game.module.terrain.ITerrainModule;
	import net.fpp.pandastory.game.module.terrain.TerrainModule;
	import net.fpp.pandastory.game.service.websocketservice.IWebSocketService;
	import net.fpp.pandastory.game.service.websocketservice.WebSocketService;
	import net.fpp.pandastory.game.vo.LevelVO;

	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameMain extends AApplicationContext implements IGameMain
	{
		private var _background:Image;

		private var _characterDataSyncConfig:CharacterDataSyncConfig;

		private var _worldView:Sprite;
		private var _guiView:Sprite;

		public function GameMain()
		{
			super();

			this._characterDataSyncConfig = new CharacterDataSyncConfig();

			this.injector.mapToValue( IGameMain, this );

			this.injector.mapToValue( LevelVO, new Level1VO() );

			this.addChild( this._worldView = new Sprite() );
			this.injector.mapToValue( DisplayObjectContainer, this._worldView, 'worldView' );

			this.addChild( this._guiView = new Sprite() );
			this.injector.mapToValue( DisplayObjectContainer, this._guiView, 'guiView' );

			this.loadStarlingAssets();
		}

		private function loadStarlingAssets():void
		{
			StaticAssetManager.instance.enqueue( CommonAssets );
			StaticAssetManager.instance.loadQueue( this.onAssetsLoadProgress );
		}

		private function onAssetsLoadProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				this.createCharacterAnimation();
			}
		}

		private function createCharacterAnimation():void
		{
			this.createModule( '', CharacterAnimationModule, ICharacterAnimationModule );
			this.createHandler( CharacterAnimationLoadedHandler );
		}

		public function onCharacterAnimationLoaded():void
		{
			this.disposeHandlerByClass( CharacterAnimationLoadedHandler );

			this.connectToServer();
		}

		private function connectToServer():void
		{
			var webSocketService:IWebSocketService = this.createService( '', WebSocketService, IWebSocketService, [ this._characterDataSyncConfig ] ) as IWebSocketService;

			this.createHandler( WebSocketConnectedHandler );

			webSocketService.connect();
		}

		public function onWebSocketConnected():void
		{
			this.disposeHandlerByClass( WebSocketConnectedHandler );

			this.build();

			this.createHandler( WebSocketSyncHandler );
		}

		private function build():void
		{
			this.createBackground();

			this.createModule( '', PhysicsWorldModule, IPhysicsWorldModule );
			this.createModule( '', TerrainModule, ITerrainModule );
			this.createModule( '', CharacterModule, ICharacterModule );
			this.createModule( '', SyncCharacterModule, ISyncCharacterModule );
			//this.createModule( '', PhysicsDebugModule, IPhysicsDebugModule )
			this.createModule( '', CharacterControllerModule, ICharacterControllerModule );
			this.createModule( '', CameraModule, ICameraModule );
			this.createModule( '', MultiPlayerSyncModule, IMultiPlayerSyncModule, [ this._characterDataSyncConfig ] );

			this.registerHandlers();

			this.startUpdateHandling();
		}

		private function createBackground():void
		{
			this._background = new Image( StaticAssetManager.instance.getTexture( CSkinId.GAME_BACKGROUND_WORLD_0_PART_0 ) );

			this.addChildAt( this._background, 0 );
		}

		private function registerHandlers():void
		{
			this.registerHandler( new OnPlayerJoinedHandler() );
			this.registerHandler( new OnApplicationReady() );
		}

		override public function dispose():void
		{
			this._background.removeFromParent( true );
			this._background = null;

			this._worldView.removeFromParent( true );
			this._worldView = null;

			this._guiView.removeFromParent( true );
			this._guiView = null;

			super.dispose();

			//StaticAssetManager.instance.removeTextureAtlas( 'atlas_common' );
			//StaticAssetManager.instance.removeXml( 'atlas_common_xml' );

			this.dispatchEventWith( GameMainEvent.DISPOSED );
		}
	}
}