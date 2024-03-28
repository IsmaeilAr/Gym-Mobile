import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../home/provider/home_provider.dart';

bool _torch = false;

class QRView extends StatefulWidget {
  const QRView({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.scanYourGymQR,
          style: TextStyle(
              color: lightGrey, fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
        backgroundColor: black,
        leading: BarIconButton(
          icon: Icons.arrow_back_ios_outlined,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         setState(() {
        //           _torch = !_torch;
        //         });
        //       },
        //       icon: Icon(_torch
        //           ? Icons.flashlight_off_outlined
        //           : Icons.flashlight_on_outlined))
        // ],
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.back,
          torchEnabled: _torch,
        ),
        onDetect: (capture) {
          // send gym id to back end and start the counter
          // final List<Barcode> barcodes = capture.barcodes;
          // for (final barcode in barcodes) {
          //   debugPrint('Barcode found! ${barcode.rawValue}');
          // }
          // context.read<HomeProvider>().callCheckInApi();
          context.read<HomeProvider>().onCheckIn();
          Navigator.pop(context);
        },
      ),
    );
  }
}
