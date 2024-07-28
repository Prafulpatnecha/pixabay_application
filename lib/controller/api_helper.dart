import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper
{
  // String api="";
  Future<Map> apiCalling(String callingSearch)
  async {
    Uri uri=Uri.parse('https://pixabay.com/api/?key=45126041-73e5750c34eec46c215312624&q=$callingSearch');
    Response response= await http.get(uri);
    if(response.statusCode==200)
      {
        final body=response.body;
        final json=jsonDecode(body);
        return json;
      }
    else
      {
        print('api Calling failed');
        return {};
      }
  }
}