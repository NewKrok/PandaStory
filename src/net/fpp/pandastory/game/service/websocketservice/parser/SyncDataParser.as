/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.service.websocketservice.parser
{
	import net.fpp.common.starling.module.IParser;
	import net.fpp.pandastory.game.service.websocketservice.vo.CharacterModuleSyncDataVO;

	public class SyncDataParser implements IParser
	{
		public function parse( rawData:Object ):Object
		{
			var characterModuleSyncDataVO:CharacterModuleSyncDataVO = new CharacterModuleSyncDataVO();

			for( var key:String in rawData )
			{
				characterModuleSyncDataVO[ key ] = rawData[ key ];
			}

			return characterModuleSyncDataVO;
		}
	}
}