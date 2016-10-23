/**
 * Created by newkrok on 12/09/16.
 */
package net.fpp.pandastory.game.module.synccharactermodule.view
{
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;

	import net.fpp.common.starling.module.AModel;
	import net.fpp.common.starling.module.AModuleView;
	import net.fpp.pandastory.game.module.character.view.constant.CUnitAnimation;
	import net.fpp.pandastory.game.module.character.view.constant.CUnitBones;
	import net.fpp.pandastory.game.module.synccharactermodule.SyncCharacterModel;

	import starling.display.Image;
	import starling.display.Sprite;

	public class SyncCharacterModuleView extends AModuleView
	{
		private var _characterModel:SyncCharacterModel;

		private var _armature:Armature;
		private var _armatureClip:Sprite;

		private var _currentAnimation:String;

		public function SyncCharacterModuleView()
		{
		}

		override public function setModel( model:AModel ):void
		{
			this._characterModel = model as SyncCharacterModel;

			super.setModel( model );
		}

		public function init():void
		{
			var characterArmature:Armature = this._characterModel.getCharacterAnimationModule().buildArmature( 'character' );
			this.setCharacterAnimation( characterArmature );

			WorldClock.clock.add( characterArmature );

			this.idle();
		}

		public function setCharacterAnimation( value:Armature ):void
		{
			this._armature = value;
			this._armatureClip = this._armature.display as Sprite;

			this.addChild( this._armatureClip );

			this.idle();
		}

		public function updateState():void
		{
			switch( this._characterModel.getState() )
			{
				case CUnitAnimation.IDLE:
					this.idle();
					break;
				case CUnitAnimation.RUN:
					this.run();
					break;
				case CUnitAnimation.JUMP:
					this.jump();
					break;
				case CUnitAnimation.FALL:
					this.fall();
					break;
			}
		}

		public function updateDirection():void
		{
			this._armatureClip.scaleX = this._characterModel.getDirection();
		}

		public function idle():void
		{
			if( this._currentAnimation == CUnitAnimation.IDLE )
			{
				return;
			}

			this._currentAnimation = CUnitAnimation.IDLE;

			this._armature.animation.gotoAndPlay( CUnitAnimation.IDLE, 0, 0, 0 );
		}

		public function run():void
		{
			if( this._currentAnimation == CUnitAnimation.RUN )
			{
				return;
			}

			this._currentAnimation = CUnitAnimation.RUN;

			this._armature.animation.gotoAndPlay( CUnitAnimation.RUN, 0, 0, 0 );
		}

		public function jump():void
		{
			if( this._currentAnimation == CUnitAnimation.JUMP )
			{
				return;
			}

			this._currentAnimation = CUnitAnimation.JUMP;

			this._armature.animation.gotoAndPlay( CUnitAnimation.JUMP, 0, 0 );
		}

		public function fall():void
		{
			if( this._currentAnimation == CUnitAnimation.FALL )
			{
				return;
			}

			this._currentAnimation = CUnitAnimation.FALL;

			this._armature.animation.gotoAndPlay( CUnitAnimation.FALL, 0, 0 );
		}

		public function updateSkin():void
		{
			this.setHeadSkin( this._characterModel.getCharacterVO().headSkin );
			this.setBodySkin( this._characterModel.getCharacterVO().bodySkin );
			this.setArmSkin( this._characterModel.getCharacterVO().armSkin );
			this.setLegSkin( this._characterModel.getCharacterVO().legSkin );
		}

		private function setHeadSkin( name:String ):void
		{
			var newHead:Image = this._characterModel.getCharacterAnimationModule().getTextureDisplay( name ) as Image;

			var bone:Bone = this._armature.getBone( CUnitBones.HEAD );
			bone.display.dispose();
			bone.display = newHead;
		}

		private function setBodySkin( name:String ):void
		{
			var newBody:Image = this._characterModel.getCharacterAnimationModule().getTextureDisplay( name ) as Image;

			var bone:Bone = this._armature.getBone( CUnitBones.BODY );
			bone.display.dispose();
			bone.display = newBody;
		}

		private function setArmSkin( name:String ):void
		{
			var newArm:Image = this._characterModel.getCharacterAnimationModule().getTextureDisplay( name ) as Image;

			var bone:Bone = this._armature.getBone( CUnitBones.ARM_FRONT );
			bone.display.dispose();
			bone.display = newArm;

			newArm = this._characterModel.getCharacterAnimationModule().getTextureDisplay( name ) as Image;

			bone = this._armature.getBone( CUnitBones.ARM_BACK );
			bone.display.dispose();
			bone.display = newArm;
		}

		private function setLegSkin( name:String ):void
		{
			var newLeg:Image = this._characterModel.getCharacterAnimationModule().getTextureDisplay( name ) as Image;

			var bone:Bone = this._armature.getBone( CUnitBones.LEG_FRONT );
			bone.display.dispose();
			bone.display = newLeg;

			newLeg = this._characterModel.getCharacterAnimationModule().getTextureDisplay( name ) as Image;

			bone = this._armature.getBone( CUnitBones.LEG_BACK );
			bone.display.dispose();
			bone.display = newLeg;
		}

		private function disposeArmature():void
		{
			WorldClock.clock.remove( this._armature );

			this._armature.dispose();
			this._armature = null;

			this.removeChild( this._armatureClip );
			this._armatureClip.dispose();
			this._armatureClip = null;
		}

		override public function dispose():void
		{
			if( this._armature )
			{
				this.disposeArmature();
			}

			super.dispose();
		}
	}
}