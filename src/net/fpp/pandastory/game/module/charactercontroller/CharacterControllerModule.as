/**
 * Created by newkrok on 12/09/16.
 */
package net.fpp.pandastory.game.module.charactercontroller
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.game.module.character.ICharacterModule;
	import net.fpp.pandastory.game.module.character.constant.CCharacterDirection;
	import net.fpp.pandastory.game.module.character.constant.CCharacterState;
	import net.fpp.pandastory.game.module.charactercontroller.view.CharacterControllerModuleView;

	public class CharacterControllerModule extends AModule implements ICharacterControllerModule
	{
		[Inject]
		public var characterModule:ICharacterModule;

		private var _characterControllerModuleView:CharacterControllerModuleView;
		private var _characterControllerModel:CharacterControllerModel;

		public function CharacterControllerModule()
		{
			this._characterControllerModuleView = this.createModuleView( CharacterControllerModuleView ) as CharacterControllerModuleView;
			this._characterControllerModel = this.createModel( CharacterControllerModel ) as CharacterControllerModel;
		}

		override public function onInited():void
		{
			this._view.stage.addChild( this._view );
		}

		public function onUpdate():void
		{
			if( this.characterModule.getIsOnGround() )
			{
				this.updateCharacterOnGround();
			}
			else
			{
				this.updateCharacterOnAir();
			}
		}

		private function updateCharacterOnGround():void
		{
			var characterPhysicsObject:b2Body = this.characterModule.getCharacterPhysicsObject();
			var currentVelocity:b2Vec2 = characterPhysicsObject.GetLinearVelocity();

			var maxSpeed:Number = 7;
			var acceleration:Number = .6;
			var deceleration:Number = .6;
			var jumpPower:Number = 35;
			var maxJumpTime:Number = 100;

			if( this._characterControllerModel.isRightActive )
			{
				if( currentVelocity.x < maxSpeed )
				{
					currentVelocity.x += acceleration;
					this.characterModule.setDirection( CCharacterDirection.RIGHT );
				}
				this.characterModule.setState( CCharacterState.RUN );
			}
			else if( this._characterControllerModel.isLeftActive )
			{
				if( currentVelocity.x > -maxSpeed )
				{
					currentVelocity.x -= acceleration;
					this.characterModule.setDirection( CCharacterDirection.LEFT );
				}
				this.characterModule.setState( CCharacterState.RUN );
			}
			else
			{
				this.characterModule.setState( CCharacterState.IDLE );
			}

			if( currentVelocity.x > 0 )
			{
				currentVelocity.x = Math.min( currentVelocity.x, maxSpeed );
			}
			else
			{
				currentVelocity.x = Math.max( currentVelocity.x, -maxSpeed );
			}

			if( !this._characterControllerModel.isRightActive && !this._characterControllerModel.isLeftActive )
			{
				currentVelocity.x *= deceleration;
			}

			characterPhysicsObject.SetLinearVelocity( currentVelocity );

			if( this._characterControllerModel.isJumpActive )
			{
				var now:Number = new Date().time;

				if( ( !this._characterControllerModel.isJumpTriggered && this.characterModule.getIsOnGround() ) || ( this._characterControllerModel.isJumpTriggered && now - this._characterControllerModel.jumpActivateTime < maxJumpTime ) )
				{
					if( !this._characterControllerModel.isJumpTriggered )
					{
						this._characterControllerModel.jumpActivateTime = now;

						this._characterControllerModel.isJumpTriggered = true;
					}
				}

				characterPhysicsObject.ApplyForce( new b2Vec2( 0, -jumpPower ), characterPhysicsObject.GetWorldCenter() );
			}
			else
			{
				this._characterControllerModel.isJumpTriggered = false;
			}
		}

		private function updateCharacterOnAir():void
		{
			var characterPhysicsObject:b2Body = this.characterModule.getCharacterPhysicsObject();
			var currentVelocity:b2Vec2 = characterPhysicsObject.GetLinearVelocity();

			var maxSpeedOnAir:Number = 5;
			var acceleration:Number = .3;
			var deceleration:Number = .6;

			if( this._characterControllerModel.isRightActive )
			{
				if( currentVelocity.x < maxSpeedOnAir )
				{
					currentVelocity.x += acceleration;
					this.characterModule.setDirection( CCharacterDirection.RIGHT );
				}
				this.characterModule.setState( CCharacterState.RUN );
			}
			else if( this._characterControllerModel.isLeftActive )
			{
				if( currentVelocity.x > -maxSpeedOnAir )
				{
					currentVelocity.x -= acceleration;
					this.characterModule.setDirection( CCharacterDirection.LEFT );
				}
				this.characterModule.setState( CCharacterState.RUN );
			}

			if( !this._characterControllerModel.isRightActive && !this._characterControllerModel.isLeftActive )
			{
				currentVelocity.x *= deceleration;
			}

			if( currentVelocity.x > 0 )
			{
				currentVelocity.x = Math.min( currentVelocity.x, maxSpeedOnAir );
			}
			else
			{
				currentVelocity.x = Math.max( currentVelocity.x, -maxSpeedOnAir );
			}

			if( currentVelocity.y > 0 )
			{
				this.characterModule.setState( CCharacterState.FALL );
			}
			else
			{
				this.characterModule.setState( CCharacterState.JUMP );
			}

			characterPhysicsObject.SetLinearVelocity( currentVelocity );
		}

		public function getUpdateFrequency():int
		{
			return 0;
		}
	}
}