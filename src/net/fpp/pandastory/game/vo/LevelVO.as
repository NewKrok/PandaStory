/**
 * Created by newkrok on 11/09/16.
 */
package net.fpp.pandastory.game.vo
{
	import net.fpp.common.geom.SimplePoint;

	public class LevelVO
	{
		public var terrain:Vector.<TerrainVO>;
		public var movingPlatform:Vector.<MovingPlatformVO>;
		public var startPoint:SimplePoint;
	}
}