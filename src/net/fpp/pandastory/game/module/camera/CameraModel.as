/**
 * Created by newkrok on 13/10/16.
 */
package net.fpp.pandastory.game.module.camera
{
	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.IModel;

	public class CameraModel extends AModel implements IModel
	{
		public var cameraXPosition:Number = 0;
		public var cameraYPosition:Number = 0;
		public var cameraXEasing:Number = 20;
		public var cameraYEasing:Number = 20;
	}
}