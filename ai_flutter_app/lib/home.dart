// import 'package:ai_flutter_app/main.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite/tflite.dart';

// class homepage extends StatefulWidget {
//   const homepage({super.key});

//   @override
//   State<homepage> createState() => _homepageState();
// }

// class _homepageState extends State<homepage> {
//   CameraImage? cameraImage;
//   CameraController? cameraController;
//   String output = "";
//   void initState() {
//     super.initState();
//     loadcamera();
//     loadmodel();
//   }

//   loadcamera() {
//     cameraController = CameraController(cameras![0], ResolutionPreset.medium);
//     cameraController!.initialize().then((value) {
//       if (!mounted) {
//         return;
//       } else {
//         setState(() {
//           cameraController!
//               .startImageStream((ImageStream) => cameraImage = ImageStream);
//           runModel();
//         });
//       }
//     });
//   }

//   runModel() async {
//     if (cameraImage != null) {
//       var predictions = await Tflite.runModelOnFrame(
//           bytesList: cameraImage!.planes.map((plane) {
//             return plane.bytes;
//           }).toList(),
//           imageHeight: cameraImage!.height,
//           imageWidth: cameraImage!.width,
//           imageMean: 127.5,
//           imageStd: 127.5,
//           rotation: 90,
//           numResults: 2,
//           threshold: 0.1,
//           asynch: true);
//       predictions!.forEach((element) {
//         setState(() {
//           output = element['label'];
//         });
//       });
//     }
//   }

//   loadmodel() async {
//     await Tflite.loadModel(
//         model: "assets/model.tflite", labels: "assets/labels.txt");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Live Camera nnmnmn"),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Container(
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 width: MediaQuery.of(context).size.width,
//                 child: cameraController!.value.isInitialized
//                     ? Container()
//                     : AspectRatio(
//                         aspectRatio: cameraController!.value.aspectRatio,
//                         child: CameraPreview(cameraController!),
//                       )),
//           ),
//           Text(
//             output,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           )
//         ],
//       ),
//     );
//   }
// }
