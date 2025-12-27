using Toybox.WatchUi;

class SearchTextPickerDelegate extends WatchUi.TextPickerDelegate {
  public var cur_query = "";

  function initialize() {
    TextPickerDelegate.initialize();
  }

  function onTextEntered(text, changed) {
    cur_query = text;
    return true;
  }

  function onCancel() as $.Toybox.Lang.Boolean {
    System.exit();
  }
}
