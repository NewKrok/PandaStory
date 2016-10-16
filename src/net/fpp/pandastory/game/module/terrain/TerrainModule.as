/**
 * Created by newkrok on 13/10/16.
 */
package net.fpp.pandastory.game.module.terrain
{
	import flash.geom.Rectangle;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.game.module.physicsworld.vo.LevelDataVO;
	import net.fpp.pandastory.game.module.terrain.view.TerrainModuleView;

	public class TerrainModule extends AModule implements ITerrainModule
	{
		[Inject]
		public var levelDataVO:LevelDataVO;

		private var _terrainModuleView:TerrainModuleView;

		public function TerrainModule()
		{
			this._terrainModuleView = this.createModuleView( TerrainModuleView ) as TerrainModuleView;
		}

		override public function onInited():void
		{
			this._terrainModuleView.drawStaticTerrains( this.levelDataVO.terrains );
		}
	}
}