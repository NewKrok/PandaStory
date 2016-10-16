/**
 * Created by newkrok on 02/10/16.
 */
package net.fpp.pandastory.game.module.physicsdebug
{
	import Box2D.Dynamics.b2DebugDraw;

	import flash.display.Sprite;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.constant.CPhysics;
	import net.fpp.pandastory.game.module.physicsdebug.view.PhysicsWorldModuleView;
	import net.fpp.pandastory.game.module.physicsworld.IPhysicsWorldModule;

	public class PhysicsDebugModule extends AModule implements IPhysicsDebugModule
	{
		[Inject]
		public var physicsWorldModule:IPhysicsWorldModule;

		private var physicsWorldModuleView:PhysicsWorldModuleView;

		public function PhysicsDebugModule()
		{
			this.physicsWorldModuleView = this.createModuleView( PhysicsWorldModuleView ) as PhysicsWorldModuleView;
		}

		override public function onInited():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite( this.physicsWorldModuleView.getDebugSprite() );
			debugDraw.SetDrawScale( CPhysics.PIXELS_TO_METRE );
			debugDraw.SetLineThickness( .5 );
			debugDraw.SetAlpha( .5 );
			debugDraw.SetFillAlpha( .2 );
			debugDraw.SetFlags( b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit );

			this.physicsWorldModule.setDebugDraw( debugDraw );
		}

		public function onUpdate():void
		{
			this.physicsWorldModule.drawDebugData();

			this.physicsWorldModuleView.update();
		}

		public function getUpdateFrequency():int
		{
			return 200;
		}
	}
}