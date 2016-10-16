/**
 * Created by newkrok on 26/07/16.
 */
package net.fpp.pandastory
{
	import net.fpp.common.language.StaticLanguageUtil;
	import net.fpp.pandastory.asset.LanguageData;
	import net.fpp.pandastory.game.GameMain;
	import net.fpp.pandastory.game.events.GameMainEvent;
	import net.fpp.pandastory.menu.MenuMain;
	import net.fpp.pandastory.menu.events.MenuMainEvent;

	import starling.display.Sprite;
	import starling.events.Event;

	public class MainDomain extends Sprite
	{
		private var _menuMain:MenuMain;
		private var _gameMain:GameMain;

		public function MainDomain()
		{
			StaticLanguageUtil.instance.setLanguageDataFromObjectVector( new LanguageData().languageData );
		}

		public function start():void
		{
			this.createMenu();
		}

		private function createMenu():void
		{
			this._menuMain = new MenuMain();
			this._menuMain.addEventListener( MenuMainEvent.DISPOSED, this.onMenuMainRequest );

			this.addChild( this._menuMain );
		}

		private function onMenuMainRequest( e:Event ):void
		{
			this._menuMain.removeEventListener( MenuMainEvent.DISPOSED, this.onMenuMainRequest );
			this._menuMain = null;

			this.createGame();
		}

		private function createGame():void
		{
			this._gameMain = new GameMain();
			this._gameMain.addEventListener( GameMainEvent.DISPOSED, this.onGameMainDisposed );

			this.addChild( this._gameMain );
		}

		private function onGameMainDisposed( e:Event ):void
		{
			this._gameMain.removeEventListener( GameMainEvent.DISPOSED, this.onGameMainDisposed );
			this._gameMain = null;

			this.createMenu();
		}
	}
}