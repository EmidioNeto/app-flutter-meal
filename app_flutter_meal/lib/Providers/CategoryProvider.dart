//importing HTTP package for fetching and consuming HTTP resources
import 'package:http/http.dart' as http;

//Github request class
class Category {
  //Fetch a user with the username supplied in the form input
  Future<http.Response> fetchCategories() {
    return http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?c=list/'));
  }
}
