/**
 * Created by newkrok on 23/10/16.
 */
package net.fpp.pandastory.game.handler
{
	import net.fpp.common.starling.module.IHandler;
	import net.fpp.pandastory.game.module.character.ICharacterModule;
	import net.fpp.pandastory.game.vo.LevelVO;
	import net.fpp.pandastory.vo.PlayerInfoVO;

	public class OnApplicationReady implements IHandler
	{
		[Inject]
		public var characterModule:ICharacterModule;

		[Inject]
		public var levelVO:LevelVO;

		[Inject]
		public var playerInfoVO:PlayerInfoVO;

		public function onInited():void
		{
			this.characterModule.setPosition( levelVO.startPoint );
			this.characterModule.setCharacterVO( playerInfoVO.characterVO );
		}

		public function dispose():void
		{
			this.characterModule = null;

			this.levelVO = null;
		}
	}
}