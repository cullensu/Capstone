package project.manager 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSound;
	/**
	 * ...
	 * @author jmlee337
	 */
	public class MusicManager extends FlxGroup
	{
		[Embed(source = "../../../assets/music/Bass.mp3")] private var _bassMp3:Class;
		[Embed(source = "../../../assets/music/Pad.mp3")] private var _padMp3:Class;
		[Embed(source = "../../../assets/music/Rhodes.mp3")] private var _rhodesMp3:Class;
		[Embed(source = "../../../assets/music/Strings.mp3")] private var _stringsMp3:Class;
		[Embed(source = "../../../assets/music/Synth.mp3")] private var _synthMp3:Class;
		
		protected var _bass:FlxSound;
		protected var _rhodes:FlxSound;
		protected var _pad:FlxSound;
		protected var _strings:FlxSound;
		protected var _synth:FlxSound;
		
		public function MusicManager() 
		{
			_bass = (new FlxSound()).loadEmbedded(_bassMp3, true, true);
			_pad = (new FlxSound()).loadEmbedded(_padMp3, true, true);
			_rhodes = (new FlxSound()).loadEmbedded(_rhodesMp3, true, true);
			_strings = (new FlxSound()).loadEmbedded(_stringsMp3, true, true);
			_synth = (new FlxSound()).loadEmbedded(_synthMp3, true, true);
			
			add(_bass);
			add(_pad);
			add(_rhodes);
			add(_strings);
			add(_synth);
			
			_bass.volume = 0.0;
			_pad.volume = 0.0;
			_rhodes.volume = 0.0;
			_strings.volume = 0.0;
			_synth.volume = 0.0;
			
			_bass.play();
			_pad.play();
			_rhodes.play();
			_strings.play();
			_synth.play();
		}
		
	}

}