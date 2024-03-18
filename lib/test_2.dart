import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:gym/components/styles/colors.dart';
// import 'package:arabic_font/arabic_font.dart';

class DownloadPdfTest extends StatefulWidget {
  DownloadPdfTest({super.key});

  double progress = 0;
  int id = 0;
  String name = '';
  String url =
      'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  String path = '/storage/emulated/0/Download/dummy-3.pdf';
  bool isDownloaded = false;
  @override
  State<DownloadPdfTest> createState() => _DownloadPdfTestState();
}

class _DownloadPdfTestState extends State<DownloadPdfTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'بالعربي: ${widget.progress}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            Text('file name: ${widget.name}'),
            Text('download id: ${(widget.id != 0) ? widget.id : 'not yet'}'),
            ElevatedButton(
                onPressed: () {
                  File(widget.path).exists().then((value) {
                    widget.isDownloaded = value;
                    debugPrint('Downloaded: $value');
                  });

                  //You can download a single file
                  FileDownloader.downloadFile(
                      notificationType: NotificationType.all,
                      url: widget.url,
                      // name: widget.name,//(optional)
                      onProgress: (String? fileName, double progress) {
                        debugPrint('FILE fileName HAS PROGRESS $progress');
                        setState(() {
                          widget.progress = progress;
                          widget.name = fileName ?? 'no-name';
                        });
                      },
                      onDownloadRequestIdReceived: (int downloadId) {
                        setState(() {
                          widget.id = downloadId;
                        });
                      },
                      onDownloadCompleted: (String path) {
                        debugPrint('FILE DOWNLOADED TO PATH: $path');
                      },
                      onDownloadError: (String error) {
                        debugPrint('DOWNLOAD ERROR: $error');
                      });
                },
                child: const Text('Download')),
            ElevatedButton(
                onPressed: () async {
                  final canceled =
                      await FileDownloader.cancelDownload(widget.id);
                  debugPrint('Canceled: $canceled');
                },
                child: const Text('إلغاء')),
            ElevatedButton(onPressed: () {}, child: const Text('Test')),
          ],
        ),
      ),
    );
  }
}

