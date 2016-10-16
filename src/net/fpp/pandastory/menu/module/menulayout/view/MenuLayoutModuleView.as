/**
 * Created by newkrok on 21/08/16.
 */
package net.fpp.pandastory.menu.module.menulayout.view
{
	import net.fpp.common.starling.module.AModuleView;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class MenuLayoutModuleView extends AModuleView
	{
		public var viewContainer:DisplayObjectContainer;

		private var _startGameButton:DisplayObject;

		override protected function onInit():void
		{
			this.getViewObjects();
			this.setPositions();
		}

		private function getViewObjects():void
		{
			this._startGameButton = this.viewContainer.getChildByName( 'startGameButton' );
		}

		private function setPositions():void
		{
			this._startGameButton.x = this.stage.stageWidth / 2 - this._startGameButton.width / 2;
			this._startGameButton.y = this.stage.stageHeight / 2 - this._startGameButton.height / 2;
		}

	}
}