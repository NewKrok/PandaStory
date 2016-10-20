/**
 * Created by newkrok on 20/10/16.
 */
package net.fpp.pandastory.config.level
{
	import flash.geom.Rectangle;

	import net.fpp.pandastory.constant.CTerrainType;
	import net.fpp.pandastory.game.vo.LevelVO;
	import net.fpp.pandastory.game.vo.TerrainVO;

	public class Level1VO extends LevelVO
	{
		public function Level1VO()
		{
			this.terrain = new <TerrainVO>[
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 0, 290, 400, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 300, 225, 20, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 30, 150, 100, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 250, 400, 170, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 650, 350, 150, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 750, 270, 150, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 900, 180, 100, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 700, 155, 20, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 600, 120, 20, 16 ) ),
				new TerrainVO( CTerrainType.NORMAL, new Rectangle( 780, 30, 20, 16 ) )
			]
		}
	}
}