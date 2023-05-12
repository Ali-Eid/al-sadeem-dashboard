import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sadeem/features/doctors/domain/repository/doctor_repository.dart';
import 'package:sadeem/features/doctors/presentations/bloc/add_new_doctor/add_new_doctors_bloc.dart';
import 'package:sadeem/models/MyFiles.dart';
import 'package:sadeem/responsive.dart';
import 'package:sadeem/screens/dashboard/components/my_files.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class FileInfoCard extends StatefulWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  State<FileInfoCard> createState() => _FileInfoCardState();
}

class _FileInfoCardState extends State<FileInfoCard> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _emailSend(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'We Are Al-Sadeem Company',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                icon: const Icon(
                  Icons.more_vert,
                  color: iconColor,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'update':
                      showModalBottomSheet(
                          useSafeArea: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          isScrollControlled: true,
                          context: context,
                          builder: (ctxt) {
                            return BlocProvider.value(
                              value: context.read<AddNewDoctorsBloc>(),
                              child: UpdateWidget(
                                id: widget.info.id ?? 0,
                                name: widget.info.title ?? 'unknown',
                                email: widget.info.email ?? 'unknown',
                                phone: widget.info.phone ?? 'unknown',
                                specialist: widget.info.specialist ?? 'unknown',
                              ),
                            );
                          });
                      break;
                    case 'delete':
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          context: context,
                          builder: (ctxt) {
                            return Column(
                              children: [
                                const Text(
                                  'Are you sure you want delete this Doctor ? ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('cancel')),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<AddNewDoctorsBloc>()
                                                .add(DeleteDoctor(
                                                    widget.info.id ?? 0));
                                          },
                                          child: const Text('confirm'))
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                      break;
                    default:
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'update',
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: iconColor,
                          ),
                          SizedBox(width: 5),
                          Text('update')
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Text('delete')
                        ],
                      ),
                    ),
                  ];
                },
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: widget.info.color!.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset(
              widget.info.svgSrc!,
              colorFilter: ColorFilter.mode(
                  widget.info.color ?? Colors.black, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.info.title!,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.info.title!,
            maxLines: 1,
            style: const TextStyle(fontSize: 12, color: iconColor),
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await _makePhoneCall(widget.info.phone ?? '');
                },
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.call,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  await _emailSend(widget.info.email ?? '');
                },
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.blue, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.email,
                    size: 15,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UpdateWidget extends StatefulWidget {
  final String name;
  final String specialist;
  final String phone;
  final String email;
  final int id;
  const UpdateWidget({
    super.key,
    required this.name,
    required this.specialist,
    required this.phone,
    required this.email,
    required this.id,
  });

  @override
  State<UpdateWidget> createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController specialistController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    specialistController.text = widget.specialist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: nameController,
                  hint: 'Name Doctor',
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: specialistController,
                  hint: 'Specialist ',
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: phoneController,
                  type: TextInputType.phone,
                  hint: 'Phone Number',
                ),
                const SizedBox(height: 12),
                TextFieldWidget(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  hint: 'Email Address',
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
                          UpdateDoctor(
                              DoctorInput(
                                  nameController.text,
                                  specialistController.text,
                                  phoneController.text,
                                  emailController.text),
                              widget.id),
                        );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
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
  }
}
