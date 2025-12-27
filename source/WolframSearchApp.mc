import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class WolframSearchApp extends Application.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  // onStart() is called on application start up
  var handler;
  function onStart(state as Dictionary?) as Void {
  }

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {}

  // Return the initial view of your application here
  function getInitialView() as [Views] or [Views, InputDelegates] {
    var wolfram_key = Properties.getValue("wolfram_key");
    var imperial = Properties.getValue("imperial");
    // System.println("Wolfram Key: " + wolfram_key);
    handler = new RequestHandler(wolfram_key, imperial);
    return [new WolframSearchView(handler), new WolframSearchDelegate()];
  }
}

function getApp() as WolframSearchApp {
  return Application.getApp() as WolframSearchApp;
}
