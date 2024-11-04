import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nex_lab/providers/result_provider.dart';
import 'package:nex_lab/models/user_result_model.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
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
      backgroundColor:
          Colors.grey[300], // Add this line to change the scaffold color
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
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: const Icon(
                      Icons
                          .insert_drive_file, // Change this to a more convenient icon
                      color: Colors.blueAccent,
                      size: 40,
                    ),
                    title: Text(
                      'Result Name: ${result.filePath.substring(8, 13)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${result.filePath.substring(14, 24)}'),
                        Text(
                            'Time: ${result.filePath.substring(25, 33).replaceAll(r'-', r':')}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.picture_as_pdf,
                          color: Colors.redAccent),
                      onPressed: () async {
                        await resultProvider.fetchAndSavePdfReport(result.id);
                      },
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
