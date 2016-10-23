/**
 * Created by newkrok on 26/07/16.
 */
package net.fpp.pandastory.menu
{
	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.module.AApplicationContext;
	import net.fpp.pandastory.asset.CommonAssets;
	import net.fpp.pandastory.constant.CSkinId;
	import net.fpp.pandastory.menu.events.MenuMainEvent;
	import net.fpp.pandastory.menu.handler.StartGameHandler;
	import net.fpp.pandastory.menu.module.menulayout.IMenuLayoutModule;
	import net.fpp.pandastory.menu.module.menulayout.MenuLayoutModule;

	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;

	public class MenuMain extends AApplicationContext
	{
		private var _background:Image;

		private var _startGameButtonA:Button;
		private var _startGameButtonB:Button;

		private var _guiView:Sprite;

		public function MenuMain()
		{
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
				this.build();
			}
		}

		private function build():void
		{
			this.createBackground();

			this.createUI();

			this.createModule( '', MenuLayoutModule, IMenuLayoutModule, [ this._guiView ] );

			this.registerHandlers();
		}

		private function createBackground():void
		{
			this._background = new Image( StaticAssetManager.instance.getTexture( CSkinId.MENU_BACKGROUND ) );
			this._background.x = stage.stageWidth / 2 - this._background.width / 2;
			this._background.y = stage.stageHeight / 2 - this._background.height / 2;

			this._guiView.addChild( this._background );
		}

		private function createUI():void
		{
			this._startGameButtonA = new Button( StaticAssetManager.instance.getTexture( CSkinId.START_GAME_BUTTON ) );
			this._startGameButtonA.name = 'startGameButtonA';
			this._guiView.addChild( this._startGameButtonA );

			this._startGameButtonB = new Button( StaticAssetManager.instance.getTexture( CSkinId.START_GAME_BUTTON ) );
			this._startGameButtonB.name = 'startGameButtonB';
			this._guiView.addChild( this._startGameButtonB );
		}

		private function registerHandlers():void
		{
			this.registerHandler( new StartGameHandler( this._startGameButtonA, this._startGameButtonB ) );
		}

		override public function dispose():void
		{
			this._background.removeFromParent( true );
			this._background = null;

			this._startGameButtonA.removeFromParent( true );
			this._startGameButtonA = null;

			this._startGameButtonB.removeFromParent( true );
			this._startGameButtonB = null;

			this._guiView.removeFromParent( true );
			this._guiView = null;

			super.dispose();

			//StaticAssetManager.instance.removeTextureAtlas( 'atlas_menu' );
			//StaticAssetManager.instance.removeXml( 'atlas_menu_xml' );

			this.dispatchEventWith( MenuMainEvent.DISPOSED );
		}
	}
}