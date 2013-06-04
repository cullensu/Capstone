package project.menu
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import project.constant.GameRegistry;
	/**
	 * ...
	 * @author akirilov
	 */
	public class PauseMenu extends Menu
	{
		[Embed(source = "../../../assets/pause.png")] protected var PauseTitle:Class;
		[Embed(source = "../../../assets/menuarrow.png")] protected var MenuArrow:Class;
		[Embed(source = "../../../assets/menuboss.png")] protected var MenuBoss:Class;
		[Embed(source = "../../../assets/menucore.png")] protected var MenuCore:Class;
		[Embed(source = "../../../assets/menumove.png")] protected var MenuMove:Class;
		[Embed(source = "../../../assets/menushoot.png")] protected var MenuShoot:Class;
		[Embed(source = "../../../assets/menushow.png")] protected var MenuShow:Class;
		[Embed(source = "../../../assets/pauseresume.png")] protected var PauseResume:Class;
		private var _background:FlxSprite
		
		// Title
		private var menuTitle:FlxSprite;
		// Buttons
		private var menuResume:FlxButton;
		private var menuShow:FlxButton;
		private var menuMute:FlxButton;
		// Arrows
		private var resumeMenuArrow:FlxSprite;
		private var showMenuArrow:FlxSprite;
		// Instructions
		private var menuCore:FlxSprite;
		private var menuBoss:FlxSprite;
		private var menuMove:FlxSprite;
		private var menuShoot:FlxSprite;
		
		private var _selected:uint = 0;
		private static const NEW_GAME:uint = 0;
		private static const SHOW_INSTRUCTIONS:uint = 1;
		
		
		public function PauseMenu() 
		{
			// ##############
			// # BACKGROUND #
			// ##############
			_background = new FlxSprite(0, 0);
			_background.makeGraphic(800, 600, 0xff000000);
			_background.scrollFactor = new FlxPoint(0, 0);
			_background.exists = false;
			add(_background);

			// #########
			// # TITLE #
			// #########
			menuTitle = new FlxSprite(50, 50, PauseTitle);
			menuTitle.scrollFactor = new FlxPoint(0, 0);
			menuTitle.exists = false;
			add(menuTitle);
			
			// ###########
			// # BUTTONS #
			// ###########
			menuResume = new FlxButton(65, 90, null, hide);
			menuResume.loadGraphic(PauseResume);
			menuResume.scrollFactor = new FlxPoint(0, 0);
			menuResume.exists = false;
			add(menuResume);
			
			menuShow = new FlxButton(65, 115, null, showInstructions);
			menuShow.loadGraphic(MenuShow);
			menuShow.scrollFactor = new FlxPoint(0, 0);
			menuShow.exists = false;
			add(menuShow);
			
			menuMute = new FlxButton(700, 20, "Mute", toggleMute);
			menuMute.scrollFactor = new FlxPoint(0, 0);
			menuMute.exists = false;
			add(menuMute);
			
			// ##########
			// # ARROWS #
			// ##########
			resumeMenuArrow = new FlxSprite(50, 90, MenuArrow);
			resumeMenuArrow.scrollFactor = new FlxPoint(0, 0);
			resumeMenuArrow.exists = false;
			add(resumeMenuArrow);
			
			showMenuArrow = new FlxSprite(50, 115, MenuArrow);
			showMenuArrow.scrollFactor = new FlxPoint(0, 0);
			showMenuArrow.exists = false;
			add(showMenuArrow);
			
			// ################
			// # INSTRUCTIONS #
			// ################
			menuCore = new FlxSprite(50, 265, MenuCore);
			menuCore.scrollFactor = new FlxPoint(0, 0);
			menuCore.exists = false;
			add(menuCore);
			
			menuMove = new FlxSprite(300, 50, MenuMove);
			menuMove.scrollFactor = new FlxPoint(0, 0);
			menuMove.exists = false;
			add(menuMove);
			
			menuShoot = new FlxSprite(465, 50, MenuShoot);
			menuShoot.scrollFactor = new FlxPoint(0, 0);
			menuShoot.exists = false;
			add(menuShoot);
			
			menuBoss = new FlxSprite(400, 265, MenuBoss);
			menuBoss.scrollFactor = new FlxPoint(0, 0);
			menuBoss.exists = false;
			add(menuBoss);
		}
		
		private function toggleMute():void 
		{
			FlxG.mute = !FlxG.mute;
		}
		
		private function showInstructions():void 
		{
			menuCore.exists = !menuCore.exists;
			menuMove.exists = !menuMove.exists;
			menuShoot.exists = !menuShoot.exists;
			menuBoss.exists = !menuBoss.exists;
		}
		
		override public function show():void 
		{
			super.show();
			GameRegistry.gameState.paused = true;
			showInstructions();
		}
		
		override public function hide():void 
		{
			super.hide();
			GameRegistry.gameState.paused = false;
		}
		
		override public function update():void 
		{
			if (!FlxG.paused || !GameRegistry.gameState.paused) {
				return;
			}
			super.update();
			if (menuResume.overlapsPoint(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y))) {
				_selected = NEW_GAME;
			} else if (menuShow.overlapsPoint(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y))) {
				_selected = SHOW_INSTRUCTIONS;
			} if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) {
				_selected = Math.max(0, _selected - 1);
			} else if (FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("S")) {
				_selected = Math.min(1, _selected + 1);
			} else if (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) {
				if (_selected == 0) {
					hide();
				} else if (_selected == 1) {
					showInstructions();
				}
			}
			
			if (_selected == 0) {
				resumeMenuArrow.exists = true;
				showMenuArrow.exists = false;
			} else if (_selected == 1) {
				resumeMenuArrow.exists = false;
				showMenuArrow.exists = true;
			}
		}
	}

}