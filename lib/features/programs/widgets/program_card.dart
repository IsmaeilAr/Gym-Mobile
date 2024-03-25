import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../components/pop_menu/pop_menu_set_program.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';
import '../../../components/styles/gym_icons.dart';
import '../../../components/pop_menu/menu_item_model.dart';
import '../model/program_model.dart';
import '../provider/program_provider.dart';
import '../screens/program_pdf_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard(
    this.program,
    this.isSelected, {
    super.key,
  });

  final ProgramModel program;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    // bool isPDF = (p.extension(program.file.toLowerCase()) == '.pdf');
    bool isPDF = (program.file.toLowerCase().endsWith('.pdf'));
    return GestureDetector(
      onTap: () {
        debugPrint(isPDF.toString());
        (isPDF)
            ? Navigator.push(
                context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: PDFScreen(
                  programName: program.name,
                  programFileName: program.file,
                    )))
            : () {
                openFileUrl(program.file);
              };
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 156.h,
                width: 332.w,
                child: Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Container(
                    width: 320.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          program.imageUrl,
                        ),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            black.withOpacity(0.3), BlendMode.darken),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 10.w,
                  top: 0.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Platform.isAndroid)
                        DownloadButton(program.name,
                          'https://css4.pub/2015/icelandic/dictionary.pdf'),
                      // DownloadButton(program.name, program.file),
                      PopupMenuButton<MenuItemModel>(
                        itemBuilder: (context) {
                          List<MenuItemModel> nowItems = [];
                          !isSelected
                              ? nowItems
                                  .add(SetProgramsMenuItems.selectProgramItem)
                              : nowItems.add(
                                  SetProgramsMenuItems.deselectProgramItem);
                          return [
                            ...nowItems.map(buildItem),
                          ];
                        },
                        onSelected: (item) =>
                            onSelectSetProgram(context, item, program, () {
                          _selectProgram(context, program.id);
                        }, () {
                          _deselectProgram(context, program.id);
                        }),
                        color: dark,
                        iconColor: lightGrey,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: const Icon(
                            Icons.more_horiz_sharp,
                            size: 20,
                            color: lightGrey,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Text(
                  program.name,
                  style: MyDecorations.programsTextStyle,
                ),
                SizedBox(
                  width: 5.h,
                ),
                isSelected
                    ? Icon(
                        Icons.check_box,
                        color: grey,
                        size: 12.sp,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  void _selectProgram(BuildContext context, int programId) {
    context.read<ProgramProvider>().callSetProgram(context, programId);
    // todo onRefresh
  }

  void _deselectProgram(BuildContext context, int programId) {
    context.read<ProgramProvider>().callUnSetProgram(context, programId);
    // todo onRefresh
  }

  Future<void> openFileUrl(String fileUrl) async {
    if (await canLaunchUrl(Uri.parse(fileUrl))) {
      await launchUrl(Uri.parse(fileUrl));
    } else {
      throw 'Could not launch $fileUrl';
    }
  }
}

class DownloadButton extends StatefulWidget {
  const DownloadButton(
    this.name,
    this.filePath, {
    super.key,
  });

  final String name;
  final String filePath;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool isDownloading = false;
  bool isDownloaded = false;
  late int processId;

  // make initState check if exist
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isDownloaded = checkDownloaded(widget.name);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isDownloaded,
      // visible: true,
      child: isDownloading
          ? IconButton(
              onPressed: () async {
                final canceled = await FileDownloader.cancelDownload(processId);
                debugPrint('Canceled: $canceled');
              },
              icon: Icon(
                Icons.downloading_outlined,
                color: lightGrey,
                size: 20.r,
              ))
          : IconButton(
              onPressed: () {
                setState(() => isDownloading = true);
                downloadPDF(widget.name, widget.filePath);
              },
              icon: Icon(
                GymIcons.download,
                color: lightGrey,
                size: 14.r,
              )),
    );
  }

  bool checkDownloaded(String name) {
    String path = '/storage/emulated/0/Download/';
    bool isHere = File('$path$name.pdf').existsSync();
    return isHere;
  }

  void downloadPDF(String name, String file) {
    debugPrint('downloading: $name  from $file');

    FileDownloader.downloadFile(
        notificationType: NotificationType.all,
        url: file,
        name: name,
        onProgress: (String? fileName, double progress) {
          debugPrint('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadRequestIdReceived: (int downloadId) {
          processId = downloadId;
        },
        onDownloadCompleted: (String path) {
          debugPrint('FILE DOWNLOADED TO PATH: $path');
          setState(() => isDownloading = false);
        },
        onDownloadError: (String error) {
          debugPrint('DOWNLOAD ERROR: $error');
          setState(() => isDownloading = false);
        });
  }
}
