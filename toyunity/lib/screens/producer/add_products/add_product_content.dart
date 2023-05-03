import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../main.dart';
import '../../../models/toy_model.dart';
import '../../../services/api/toy_api.dart';
import '../../../services/db_services.dart';
import '../../components/forms/custom_button.dart';
import '../../shared_ui/showSnackBar.dart';
import 'toy_localisation.dart';

class AddToyContent extends StatefulWidget {
  const AddToyContent({Key? key}) : super(key: key);

  @override
  _AddToyContentState createState() => _AddToyContentState();
}

class _AddToyContentState extends State<AddToyContent> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('http://localhost:3000/upload');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title'] = "Static title";

    var multiport = new http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();

    print(response.stream.toString());
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('image uploaded');
    } else {
      print('failed');
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _keyForm1 = GlobalKey<FormState>();
    final _keyForm2 = GlobalKey<FormState>();
    final _keyForm3 = GlobalKey<FormState>();
    List<double> coordinate = [];
    String _pName = '';
    String _pDescription = '';
    String _price = '';
    String _formError = "Veuillez entrer toutes les informations";
    var size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                child: image == null
                    ? Center(
                        child: Text('Pick Image'),
                      )
                    : Container(
                        child: kIsWeb
                            ? Image(
                                image: NetworkImage(image!.path),
                                fit: BoxFit.cover,
                                height: size.height / 3,
                                width: size.width / 1.4,
                              )
                            : Center(
                                child: Image.file(
                                  File(image!.path).absolute,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
              ),
            ),
            Form(
                key: _keyForm1,
                child: TextFormField(
                  maxLength: 30,
                  onChanged: (value) => _pName = value,
                  validator: (value) => _pName == '' ? _formError : null,
                  decoration: InputDecoration(
                    labelText: "Enter product name",
                    border: OutlineInputBorder(),
                  ),
                )),
            Form(
                key: _keyForm2,
                child: TextFormField(
                  maxLength: 30,
                  onChanged: (value) => _pDescription = value,
                  validator: (value) => _pDescription == '' ? _formError : null,
                  decoration: InputDecoration(
                    labelText: "Entrer la description du jouet",
                    border: OutlineInputBorder(),
                  ),
                )),
            Form(
                key: _keyForm3,
                child: TextFormField(
                  maxLength: 30,
                  onChanged: (value) => _price = value,
                  validator: (value) => _price == '' ? _formError : null,
                  decoration: InputDecoration(
                    labelText: "Entrer le prix du jouet",
                    border: OutlineInputBorder(),
                  ),
                )),
            CustomButton(
                text: "Lieux de retrait",
                onPressed: () async {
                  final LatLng? selectedLocation = await showDialog(
                      context: context, builder: (ctx) => MapDialog());
                  if (selectedLocation != null) {
                    coordinate.add(selectedLocation.longitude);
                    coordinate.add(selectedLocation.latitude);
                  }
                }),
            CustomButton(
                text: "Validate",
                onPressed: () {
                  onSubmit(
                    context: context,
                    price: _price,
                    pDescription: _pDescription,
                    keyForm1: _keyForm1,
                    keyForm2: _keyForm2,
                    keyForm3: _keyForm3,
                    pName: _pName,
                  );
                })
          ],
        ),
      ),
    );
  }

  void onSubmit(
      {context,
      keyForm1,
      keyForm2,
      keyForm3,
      required String pName,
      required String price,
      required String pDescription}) async {
    if (keyForm1.currentState!.validate() &&
        keyForm2.currentState!.validate() &&
        keyForm3.currentState!.validate()) {
      showNotification(context, "Loading...");
      DataBaseService _db = DataBaseService();
      String pUrlImg = await _db.uploadFile(image!);
      print("===========================================");
      print("==============try to save toy================");
      ApiToy.addToy(ToyModel(
        name: pName,
        uid: "q37IlveCvobp8NMlhtyoczIDesF3",
        description: pDescription,
        price: double.parse(price),
        images: [pUrlImg],
        color: 'red',
        createdAt: '',
        status: 'wait',
        updatedAt: '',
        coordinates: [1, 1],
      ));
    }
  }

  Form inputForm(GlobalKey<FormState> _keyForm, String _pName,
      String _formError, String labelText) {
    return Form(
        key: _keyForm,
        child: TextFormField(
          maxLength: 30,
          onChanged: (value) => _pName = value,
          validator: (value) => _pName == '' ? _formError : null,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
          ),
        ));
  }
}
