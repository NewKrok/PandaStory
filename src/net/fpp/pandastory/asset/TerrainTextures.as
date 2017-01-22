/**
 * Created by newkrok on 22/02/16.
 */
package net.fpp.pandastory.asset
{
	public class TerrainTextures
	{
		[Embed(source="../../../../../asset/texture/terrain_textures.png")]
		public static const AtlasImage:Class;

		[Embed(source="../../../../../asset/texture/terrain_textures.json", mimeType='application/octet-stream')]
		public static const AtlasDescription:Class;
	}
}