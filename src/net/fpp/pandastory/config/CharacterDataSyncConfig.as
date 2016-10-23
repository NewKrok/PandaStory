/**
 * Created by newkrok on 20/10/16.
 */
package net.fpp.pandastory.config
{
	import flash.utils.Dictionary;

	import net.fpp.pandastory.game.module.character.view.constant.CUnitAnimation;

	public class CharacterDataSyncConfig
	{
		private var _syncOptimizationConfig:Dictionary;

		public function CharacterDataSyncConfig():void
		{
			this._syncOptimizationConfig = new Dictionary();
			this._syncOptimizationConfig[ 'x' ] = 'x';
			this._syncOptimizationConfig[ 'y' ] = 'y';

			this._syncOptimizationConfig[ 'direction' ] = 'd';
			this._syncOptimizationConfig[ 'd' ] = 'direction';

			this._syncOptimizationConfig[ 'characterState' ] = 'c';
			this._syncOptimizationConfig[ 'c' ] = 'characterState';
		}

		public function getSyncKeyConfig():Dictionary
		{
			return this._syncOptimizationConfig;
		}
	}
}