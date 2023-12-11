// import 'package:ai_flutter_app/home.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// List<CameraDescription>? cameras;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: homepage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _output = [];
  final ImagePicker _picker = ImagePicker();
  bool _modelLoaded = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    // Load the pre-trained machine learning model only if it hasn't been loaded yet
    if (!_modelLoaded) {
      await Tflite.loadModel(
        model: 'assets/model.tflite',
        labels: 'assets/labels.txt',
      );
      setState(() {
        _modelLoaded = true;
      });
    }
  }

  Future<void> classifyImage() async {
    // Open the image picker to choose an image from the gallery
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Ensure the model is loaded before running inference
    if (!_modelLoaded) {
      await loadModel();
    }

    // Run the image through the loaded model for classification
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
    );

    // Update the UI with the model's prediction
    setState(() {
      _output = output!;
    });
  }

  @override
  void dispose() {
    // You can choose not to close the model in the dispose method
    // Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Flutter Ap654Rp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to trigger image classification
            ElevatedButton(
              onPressed: classifyImage,
              child: Text('Classify Image'),
            ),
            SizedBox(height: 20),
            // Display the model's prediction
            _output.isNotEmpty
                ? Text('Prediction: ${_output[0]['label']}')
                : Container(),
          ],
        ),
      ),
    );
  }
}
