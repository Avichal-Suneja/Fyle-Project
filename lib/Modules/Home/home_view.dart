import 'package:flutter/material.dart';
import 'package:fyle/Reusable-Widgets/loading.dart';
import 'package:fyle/Reusable-Widgets/repoCard.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hc = Get.find<HomeController>();
    return Obx(()=> Scaffold(
      body: hc.loading.value? const Loading() :
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height*0.25,
              child: Padding(
                padding: const EdgeInsets.only(left: 64),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(hc.user.value.avatarUrl==''? hc.sampleImage : hc.user.value.avatarUrl),
                      radius: Get.height*0.1,
                    ),
                    const SizedBox(width: 32),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            hc.editing.value? SizedBox(
                              width: 250,
                              child: TextField(
                                controller: hc.usernameController,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32
                                ),
                              ),
                            ) : Text(
                              ' ${hc.user.value.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: (){
                                hc.editing.value = true;
                              },
                            ),
                            const SizedBox(width: 8),
                            hc.editing.value? IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () async {
                                hc.pageNum.value = 1;
                                await hc.getUser();
                                await hc.getRepos();
                                hc.pages.value = (int.parse(hc.user.value.totalRepos)/10).ceil();
                                hc.editing.value = false;
                              },
                            ):const Text('')
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ' ${hc.user.value.bio}',
                          style: const TextStyle(
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '📍 ${hc.user.value.location}',
                          style: const TextStyle(
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: (){
                            launchUrlString(hc.user.value.githubUrl);
                          },
                          child: Text(
                            '🔗 ${hc.user.value.githubUrl}',
                            style: const TextStyle(
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 64, right: 64),
              child: hc.repoLoading.value? const Loading() : SizedBox(
                height: Get.height*0.6,
                child: GridView.count(
                  childAspectRatio: 5/4,
                  shrinkWrap: true,
                  crossAxisSpacing: 32,
                  crossAxisCount: 3,
                  children: [
                    for(var repo in hc.repositories)
                      RepoCard(repo: repo)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height*0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(int i=0; i<hc.pages.value; i++)
                    TextButton(
                      onPressed: () async {
                        hc.pageNum.value = i+1;
                        hc.repoLoading.value = true;
                        await hc.getRepos();
                        hc.repoLoading.value = false;
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: hc.pageNum.value == i+1? Colors.grey[200] : Colors.transparent,
                            border: Border.all(color: Colors.blueAccent)
                        ),
                        child: Center(
                          child: Text(
                              (i+1).toString(),
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16
                            ),
                          ),
                        )
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
