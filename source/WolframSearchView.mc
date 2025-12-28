import Toybox.Graphics;
import Toybox.WatchUi;

class WolframSearchView extends WatchUi.View {
  protected var handler as RequestHandler = new RequestHandler("", false);
  public var query = "";

  function initialize(handler_input) {
    handler = handler_input;
    View.initialize();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.MainLayout(dc));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  var text_delegate as SearchTextPickerDelegate =
    new SearchTextPickerDelegate();
  function onShow() as Void {
      pushView(
        new WatchUi.TextPicker(""),
        text_delegate,
        WatchUi.SLIDE_IMMEDIATE
      );

    // text_view = new TextView(
    //   "The quick brown fox jumped over the lazy dog. Speaking of lazy dog, I look over and see this distinguished creature lounging out on the sofa. Not a care in the world, yawing."
    // );
    // text_view_input_delegate = new TextViewInputDelegate();
    // pushView(text_view, text_view_input_delegate, SLIDE_DOWN);
  }

  // Update the view
  var text_view as TextView = new TextView("");
  var last_offset_count = 0;
  function onUpdate(dc as Dc) as Void {
    var cur_query = text_delegate.cur_query;

    if (cur_query != query and cur_query.length() > 0) {
      System.println("Searching \'" + cur_query + "\'...");
      query = cur_query;
      pushView(
        new WatchUi.ProgressBar("Searching...", null),
        null,
        WatchUi.SLIDE_BLINK
      );

      // Call Wolfram API
      handler.get_answer(query, method(:wolfram_callback));
    }

    View.onUpdate(dc);
  }

  function wolfram_callback(
    response as Toybox.Lang.Number,
    data as Toybox.Lang.String?
  ) as Void {
    if (data != null) {
      System.println("Answer Recieved: \'" + data + "\'");
      popView(SLIDE_BLINK);
      text_view = new TextView(data.toString());
      pushView(text_view, null, SLIDE_DOWN);
    } else {
      System.println("Null data recieved");
      text_view = new TextView("Search Error, please try again later.");
      pushView(text_view, null, SLIDE_DOWN);
    }
  }
}
