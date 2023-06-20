import 'package:document_manager_app/controller/file_controller.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:document_manager_app/view/permission_screen.dart';
import 'package:document_manager_app/widgets/grid_view.dart';
import 'package:document_manager_app/widgets/list_view.dart';
import 'package:document_manager_app/widgets/shimmer_grid_view.dart';
import 'package:document_manager_app/widgets/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../widgets/search_textfield.dart';

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
  Future<List<FileModel>> getAllFiles() async {
    await Future.delayed(const Duration(milliseconds: 500));

    List<FileModel> fileList = _fileController.fetchFile();

    return fileList;
  }

  @override
  Widget build(BuildContext context) {
    if (hasPermission) {
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
                    onTap: () => Navigator.of(context).pushNamed(
                        '/searchScreen',
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
                  if (!isGridView) {
                    toggleView();
                  }
                },
                icon: Icon(
                  isGridView
                      ? Icons.grid_view_rounded
                      : Icons.grid_view_outlined,
                  color: Colors.black87,
                )),

            //List view Icon button
            IconButton(
                onPressed: () {
                  if (isGridView) {
                    toggleView();
                  }
                },
                icon: Icon(
                  isGridView
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
                // const SizedBox(
                //   height: 20,
                // ),

                // Shows grid view or list view
                FutureBuilder(
                    future: getAllFiles(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.none) {
                        return Expanded(
                          child: isGridView
                              ? const GridViewShimmer()
                              : const ListViewShimmer(),
                        );
                      }

                      return Consumer<FileProvider>(
                          builder: (context, provider, child) {
                        provider.files = snapshot.data!;
                        return Visibility(
                          visible: provider.files.isNotEmpty,
                          replacement: const Center(
                            child: Text(
                              "No files",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          child: isGridView
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
