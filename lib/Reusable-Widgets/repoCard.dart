import 'package:flutter/material.dart';
import 'package:fyle/Models/repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RepoCard extends StatelessWidget {
  const RepoCard({Key? key, required this.repo}) : super(key: key);
  final Repository repo;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: (){
                launchUrlString(repo.githubUrl);
              },
              child: Text(
                repo.name,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              repo.description,
              textAlign: TextAlign.left,
              maxLines: 6,
              style: const TextStyle(
                  fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                for(var language in repo.languages)
                  ElevatedButton(
                    child: Text(language),
                    onPressed: (){},
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
