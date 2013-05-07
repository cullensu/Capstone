package project.env
{

  import org.flixel.*;
  import project.util.Utility;
  import project.constant.Constants;

  public class StarTile extends FlxGroup {

    private const numStars:Number = 10;

    /*
     *  @param x x-coordinate of tile
     *  @param y y-coordinate of tile
     *  @param scrollFactor the scroll factor of this starTile
     */
    public function StarTile(x:int, y:int, scrollFactor:Number):void
    {
      super();
      for (var i:int = 0; i < numStars; i++)
      {
        var str:FlxSprite = new FlxSprite(Utility.random() * Constants.TILESIZE + x, Utility.random() * Constants.TILESIZE + y);
        str.makeGraphic(1, 1, 0xffffffff);
        str.scrollFactor = new FlxPoint(scrollFactor, scrollFactor);
        add(str);
      }
      this.visible = false;
    }
  }
}