import Toybox.WatchUi;

class TextView extends WatchUi.View {
  hidden var area;
  protected var inner_text;
  public var offset_y_count = 0;

  function initialize(text_param) {
    inner_text = text_param;
    View.initialize();
  }

  function onShow() {
    var width = System.getDeviceSettings().screenWidth;
    var height = System.getDeviceSettings().screenHeight;

    area = new WatchUi.TextArea({
      :text => inner_text,
      :color => Graphics.COLOR_WHITE,
      :font => [Graphics.FONT_MEDIUM, Graphics.FONT_SMALL, Graphics.FONT_XTINY],
      :locX => WatchUi.LAYOUT_HALIGN_CENTER,
      :locY => WatchUi.LAYOUT_VALIGN_CENTER,
      :width => (width / 16) * 13,
      :height => (height / 5) * 3,
    });
  }

  function onUpdate(dc) {
    System.println("Text: " + inner_text);
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    dc.clear();
    area.draw(dc);
  }
}
