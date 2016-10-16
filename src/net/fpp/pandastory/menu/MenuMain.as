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
	import starling.display.Image;
	import starling.display.Sprite;

	public class MenuMain extends AApplicationContext
	{
		private var _background:Image;

		private var _startGameButton:Button;

		public function MenuMain()
		{
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

			this.createModule( '', MenuLayoutModule, IMenuLayoutModule, [ this._view ] );

			this.registerHandlers();
		}

		private function createBackground():void
		{
			this._background = new Image( StaticAssetManager.instance.getTexture( CSkinId.MENU_BACKGROUND ) );
			this._background.x = stage.stageWidth / 2 - this._background.width / 2;
			this._background.y = stage.stageHeight / 2 - this._background.height / 2;

			this._view.addChild( this._background );
		}

		private function createUI():void
		{
			this._startGameButton = new Button( StaticAssetManager.instance.getTexture( CSkinId.START_GAME_BUTTON ) );
			this._startGameButton.name = 'startGameButton';

			this._view.addChild( this._startGameButton );
		}

		private function registerHandlers():void
		{
			this.registerHandler( new StartGameHandler( this._startGameButton ) );
		}

		override public function dispose():void
		{
			this._background.removeFromParent( true );
			this._background = null;

			this._startGameButton.removeFromParent( true );
			this._startGameButton = null;

			super.dispose();

			//StaticAssetManager.instance.removeTextureAtlas( 'atlas_menu' );
			//StaticAssetManager.instance.removeXml( 'atlas_menu_xml' );

			this.dispatchEventWith( MenuMainEvent.DISPOSED );
		}
	}
}