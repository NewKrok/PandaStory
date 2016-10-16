/**
 * Created by newkrok on 02/10/16.
 */
package net.fpp.pandastory.asset
{
	import flash.utils.ByteArray;

	public class CharacterAssets
	{
		[Embed(source = "../../../../../asset/texture/characters.png", mimeType = "application/octet-stream")]
		private static const CharacterAssetsData:Class;

		public static function getCharacterAssetsObject():ByteArray
		{
			return new CharacterAssetsData();
		}
	}
}