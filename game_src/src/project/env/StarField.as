package project.env 
{

  import org.flixel.*;

  public class StarField extends FlxGroup {

    /*
     *  @param numStars the number of stars
     *  @param scrollFactor the scroll factor of this starfield
     *  @param worldSize the size of the world
     */
    public function StarField(numStars:Number, scrollFactor:Number, worldSize:Number):void {
      super();
      for (var i:int = 0; i < numStars; i++) {
        var str:FlxSprite = new FlxSprite(Utility.random() * worldSize - worldSize / 2, Utility.random() * worldSize - worldSize / 2);
        str.makeGraphic(1, 1, 0xffffffff);
        str.solid = false;
        str.scrollFactor = new FlxPoint(scrollFactor, scrollFactor);
        add(str);
      }
    }
  }
}