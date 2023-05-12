import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';
import 'package:sadeem/features/doctors/presentations/bloc/add_new_doctor/add_new_doctors_bloc.dart';
import 'package:sadeem/features/doctors/presentations/bloc/get_all_doctors/get_all_doctors_bloc.dart';
import 'package:sadeem/models/MyFiles.dart';
import 'package:sadeem/responsive.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  TextEditingController nameController = TextEditingController();
  TextEditingController specialistController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: context.read<AddNewDoctorsBloc>(),
      listener: (context, state) {
        if (state is DoneAddNewDoctorsState) {
          nameController.text = '';
          phoneController.text = '';
          specialistController.text = '';
          emailController.text = '';
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event Successfully')));

          context.read<GetAllDoctorsBloc>().add(GetAllDoctors());
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Doctors",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0))),
                    isScrollControlled: true,
                    context: context,
                    builder: (ctxt) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  TextFieldWidget(
                                    controller: nameController,
                                    hint: 'Enter Name Doctor',
                                  ),
                                  const SizedBox(height: 12),
                                  TextFieldWidget(
                                    controller: specialistController,
                                    hint: 'Enter Specialist ',
                                  ),
                                  const SizedBox(height: 12),
                                  TextFieldWidget(
                                    controller: phoneController,
                                    type: TextInputType.phone,
                                    hint: 'Enter Phone Number',
                                  ),
                                  const SizedBox(height: 12),
                                  TextFieldWidget(
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    hint: 'Enter Email Address',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      context.read<AddNewDoctorsBloc>().add(
                                          AddDoctor(DoctorInput(
                                              nameController.text,
                                              specialistController.text,
                                              phoneController.text,
                                              emailController.text)));
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 1.5,
                                        vertical: defaultPadding /
                                            (Responsive.isMobile(context)
                                                ? 2
                                                : 1),
                                      ),
                                    ),
                                    icon: const Icon(Icons.add),
                                    label: const Text("Add Doctor"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Doctor"),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          Responsive(
            mobile: FileInfoCardGridView(
              crossAxisCount: size.width < 650 ? 2 : 4,
              childAspectRatio: size.width < 650 ? 0.7 : 1,
            ),
            tablet: const FileInfoCardGridView(),
            desktop: FileInfoCardGridView(
              childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  TextInputType? type;
  final String hint;

  TextFieldWidget(
      {super.key,
      required this.controller,
      this.type = TextInputType.text,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      style: const TextStyle(color: iconColor, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        label: Text(
          hint,
          style: const TextStyle(color: iconColor, fontSize: 15),
        ),
        hintStyle: const TextStyle(color: iconColor, fontSize: 15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 0.2, color: iconColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 0.2, color: iconColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 0.2, color: iconColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 0.2, color: iconColor)),
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<GetAllDoctorsBloc>(),
      builder: (context, state) {
        if (state is LoadingGetAllDoctors) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DoneGetAllDoctors) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.doctors.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            // itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
            itemBuilder: (context, index) => FileInfoCard(
                info: CloudStorageInfo(
                    id: state.doctors[index].id,
                    email: state.doctors[index].email,
                    phone: state.doctors[index].phone,
                    title: state.doctors[index].name,
                    specialist: state.doctors[index].specialist,
                    color: primaryColor,
                    svgSrc: "assets/icons/Documents.svg")),
          );
        }
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // itemCount: demoMyFiles.length,
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: childAspectRatio,
          ),
          // itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
          itemBuilder: (context, index) => FileInfoCard(
              info: CloudStorageInfo(
                  title: 'Dr Ali',
                  specialist: 'Dr Dr Dr',
                  color: primaryColor,
                  svgSrc: "assets/icons/Documents.svg")),
        );
      },
    );
  }
}
