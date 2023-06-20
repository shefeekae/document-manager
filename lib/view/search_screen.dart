import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/file_model.dart';
import '../widgets/load_image.dart';
import '../widgets/search_textfield.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, required this.files});

  final TextEditingController searchController = TextEditingController();

  final List<FileModel> files;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Dismissing the keyboard on tapping anywhere on the screen
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'search',
                        child: SizedBox(
                          child: SearchTextField(
                            onChanged: (value) =>
                                FileManager.searchFile(context, value, files),
                            autofocus: true,
                            readOnly: false,
                            searchController: searchController,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => searchController.text.isEmpty
                            ? Navigator.of(context).pop()
                            : searchController.text = '',
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ))
                  ],
                ),
                Expanded(child:
                    Consumer<FileProvider>(builder: (context, provider, child) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: provider.foundFiles.length,
                    itemBuilder: (context, index) {
                      final file = provider.foundFiles[index];
                      return ListTile(
                        leading: Hero(
                          tag: file,
                          child: SizedBox(
                            height: 60,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FileManager.isPdf(file.documentType)
                                  ? Image.asset(
                                      "assets/pdf-1512.png",
                                      fit: BoxFit.cover,
                                    )
                                  : FileManager.isXlsx(file.documentType)
                                      ? Image.asset(
                                          "assets/xlsx-file.png",
                                          fit: BoxFit.cover,
                                        )
                                      : loadImage(
                                          file.path,
                                        ),
                            ),
                          ),
                        ),
                        title: Text(
                          file.title,
                          maxLines: 2,
                        ),
                        onTap: () => Navigator.of(context)
                            .pushNamed('/detailsScreen', arguments: file),
                      );
                    },
                  );
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
