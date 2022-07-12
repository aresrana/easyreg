

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io' as io;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:regeasy/notesSql/model/User.dart';

class BabyCard extends StatelessWidget {
  final UserModels userModels;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
   final GlobalKey globalKey = new GlobalKey();
   BabyCard(this.userModels,
      {Key? key, required this.onDelete, required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Card(
       shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10),
    side: const BorderSide(
    color: Colors.black,
    width:5.0,
    style: BorderStyle.solid

    )

    ),
     child: Padding(
       padding: EdgeInsets.fromLTRB (10, 10, 0, 0),




            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(
                height: 15,

              ),
         _rowDetails('Name: ', userModels.name,),
          _rowDetails('Age: ', userModels.age,),
          _rowDetails('Church: ', userModels.church,),
          _rowDetails('Church State: ', userModels.churchState,),
          _rowDetails('Church City: ',userModels.churchCity,),
          _rowDetails('Gender: ',userModels.gender,),

      ButtonBar(children: <Widget>[
        TextButton(child: const Text('Edit'), onPressed: onEdit),
        TextButton(
          child: const Text('Delete'),
          onPressed: onDelete,
        ),
        TextButton(
          child: const Text('Generate QR Code'),
          onPressed: () {
            var dat =userModels.name! +
                ',' +
                userModels.age! +
                ',' +
                userModels.gender! +
                ',' +
                userModels.church! +
                ',' +
                userModels.churchCity! +
                    ',' +
                userModels.churchState!

            ;

            Scaffold.of(context)
                .showBottomSheet<void>((BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Center(
                        child: Text('I am ' +userModels.name!))

                      ),
                      Container(
                          height:
                          MediaQuery.of(context).size.height *
                              0.2,
                          child: Center(
                              child: RepaintBoundary(
                                key: globalKey,

                                child: QrImage(
                                  data: dat,
                                  backgroundColor: Colors.white,
                                  version: QrVersions.auto,
                                ),
                              ))),
                      Center(
                          child: ElevatedButton(
                              child:
                              const Text('Close BottomSheet'),
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                      Center(
                          child: ElevatedButton(
                              child:
                              const Text('Take ScreenShot'),
                              onPressed: () async {
                                if (await Permission.storage.request().isGranted)                                                   {
                                  share_img();
                                }
                              }))
                    ],
                  ),
                ),
              );
            });


          },
        ),

      ])
    ])));

  }
  Widget _rowDetails(String text,String? info) =>//IconData iconData) =>
      Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
            ),
             Text(
              info ?? '',
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      );


}
Future<Uint8List> _capturePng() async {
  var globalKey;
  RenderRepaintBoundary boundary =
  globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  var image = await boundary.toImage(pixelRatio: 10);
  var byteData = await image.toByteData(format: ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}


void share_img() async {
  var pngBytes = await _capturePng();
  final directory = (await getApplicationDocumentsDirectory()).path;
  var bs64 = base64Encode(pngBytes);
  print(pngBytes);
  io.File imgFile = new io.File('$directory/screenshot.png');

  final file = await io.File('${directory}/dat.png').create();
  await file.writeAsBytes(pngBytes);
  await imgFile.writeAsBytes(pngBytes);
  //Share.shareFiles([imgFile.path], text: '');
  print(bs64);
}