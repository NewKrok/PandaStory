/**
 * Created by newkrok on 02/10/16.
 */
package net.fpp.pandastory.game.module.physicsdebug.view
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import net.fpp.common.starling.module.AModuleView;

	import starling.display.Image;
	import starling.textures.Texture;

	public class PhysicsWorldModuleView extends AModuleView
	{
		private var _debugSprite:Sprite;

		private var _debugBitmapData:BitmapData;

		private var _debugImage:Image;

		public function PhysicsWorldModuleView()
		{
			this.touchable = false;

			this._debugSprite = new Sprite();
		}

		override protected function onInit():void
		{
			this._debugBitmapData = new BitmapData( this.stage.stageWidth, this.stage.stageHeight, true, 0x60 );

			this._debugImage = new Image( Texture.fromBitmapData( this._debugBitmapData ) );
			this.addChild( this._debugImage );
		}

		public function getDebugSprite():Sprite
		{
			return this._debugSprite;
		}

		public function update():void
		{
			this._debugBitmapData.fillRect( new Rectangle( 0, 0, this._debugBitmapData.width, this._debugBitmapData.height ), 0x60 );

			this._debugBitmapData.draw( this._debugSprite );

			this._debugImage.texture = Texture.fromBitmapData( this._debugBitmapData );
		}
	}
}