class RequestHandler {
  protected var app_id;
  protected var is_imperial;
  public function initialize(app_id_input, is_imperial_input) {
    app_id = app_id_input;
    is_imperial = is_imperial_input;
  }
  public var recent_query as Toybox.Lang.String = "";

  function onReceive(
    responseCode as Toybox.Lang.Number,
    data as Toybox.Lang.String
  ) as Void {
    if (responseCode == 200) {
      System.println("Request Successful"); // print success
    } else {
      System.println("Response: " + responseCode); // print response code
    }
  }

  public function get_answer(query, responseCallback) {
    var url = "https://api.wolframalpha.com/v1/result";

    var units = "metric";
    if (is_imperial) {
      units = "imperial";
    }

    System.println(app_id);

    var params = {
      "appid" => app_id,
      "i" => query,
      "units" => units,
    };

    var options = {
      :method => Communications.HTTP_REQUEST_METHOD_GET,
      :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_TEXT_PLAIN,
    };

    // var x = method(:onReceive);
    Communications.makeWebRequest(url, params, options, responseCallback);
  }
}
