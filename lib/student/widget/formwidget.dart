import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmap/student/model/studentmodel.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../blocparts/studentbloc/form bloc/form_bloc.dart';
import '../blocparts/studentbloc/form bloc/form_event.dart';
import '../blocparts/studentbloc/form bloc/form_state.dart';
import '../service/helper.dart';
import '../view/mapscreen.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formStateKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _studentAddressController = TextEditingController();
  final _studentCurrentLocationController = TextEditingController();
  final _studentEmailController = TextEditingController();
  final _studentPhoneController = TextEditingController();
  final dateInput = TextEditingController();
  final _selectedDistrictControll =TextEditingController();
  final _selectedGenderControll =TextEditingController();
  final _selectedImgeControll =TextEditingController();

  late Helper? db;
  String? _selectedDistrict;
  String? _selectedGender;
  bool _termsChecked = false;
  Student? student;
  XFile? image;
  late Helper dbHelper;
  late String _studentimg;
  final ImagePicker picker = ImagePicker();

  void myAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Please choose media to select'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });

    if (image != null) {
      List<int> imageBytes = await image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      _studentimg = base64Image;
      _selectedImgeControll.text=_studentimg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formStateKey,
        child: Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: TextFormField(
                          controller: _studentNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.person),
                            label: Text('Name'),
                            hintText: 'Enter your name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if (value.length < 2) {
                              return 'please enter a valid name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: TextFormField(
                          controller: _studentAddressController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Address'),
                            icon: Icon(Icons.home),
                            hintText: 'Enter  your address',
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if (value.length < 4) {
                              return 'Too short';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: DropdownButtonFormField<String>(
                          value: _selectedDistrict,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.place),
                            labelText: 'Select a district',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Thiruvananthapuram',
                              child: Text('Thiruvananthapuram'),
                            ),
                            DropdownMenuItem(
                              value: 'Kollam',
                              child: Text('Kollam'),
                            ),
                            DropdownMenuItem(
                              value: 'Pathanamthitta',
                              child: Text('Pathanamthitta'),
                            ),
                            DropdownMenuItem(
                              value: 'Alappuzha',
                              child: Text('Alappuzha'),
                            ),
                            DropdownMenuItem(
                              value: 'Kottayam',
                              child: Text('Kottayam'),
                            ),
                            DropdownMenuItem(
                              value: 'Idukki',
                              child: Text('Idukki'),
                            ),
                            DropdownMenuItem(
                              value: 'Ernakulam',
                              child: Text('Ernakulam'),
                            ),
                            DropdownMenuItem(
                              value: 'Thrissur',
                              child: Text('Thrissur'),
                            ),
                            DropdownMenuItem(
                              value: 'Palakkad',
                              child: Text('Palakkad'),
                            ),
                            DropdownMenuItem(
                              value: 'Malappuram',
                              child: Text('Malappuram'),
                            ),
                            DropdownMenuItem(
                              value: 'Kozhikode',
                              child: Text('Kozhikode'),
                            ),
                            DropdownMenuItem(
                              value: 'wayanad',
                              child: Text('Wayanad'),
                            ),
                            DropdownMenuItem(
                              value: 'Kannur',
                              child: Text('Kannur'),
                            ),
                            DropdownMenuItem(
                              value: 'Kasaragod',
                              child: Text('Kasaragod'),
                            ),
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDistrict = newValue!;
                              _selectedDistrictControll.text= _selectedDistrict!;
                            });

                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: _studentCurrentLocationController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Current location',
                                icon: Icon(Icons.my_location_sharp),
                                hintText: 'Add your location',
                              ),
                              onTap: () async {
                                final selectedLocation = await Get.to<String>(
                                  MapScreen(
                                    onLocationSelected: (location) {
                                      return location;
                                    },
                                  ),
                                );
                                if (selectedLocation != null) {
                                  _studentCurrentLocationController.text =
                                      selectedLocation;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _studentEmailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.mail),
                              label: Text('Email id'),
                              hintText: 'Enter your email id',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              if (!value.startsWith(RegExp(
                                  r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"""))) {
                                return 'Email address not correct format';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _studentPhoneController,
                          decoration: const InputDecoration(
                            label: Text('Phone Number'),
                            icon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            hintText: 'Enter your phone number',
                          ),
                          maxLength: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if (value.isEmpty) {
                              return 'Phone number is required.';
                            }

                            if (value.length != 10) {
                              return 'Please enter a 10-digit phone number.';
                            }

                            if (!value.startsWith(RegExp(r'^[0-9]+$'))) {
                              return 'Phone number should only contain digits.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gender',
                              style: TextStyle(fontSize: 16),
                            ),
                            RadioListTile<String>(
                              title: const Text('Male'),
                              value: 'male',
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                  _selectedGenderControll.text=  _selectedGender!;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('Female'),
                              value: 'female',
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                  _selectedGenderControll.text=  _selectedGender!;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('N/A'),
                              value: 'na',
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                  _selectedGenderControll.text=  _selectedGender!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextFormField(
                          controller: dateInput,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.date_range),
                            label: Text('Date Of Birth'),
                            hintText: 'Enter your date of birth',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            } else {}
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                myAlert(context);
                              },
                              child: const Text('Upload Photo'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //if image not null show the image
                            //if image null show text
                            image != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        //to show image, you type like this.
                                        File(image!.path),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    "No Image",
                                    style: TextStyle(fontSize: 20),
                                  )
                          ],
                        ),
                      ),
                      CheckboxListTile(
                        title:
                            const Text('I agree to the terms and conditions'),
                        value: _termsChecked,
                        onChanged: (newValue) {
                          setState(() {
                            _termsChecked = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      BlocBuilder<FormBloc,FormStateSt>(
                          builder: (context,state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                  child: const Text(
                                    ('SUBMIT'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (_formStateKey.currentState!.validate()) {
                                      FormBloc().add(student?.id == null
                                          ? AddStudent( student!)
                                          : UpdateStudent( student!));
                                     }
                                  }
                                  ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                  ),
                                  ElevatedButton(
                                    child: const Text(
                                      ('CLEAR'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      _formStateKey.currentState!.reset(); // Reset the form fields
                                      dateInput.clear();
                                      _studentNameController.clear();
                                      _studentCurrentLocationController.clear();
                                      _studentPhoneController.clear();
                                      _studentAddressController.clear();
                                      _studentEmailController.clear();
                                      _selectedGenderControll.clear();
                                      _selectedDistrictControll.clear();
                                      _selectedImgeControll.clear();
                                      // Clear the dateInput field
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Form cleared'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
