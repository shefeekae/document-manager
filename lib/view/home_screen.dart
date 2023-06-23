import 'package:document_manager_app/controller/file_controller.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:document_manager_app/provider/toggle_view_provider.dart';
import 'package:document_manager_app/widgets/grid_view.dart';
import 'package:document_manager_app/widgets/list_view.dart';
import 'package:document_manager_app/widgets/shimmer_grid_view.dart';
import 'package:document_manager_app/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/search_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FileController _fileController = FileController();

  //navigate to add screen
  navigateToAddScreen(List<FileModel> files) {
    Navigator.of(context).pushReplacementNamed('/addScreen', arguments: files);
  }

//This method fetches all files from database
  Future<List<FileModel>> getAllFiles() async {
    List<FileModel> files = _fileController.getAllFiles(context);

    await Future.delayed(const Duration(milliseconds: 250));

    return files;
  }

  @override
  Widget build(BuildContext context) {
    // if (hasPermission) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: const Text("All Files",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        actions: [
          //Search bar
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Hero(
              tag: 'search',
              child: SizedBox(
                height: 40,
                width: 120,
                child: SearchTextField(
                  autofocus: false,
                  readOnly: true,
                  onTap: () => Navigator.of(context).pushNamed('/searchScreen',
                      arguments:
                          Provider.of<FileProvider>(context, listen: false)
                              .files),
                ),
              ),
            ),
          ),

          //Grid view Icon button
          IconButton(
              onPressed: () {
                if (!Provider.of<ToggleViewProvider>(context, listen: false)
                    .isGridView) {
                  Provider.of<ToggleViewProvider>(context, listen: false)
                      .toggleView();
                }
              },
              icon: Icon(
                Provider.of<ToggleViewProvider>(context).isGridView
                    ? Icons.grid_view_rounded
                    : Icons.grid_view_outlined,
                color: Colors.black87,
              )),

          //List view Icon button
          IconButton(
              onPressed: () {
                if (Provider.of<ToggleViewProvider>(context, listen: false)
                    .isGridView) {
                  Provider.of<ToggleViewProvider>(context, listen: false)
                      .toggleView();
                }
              },
              icon: Icon(
                Provider.of<ToggleViewProvider>(context).isGridView
                    ? Icons.view_list_outlined
                    : Icons.view_list_rounded,
                color: Colors.black87,
              )),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Shows grid view or list view
              FutureBuilder(
                  future: getAllFiles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
                      return Expanded(
                        child: Provider.of<ToggleViewProvider>(
                          context,
                        ).isGridView
                            ? const GridViewShimmer()
                            : const ListViewShimmer(),
                      );
                    }

                    return Consumer<FileProvider>(
                        builder: (context, provider, child) {
                      provider.files = snapshot.data!;
                      return Visibility(
                        visible: provider.files.isNotEmpty,
                        replacement: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Image.asset(
                                'assets/avatar_writing-5kJdV6Aej-transformed.png',
                                scale: 4,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "No files to show",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Add files by tapping the '+' icon ",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        child: Provider.of<ToggleViewProvider>(
                          context,
                        ).isGridView
                            ? FileGridView(fileList: provider.files)
                            : FileListView(fileList: provider.files),
                      );
                    });
                  }),
            ],
          ),
        ),
      ),
      //Floating action button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 55, 126, 94),
        onPressed: () => navigateToAddScreen(
            Provider.of<FileProvider>(context, listen: false).files),
        child: const Icon(Icons.add),
      ),
    );
  }
}
