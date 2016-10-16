/**
 * Created by newkrok on 21/08/16.
 */
package net.fpp.pandastory.menu.module.menulayout
{
	import net.fpp.common.starling.module.AModule;
	import net.fpp.pandastory.menu.module.menulayout.view.MenuLayoutModuleView;

	import starling.display.DisplayObjectContainer;

	public class MenuLayoutModule extends AModule implements IMenuLayoutModule
	{
		private var _menuLayoutModuleView:MenuLayoutModuleView;

		public function MenuLayoutModule( viewContainer:DisplayObjectContainer )
		{
			this._menuLayoutModuleView = this.createModuleView( MenuLayoutModuleView ) as MenuLayoutModuleView;

			this._menuLayoutModuleView.viewContainer = viewContainer;
		}
	}
}