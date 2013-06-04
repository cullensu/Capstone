package project.state 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import project.constant.Constants;
	import project.constant.GameRegistry;
	import project.replay.InputText;
	import project.replay.ReplayHandler;
	/**
	 * ...
	 * @author Cullen
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = "../../../assets/menuarrow.png")] protected var MenuArrow:Class;
		[Embed(source = "../../../assets/menuboss.png")] protected var MenuBoss:Class;
		[Embed(source = "../../../assets/menucore.png")] protected var MenuCore:Class;
		[Embed(source = "../../../assets/menumove.png")] protected var MenuMove:Class;
		[Embed(source = "../../../assets/menunew.png")] protected var MenuNew:Class;
		[Embed(source = "../../../assets/menushoot.png")] protected var MenuShoot:Class;
		[Embed(source = "../../../assets/menushow.png")] protected var MenuShow:Class;
		[Embed(source = "../../../assets/menutitle.png")] protected var MenuTitle:Class;
		
		// Title
		private var menuTitle:FlxSprite;
		// Buttons
		private var menuNew:FlxButton;
		private var menuShow:FlxButton;
		// Arrows
		private var newMenuArrow:FlxSprite;
		private var showMenuArrow:FlxSprite;
		// Instructions
		private var menuCore:FlxSprite;
		private var menuBoss:FlxSprite;
		private var menuMove:FlxSprite;
		private var menuShoot:FlxSprite;
		
		private var _selected:uint = 0;
		private static const NEW_GAME:uint = 0;
		private static const SHOW_INSTRUCTIONS:uint = 1;
		
		public function MenuState() 
		{
			// #########
			// # TITLE #
			// #########
			menuTitle = new FlxSprite(50, 50, MenuTitle);
			add(menuTitle);
			
			// ###########
			// # BUTTONS #
			// ###########
			menuNew = new FlxButton(65, 90, null, startGame);
			menuNew.loadGraphic(MenuNew);
			add(menuNew);
			
			menuShow = new FlxButton(65, 115, null, showInstructions);
			menuShow.loadGraphic(MenuShow);
			add(menuShow);
			
			// ##########
			// # ARROWS #
			// ##########
			newMenuArrow = new FlxSprite(50, 90, MenuArrow);
			add(newMenuArrow);
			
			showMenuArrow = new FlxSprite(50, 115, MenuArrow);
			showMenuArrow.exists = false;
			add(showMenuArrow);
			
			// ################
			// # INSTRUCTIONS #
			// ################
			menuCore = new FlxSprite(50, 265, MenuCore);
			menuCore.exists = false;
			add(menuCore);
			
			menuMove = new FlxSprite(300, 50, MenuMove);
			menuMove.exists = false;
			add(menuMove);
			
			menuShoot = new FlxSprite(465, 50, MenuShoot);
			menuShoot.exists = false;
			add(menuShoot);
			
			menuBoss = new FlxSprite(400, 265, MenuBoss);
			menuBoss.exists = false;
			add(menuBoss);
			
			// #########
			// # DEBUG #
			// #########
			if (false && FlxG.debug)
			{
				var replayEntry:InputText = new InputText(600, 500, "Replay Game", startReplay);
				add(replayEntry);
			}
		}
		
		private function startReplay(id:String):void 
		{
			GameRegistry.doReplay = true;
			ReplayHandler.downloadRecording(id, Constants.LOGGING_SERVER);
		}
		
		override public function create():void
		{
			FlxG.mouse.show();
		}
		
		private function startGame():void
		{
			var newGameState:GameState = new GameState();
			GameRegistry.gameState = newGameState;
			GameRegistry.score = 0;
			FlxG.switchState(newGameState);
		}
		
		private function showInstructions():void 
		{
			menuCore.exists = !menuCore.exists;
			menuMove.exists = !menuMove.exists;
			menuShoot.exists = !menuShoot.exists;
			menuBoss.exists = !menuBoss.exists;
		}
		
		override public function update():void 
		{
			super.update();
			if (menuNew.overlapsPoint(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y))) {
				_selected = NEW_GAME;
			} else if (menuShow.overlapsPoint(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y))) {
				_selected = SHOW_INSTRUCTIONS;
			} if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) {
				_selected = Math.max(0, _selected - 1);
			} else if (FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("S")) {
				_selected = Math.min(1, _selected + 1);
			} else if (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) {
				if (_selected == 0) {
					startGame();
				} else if (_selected == 1) {
					showInstructions();
				}
			}
			
			if (_selected == 0) {
				newMenuArrow.exists = true;
				showMenuArrow.exists = false;
			} else if (_selected == 1) {
				newMenuArrow.exists = false;
				showMenuArrow.exists = true;
			}
		}
	}

}