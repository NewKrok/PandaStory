/**
 * Created by newkrok on 13/10/16.
 */
package net.fpp.pandastory.game.module.camera
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.game.module.character.ICharacterModule;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class CameraModule extends AModule implements ICameraModule
	{
		[Inject(id='worldView')]
		public var worldView:DisplayObjectContainer;

		[Inject]
		public var characterModule:ICharacterModule;

		private var cameraModel:CameraModel;

		public function CameraModule()
		{
			this.cameraModel = this.createModel( CameraModel ) as CameraModel;
		}

		public function onUpdate():void
		{
			var characterView:DisplayObject = characterModule.getView();

			var cameraFinalX:Number = -characterView.x + this.worldView.stage.stageWidth / 2;
			var cameraFinalY:Number = -characterView.y + this.worldView.stage.stageHeight / 2;

			this.cameraModel.cameraXPosition += ( cameraFinalX - this.cameraModel.cameraXPosition ) / this.cameraModel.cameraXEasing;
			this.cameraModel.cameraYPosition += ( cameraFinalY - this.cameraModel.cameraYPosition ) / this.cameraModel.cameraYEasing;

			worldView.x = this.cameraModel.cameraXPosition;
			worldView.y = this.cameraModel.cameraYPosition;
		}

		public function getUpdateFrequency():int
		{
			return 0;
		}
	}
}