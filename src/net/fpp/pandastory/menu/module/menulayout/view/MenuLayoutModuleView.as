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

		private var _startGameButtonA:DisplayObject;
		private var _startGameButtonB:DisplayObject;

		override protected function onInit():void
		{
			this.getViewObjects();
			this.setPositions();
		}

		private function getViewObjects():void
		{
			this._startGameButtonA = this.viewContainer.getChildByName( 'startGameButtonA' );
			this._startGameButtonB = this.viewContainer.getChildByName( 'startGameButtonB' );
		}

		private function setPositions():void
		{
			this._startGameButtonA.x = this.stage.stageWidth / 2 - this._startGameButtonA.width - 20;
			this._startGameButtonA.y = this.stage.stageHeight / 2 - this._startGameButtonA.height / 2;

			this._startGameButtonB.x = this.stage.stageWidth / 2 + 20;
			this._startGameButtonB.y = this.stage.stageHeight / 2 - this._startGameButtonB.height / 2;
		}
	}
}