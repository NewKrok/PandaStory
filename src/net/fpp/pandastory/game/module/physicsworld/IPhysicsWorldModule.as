/**
 * Created by newkrok on 15/08/16.
 */
package net.fpp.pandastory.game.module.physicsworld
{
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;

	import flash.geom.Rectangle;

	import net.fpp.common.starling.module.IUpdatableModule;
	import net.fpp.pandastory.game.module.physicsworld.vo.LevelDataVO;

	public interface IPhysicsWorldModule extends IUpdatableModule
	{
		function createDynamicsRectangle( rectangle:Rectangle, friction:Number = 1, density:Number = 1, isFixedRotation:Boolean = false ):b2Body;

		function createDynamicsCircle( x:Number, y:Number, radius:Number, friction:Number = 1, density:Number = 1, isFixedRotation:Boolean = false ):b2Body;

		function createJoint( jointDefinition:b2JointDef ):b2Joint;

		function setDebugDraw( value:b2DebugDraw ):void;

		function drawDebugData():void;
	}
}