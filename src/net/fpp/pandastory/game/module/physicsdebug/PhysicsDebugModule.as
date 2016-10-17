/**
 * Created by newkrok on 02/10/16.
 */
package net.fpp.pandastory.game.module.physicsdebug
{
	import Box2D.Dynamics.b2DebugDraw;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.constant.CPhysics;
	import net.fpp.pandastory.game.module.physicsdebug.view.PhysicsWorldModuleView;
	import net.fpp.pandastory.game.module.physicsworld.IPhysicsWorldModule;

	import starling.display.DisplayObjectContainer;

	public class PhysicsDebugModule extends AModule implements IPhysicsDebugModule
	{
		[Inject]
		public var physicsWorldModule:IPhysicsWorldModule;

		[Inject(id='worldView')]
		public var worldView:DisplayObjectContainer;

		private var _physicsWorldModuleView:PhysicsWorldModuleView;

		public function PhysicsDebugModule()
		{
			this._physicsWorldModuleView = this.createModuleView( PhysicsWorldModuleView ) as PhysicsWorldModuleView;
		}

		override public function onInited():void
		{
			this.worldView.addChild( this._physicsWorldModuleView );

			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite( this._physicsWorldModuleView.getDebugSprite() );
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

			this._physicsWorldModuleView.update();
		}

		public function getUpdateFrequency():int
		{
			return 200;
		}

		override public function dispose():void
		{
			super.dispose();

			this.physicsWorldModule = null;
			this.worldView = null;
			this._physicsWorldModuleView = null;
		}
	}
}