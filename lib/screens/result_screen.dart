import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:provider/provider.dart';
import 'package:nex_lab/providers/result_provider.dart';
import 'package:nex_lab/models/user_result_model.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String fileName;

  @override
  void initState() {
    // Call getResults when the screen is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ResultProvider>(context, listen: false).getResults();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Consumer<ResultProvider>(
        builder: (context, resultProvider, child) {
          if (resultProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (resultProvider.isFailed) {
            return const Center(child: Text('Failed to load results'));
          }

          if (resultProvider.results.isEmpty) {
            return const Center(child: Text('No results found'));
          }

          return ListView.builder(
            itemCount: resultProvider.results.length,
            itemBuilder: (context, index) {
              UserResultModel result = resultProvider.results[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: secondColor
                    ),
                    child: ListTile(
                      title: Text('Result Name: ${result.filePath.substring(8,13)}'),
                      subtitle: Text('Date: ${result.filePath.substring(14,24)} \nTime: ${result.filePath.substring(25,33).replaceAll(r'-', r':')}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.picture_as_pdf),
                        onPressed: () async {
                          await resultProvider.fetchPdfReport(result.id);
                        },
                      ),
                    ),
                  ),
                  
                ),
              );
            },
          );
        },
      ),
    );
  }
}
