import 'package:document_manager_app/controller/file_controller.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:document_manager_app/view/permission_screen.dart';
import 'package:document_manager_app/widgets/grid_view.dart';
import 'package:document_manager_app/widgets/list_view.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isGridView = false;

  bool hasPermission = true;

  final FileController _fileController = FileController();

  //request permission method
  checkPermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      hasPermission = true;
      setState(() {});
      return true;
    } else {
      hasPermission = false;
      setState(() {});
      return false;
    }
  }

  //navigate to add screen
  navigateToAddScreen(List<FileModel> files) {
    Navigator.of(context).pushNamed('/addScreen', arguments: files);
  }

//Method for toggling grid view and list view
  toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

//grant permssion method
  grantPermission() async {
    var result = await Permission.manageExternalStorage.request();
    if (result.isGranted) {
      hasPermission = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

//This method fetches all files from device storage
  getAllFiles() {
    _fileController.fetchFile(context);
  }

  @override
  Widget build(BuildContext context) {
    if (hasPermission) {
      return Consumer<FileProvider>(builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: SafeArea(
            child: FutureBuilder(
                future: getAllFiles(),
                builder: (context, file) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Visibility(
                      visible: provider.files.isNotEmpty,
                      replacement: const Center(
                        //If there are no files in the device storage
                        child: Text(
                          "No files to show",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "All Files",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  //Search
                                  Hero(
                                    tag: 'search',
                                    child: SizedBox(
                                      height: 40,
                                      width: 120,
                                      child: SearchTextField(
                                        autofocus: false,
                                        readOnly: true,
                                        onTap: () => Navigator.of(context)
                                            .pushNamed('/searchScreen',
                                                arguments:
                                                    Provider.of<FileProvider>(
                                                            context,
                                                            listen: false)
                                                        .files),
                                      ),
                                    ),
                                  ),

                                  //Grid view Icon button
                                  IconButton(
                                      onPressed: () {
                                        if (!isGridView) {
                                          toggleView();
                                        }
                                      },
                                      icon: Icon(isGridView
                                          ? Icons.grid_view_rounded
                                          : Icons.grid_view_outlined)),

                                  //List view Icon button
                                  IconButton(
                                      onPressed: () {
                                        if (isGridView) {
                                          toggleView();
                                        }
                                      },
                                      icon: Icon(isGridView
                                          ? Icons.view_list_outlined
                                          : Icons.view_list_rounded)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Shows grid view or list view
                          isGridView
                              ? FileGridView(fileList: provider.files)
                              : FileListView(fileList: provider.files),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          //Floating action button
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 55, 126, 94),
            onPressed: () => navigateToAddScreen(provider.files),
            child: const Icon(Icons.add),
          ),
        );
      });
    } else {
      //Shows permission screen if permission is not given
      return PermissionScreen(
        onPressed: () async {
          await grantPermission();
        },
      );
    }
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.onChanged,
    this.onTap,
    required this.autofocus,
    this.searchController,
    required this.readOnly,
  });

  final Function(String)? onChanged;
  final Function()? onTap;
  final bool autofocus;
  final TextEditingController? searchController;

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 0,
      child: TextField(
        controller: searchController,
        onTap: onTap,
        onChanged: onChanged,
        autofocus: autofocus,
        readOnly: readOnly,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25)),
            contentPadding: const EdgeInsets.all(6),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: "Search",
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.grey),
      ),
    );
  }
}
