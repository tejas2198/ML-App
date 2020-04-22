/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _outputs;
  File _image;
  bool _loading = false;


  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachable Machine Learning'),
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Text("No Image Taken") : Image.file(_image),
            SizedBox(
              height: 20,
            ),
            _outputs != null
                ? _outputs.map((res){
              return Text(
                "${res["label"]}:${res["Confidence"].toStringAsFixed(3)}",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  background: Paint()..color = Colors.red,
                ),
              );
            }).toList() :Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.image),
      ),
    );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = false;
      _image = image;
    });
    await fileNotFound(image);
  }

  fileNotFound(File image){
    classifyImage(image);
  }
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }


  loadModel() async {
    await Tflite.loadModel(
      model: "assets/melanoma.tflite",
      labels: "assets/label.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}*/








import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _outputs;
  File _image;
  bool _loading = false;
  List _recognition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachable Machine Learning'),
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ?Text("No image taken"):Text("Image Selected"),/*Image.file(_image)*/
            SizedBox(
              height: 20,
            ),
            _outputs != null
                ? Text(
              "${_outputs[0]["label"]}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 50.0,
                background: Paint()..color = Colors.green,
              ),
            )
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.image),
      ),
    );
  }

  Future analyzeTFlite() async {
    print("Enter Analyze");
    String res = await Tflite.loadModel(
        model: "assets/melamnoma.tflite",
        labels: "assets/label.txt",
        numThreads: 1
    );
    print("Model Load");
    print('Model Loaded: $res');
    var recognitions = await Tflite.runModelOnImage(path: _image.path);
    setState(() {
      _recognition = recognitions;
    });
    print("Model End");
    print('Recognition Result: $_recognition');
  }

  Future pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 150,maxWidth: 150);
    if (image == null) return null;
    print("Hello");
    setState(() {
      _loading = false;
      _image = image;
    });
    print("Hello -1");
    analyzeTFlite();
    print("Hello -3");
    setState(() {
      _image = image;
      _loading = false;
    });
  }
}

































/*


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _outputs;
  File _image;
  bool _loading = false;
  List _recognition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachable Machine Learning'),
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ?Text("No image taken"): Image.file(_image),
            SizedBox(
              height: 20,
            ),
            _outputs != null
                ? Text(
              "${_outputs[0]["label"]}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 50.0,
                background: Paint()..color = Colors.green,
              ),
            )
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.image),
      ),
    );
  }

  Future analyzeTFlite() async {
    String res = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/label.txt",
        numThreads: 1
    );
    print('Model Loaded: $res');
    var recognitions = await Tflite.runModelOnImage(path: _image.path);
    setState(() {
      _recognition = recognitions;
    });
    print('Recognition Result: $_recognition');
  }

  Future pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 150,maxWidth: 150);
    if (image == null) return null;
    setState(() {
      _loading = false;
      _image = image;
    });
    analyzeTFlite();
    setState(() {
      _image = image;
      _loading = false;
    });
  }
}
*/