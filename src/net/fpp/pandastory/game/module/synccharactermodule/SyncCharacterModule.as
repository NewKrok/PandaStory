/**
 * Created by newkrok on 16/10/16.
 */
package net.fpp.pandastory.game.module.synccharactermodule
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.game.module.characteranimation.ICharacterAnimationModule;
	import net.fpp.pandastory.game.module.synccharactermodule.view.SyncCharacterModuleView;

	public class SyncCharacterModule extends AModule implements ISyncCharacterModule
	{
		[Inject]
		public var characterAnimationModule:ICharacterAnimationModule;

		private var _syncCharacterModuleView:SyncCharacterModuleView;
		private var _syncCharacterModel:SyncCharacterModel;

		public function SyncCharacterModule()
		{
			this._syncCharacterModuleView = this.createModuleView( SyncCharacterModuleView ) as SyncCharacterModuleView;
			this._syncCharacterModel = this.createModel( SyncCharacterModel ) as SyncCharacterModel;
		}

		override public function onInited():void
		{
			this._syncCharacterModel.setCharacterAnimationModule( this.characterAnimationModule );

			this._syncCharacterModuleView.init();
		}

		public function setCharacterDirection( value:int ):void
		{
			if( this._syncCharacterModel.getDirection() != value )
			{
				this._syncCharacterModel.setDirection( value );

				this._syncCharacterModuleView.updateDirection();
			}
		}

		public function setCharacterState( value:String ):void
		{
			if( this._syncCharacterModel.getState() != value )
			{
				this._syncCharacterModel.setState( value );

				this._syncCharacterModuleView.updateState();
			}
		}

		public function setPosition( x:Number, y:Number ):void
		{
			this._syncCharacterModuleView.x = x;
			this._syncCharacterModuleView.y = y;
		}
	}
}