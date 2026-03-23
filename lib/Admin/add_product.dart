import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../services/database.dart';
import '../widgets/support_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  String? value;
  bool isUploading = false;

  final List<String> clothingCategory = ['T-Shirt', 'Pant', 'Dress', 'Jacket'];

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  uploadItem() async {
    if (selectedImage != null &&
        nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        detailController.text.isNotEmpty &&
        value != null) {
      setState(() => isUploading = true);

      try {
        String addId = randomAlphaNumeric(10);

        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child("productImages")
            .child(addId);

        final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
        var downloadUrl = await (await task).ref.getDownloadURL();

        // B. Prepare Product Map with the Image URL
        Map<String, dynamic> addProduct = {
          "Image": downloadUrl,
          "Name": nameController.text.trim(),
          "Price": priceController.text.trim(),
          "Category": value,
          "Detail": detailController.text.trim(),
        };

        await DatabaseMethods().addProducts(addProduct);

        if (!mounted) return;
        setState(() {
          selectedImage = null;
          nameController.clear();
          priceController.clear();
          detailController.clear();
          value = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Product Added Successfully!"),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      } finally {
        if (mounted) setState(() => isUploading = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Please fill all fields and select an image"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xff6e5038),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.arrow_back, color: Color(0xff6e5038)),
                    ),
                    SizedBox(width: 20.0),
                    Text("Add Product", style: AppWidget.whiteTextstyle(25)),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Product Image",
                  style: AppWidget.boldTextstyle(22),
                ),
              ),
              const SizedBox(height: 10.0),

              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: selectedImage == null
                      ? Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            selectedImage!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20.0),
              _buildLabel("Product Name"),
              _buildInputField(nameController, "Enter Name"),

              const SizedBox(height: 20.0),
              _buildLabel("Product Price"),
              _buildInputField(priceController, "Enter Price", isNumber: true),

              const SizedBox(height: 20.0),
              _buildLabel("Product Category"),
              _buildDropdown(),

              const SizedBox(height: 20.0),
              _buildLabel("Product Detail"),
              _buildInputField(
                detailController,
                "Enter Product Detail",
                isMultiline: true,
              ),

              SizedBox(height: 40.0),

              Center(
                child: GestureDetector(
                  onTap: isUploading ? null : uploadItem,
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff6e5038),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Center(
                      child: Text("Add", style: AppWidget.whiteTextstyle(20)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(text, style: AppWidget.boldTextstyle(22)),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
    bool isMultiline = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(59, 158, 158, 158),
        borderRadius: BorderRadius.circular(isMultiline ? 20 : 60),
      ),
      child: TextField(
        controller: controller,
        maxLines: isMultiline ? 5 : 1,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(59, 158, 158, 158),
        borderRadius: BorderRadius.circular(60),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: clothingCategory
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
              )
              .toList(),
          onChanged: (newValue) => setState(() => value = newValue),
          dropdownColor: Colors.white,
          hint: const Text("Select Category"),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        ),
      ),
    );
  }
}
