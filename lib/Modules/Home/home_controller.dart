import 'package:flutter/cupertino.dart';
import 'package:fyle/Models/repository.dart';
import 'package:fyle/Services/api_service.dart';
import 'package:get/get.dart';

import '../../Models/user.dart';

class HomeController extends GetxController{

  final _api = Get.find<ApiService>();

    TextEditingController usernameController = TextEditingController();
    RxInt pages = 1.obs;

    Rx<User> user = User(username: '',name: '', avatarUrl: '', githubUrl: '', bio: '', totalRepos: '', location: '').obs;
    RxList<Repository> repositories = <Repository>[].obs;
    RxBool loading = false.obs;
    RxBool repoLoading = false.obs;
    RxBool editing = false.obs;
    RxInt pageNum = 1.obs;

    String sampleImage = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';

    getUser() async {
      loading.value = true;
      var json = await _api.getUser(usernameController.text);
      if(json!=null){
          user.value.username = json['login'];
          user.value.name = json['name']?? '';
          user.value.avatarUrl = json['avatar_url']?? '';
          user.value.githubUrl = json['html_url']?? '';
          user.value.bio = json['bio'] ?? 'No bio for this guy!';
          user.value.location = json['location']?? 'Unknown';
          user.value.totalRepos = json['public_repos'].toString();
      }else{
        Get.defaultDialog(
          content: const Text(
            'No user found with this username! \nor maybe your API limit exceeded 💀',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2
            ),
          )
        );
      }
      loading.value = false;
    }

    getRepos() async {
      repositories.clear();
      var jsonList = await _api.getUserRepos(user.value.username, pageNum.value);
      if(jsonList!=null){
        try{
          for(var json in jsonList){
            var jsonLang = await _api.getLanguages(json['languages_url']);
            List<String> languages;
            try{
              languages = jsonLang.keys.toList()?? ['Unknown'];
            }catch(e){
              languages = ['Unknown'];
            }
            Repository repo = Repository(name: json['name']?? '', description: json['description']?? 'No description available',
                githubUrl: json['html_url']?? '', dateCreated: json['created_at']?? '', languages: languages, stars: json['stargazers_count'].toString());
            repositories.add(repo);
          }
        }catch(e){
          null;
        }
      }
    }

    @override
  void onInit() async {
    usernameController.text = 'Avichal-Suneja';
    await getUser();
    loading.value = true;
    await getRepos();
    loading.value = false;

    pages.value = (int.parse(user.value.totalRepos)/10).ceil();
    super.onInit();
  }
}