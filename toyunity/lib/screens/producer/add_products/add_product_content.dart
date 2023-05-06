import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/constants/responsive.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';

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
            backgroundColor: pickerColor,
            foregroundColor: white,
            title: Text('Ajout de Jouet'),
          ),
          body: SingleChildScrollView(
            child: !Responsive.isDesktop(context)
                ? Column(
                    children: items(
                        context,
                        size,
                        _keyForm1,
                        _pName,
                        _formError,
                        _keyForm2,
                        _pDescription,
                        _keyForm3,
                        _price),
                  )
                : Row(
                    children: items(
                        context,
                        size,
                        _keyForm1,
                        _pName,
                        _formError,
                        _keyForm2,
                        _pDescription,
                        _keyForm3,
                        _price),
                  ),
          ),
        ));
  }

  List<Widget> items(
      BuildContext context,
      Size size,
      GlobalKey<FormState> _keyForm1,
      String _pName,
      String _formError,
      GlobalKey<FormState> _keyForm2,
      String _pDescription,
      GlobalKey<FormState> _keyForm3,
      String _price) {
    return [
      GestureDetector(
        onTap: () {
          getImage();
        },
        child: Container(
          child: image == null
              ? Center(
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    color: pickerColor,
                    size: Responsive.isMobile(context)
                        ? size.width
                        : size.width * 0.4,
                  ),
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
      Container(
        width:
            Responsive.isMobile(context) ? size.width * 0.9 : size.width * 0.36,
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showPicker();
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: pickerColor,
                    child: Container(
                      height: 50,
                      width: 50,
                    ),
                  ),
                  spacerWidth,
                  CustumText(
                    text: "Choisir la couleure",
                    size: 16,
                    color: pickerColor,
                    weight: FontWeight.bold,
                  )
                ],
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
                  maxLength: 100,
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
                  maxLength: 10,
                  onChanged: (value) => _price = value,
                  validator: (value) => _price == '' ? _formError : null,
                  decoration: InputDecoration(
                    labelText: "Entrer le prix du jouet",
                    border: OutlineInputBorder(),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    bgcolor: secondaryColor,
                    text: "Enregistrer",
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
                    }),
              ],
            )
          ],
        ),
      ),
    ];
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
        uid: MyApp.currentUser!.uid,
        description: pDescription,
        price: double.parse(price),
        images: [pUrlImg],
        color: pickerColor.toString(),
        status: 'wait',
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

  // create some values
  Color pickerColor = primaryColor;
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future showPicker() {
    // raise the [showDialog] widget
    return showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
          //
          // child: MultipleChoiceBlockPicker(
          //   pickerColors: currentColor,
          //   onColorsChanged: changeColors,
          // ),
        ),
        actions: <Widget>[
          CustomButton(
            bgcolor: pickerColor,
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
            text: 'Valider',
          ),
        ],
      ),
      context: context,
    );
  }
}
