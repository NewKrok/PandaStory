/**
 * Created by newkrok on 13/10/16.
 */
package net.fpp.pandastory.game.module.terrain.view
{
	import flash.geom.Rectangle;

	import net.fpp.common.starling.StaticAssetManager;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.pandastory.constant.CSkinId;

	import starling.display.Image;

	public class TerrainModuleView extends AModuleView
	{
		public function TerrainModuleView()
		{
		}

		public function drawStaticTerrains( terrains:Vector.<Rectangle> ):void
		{
			for( var i:int = 0; i < terrains.length; i++ )
			{
				var image:Image = new Image( StaticAssetManager.instance.getTexture( CSkinId.TERRAIN_A ) );

				image.textureRepeat = true;
				image.tileGrid = new Rectangle( 0, 0, image.texture.width, image.texture.height );
				image.pixelSnapping = true;

				image.width = terrains[ i ].width * 2;
				image.height = terrains[ i ].height * 2;
				image.x = terrains[ i ].x - terrains[ i ].width;
				image.y = terrains[ i ].y - terrains[ i ].height;

				this.addChild( image );
			}
		}
	}
}