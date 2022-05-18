import 'package:dio/dio.dart';

class ApiService{

  Dio dio = Dio();

  Future getUser(String username) async {
    var url = 'https://api.github.com/users/$username';
    try{
      var response = await dio.get(url);
      return response.data;
    }catch(e){
      return null;
    }
  }

  Future getUserRepos(String username, int page) async {
    var query = {
      'page' : page,
      'per_page' : 10,
    };
    var url = 'https://api.github.com/users/$username/repos';
    try{
      var response = await dio.get(url, queryParameters: query);
      return response.data;
    }catch(e){
      return null;
    }
  }

  Future getLanguages(String languageUrl) async {
    try{
      var response = await dio.get(languageUrl);
      return response.data;
    }catch(e){
      return null;
    }
  }
}