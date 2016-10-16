/**
 * Created by newkrok on 21/08/16.
 */
package net.fpp.pandastory.menu.handler
{
	import net.fpp.common.starling.module.AHandler;
	import net.fpp.common.starling.module.IApplicationContext;

	import starling.display.Button;
	import starling.events.Event;

	public class StartGameHandler extends AHandler
	{
		[Inject]
		public var applicationContext:IApplicationContext;

		private var _startGameButton:Button;

		public function StartGameHandler( startGameButton:Button )
		{
			this._startGameButton = startGameButton;

			this._startGameButton.addEventListener( Event.TRIGGERED, this.onStartGameButtonTriggered );
		}

		private function onStartGameButtonTriggered( e:Event ):void
		{
			this.applicationContext.dispose();
		}

		override public function dispose():void
		{
			this._startGameButton.removeEventListener( Event.TRIGGERED, this.onStartGameButtonTriggered );
			this._startGameButton = null;

			this.applicationContext = null;
		}
	}
}