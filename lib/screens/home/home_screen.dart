import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

import 'package:my_profile/config/theme.dart';
import 'package:my_profile/blocs/authentication/authentication_bloc.dart';

import '../edit/edit_screen.dart';

class UserDetail {
  String name;
  String email;
  String experiance;
  String skills;
  UserDetail({
    required this.name,
    required this.email,
    required this.experiance,
    required this.skills,
  });
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  File? _avatar;
  late UserDetail _user;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _avatar = File(pickedImage.path);
      } else {
        log('No image selected.');
      }
    });
  }

  @override
  void initState() {
    _user = UserDetail(
      name: 'Ngo Van Thanh (Nathan)',
      email: 'thanhnv58it@gmail.com',
      experiance:
          'With over seven years of experience working with Swift and UIKit, I have developed a deep understanding of these technologies. Throughout my journey, I have successfully released and managed numerous applications on the App Store, further solidifying my skills and expertise in iOS development.',
      skills: 'iOS, Android, Flutter, React-Native, KMM',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildAvatarGroup(),
                  UserInformationWidget(
                      title: "My name is",
                      detail: _user.name,
                      onEdited: (editedData) {
                        setState(() {
                          _user.name = editedData;
                        });
                      }),
                  UserInformationWidget(
                      title: "My email",
                      detail: _user.email,
                      onEdited: (editedData) {
                        setState(() {
                          _user.email = editedData;
                        });
                      }),
                  UserInformationWidget(
                      title: "My experience",
                      detail: _user.experiance,
                      onEdited: (editedData) {
                        setState(() {
                          _user.experiance = editedData;
                        });
                      }),
                  UserInformationWidget(
                      title: "My skills",
                      detail: _user.skills,
                      onEdited: (editedData) {
                        setState(() {
                          _user.skills = editedData;
                        });
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Row(
        children: [
          Lottie.asset(
            'assets/animations/login.json',
            width: 64,
            height: 64,
            repeat: true,
            reverse: false,
            animate: true,
          ),
          Text(
            "Hi there...",
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            context.loaderOverlay.show();
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted) {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            }
          },
        ),
      ],
    );
  }

  Widget _buildAvatarGroup() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            _pickImage();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildAvatarWidget(),
              ),
              const Positioned(
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor:
                      Colors.green, // Set the background color of the overlay
                  child: Icon(
                    size: 16,
                    Icons.camera_alt,
                    color: Colors.white, // Set the color of the icon
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarWidget() {
    return _avatar != null
        ? SizedBox(
            height: 80,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: FileImage(_avatar!),
            ),
          )
        : Image.asset("assets/images/avatar.png");
  }
}

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({
    super.key,
    required this.title,
    required this.detail,
    required this.onEdited,
  });

  final String title;
  final String detail;
  final Function(String) onEdited;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Set border radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Set shadow color
              spreadRadius: 3, // Set spread radius
              blurRadius: 4, // Set blur radius
              offset: const Offset(0, 3), // Set shadow offset
            ),
          ],
          color: Colors.white, // Set background color of the container
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.darkGray),
                ),
                const Spacer(),
                SizedBox(
                  height: 30,
                  child: IconButton(
                      onPressed: () async {
                        final editedData = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditScreen(
                              title: title,
                              userInfor: detail,
                            ), // Pass initial information if needed
                          ),
                        );
                        if (editedData != null) {
                          onEdited(editedData);
                        }
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                detail,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
