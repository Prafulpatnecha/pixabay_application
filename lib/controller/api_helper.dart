import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper
{
  // String api="";
  Future<Map> apiCalling(String callingSearch)
  async {
    Uri uri=Uri.parse('https://pixabay.com/api/?key=45158888-a401e90cb8eff0b4fc686572c&q=$callingSearch');
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