import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:we_work/bloc/worker_details/worker_details_cubit.dart';
import 'package:we_work/bloc/worker_details_update/worker_details_update_cubit.dart';
import 'package:we_work/infrastructure/model/worker_details.dart';

class WorkersDetailsPage extends StatefulWidget {
  const WorkersDetailsPage({Key? key, required this.workerDetails})
      : super(key: key);

  final WorkerDetails workerDetails;

  @override
  State<WorkersDetailsPage> createState() => _WorkersDetailsPageState();
}

class _WorkersDetailsPageState extends State<WorkersDetailsPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController occupationTextEditingController =
      TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();
  @override
  void initState() {
    nameTextEditingController.text = widget.workerDetails.name ?? '';
    emailTextEditingController.text = widget.workerDetails.email ?? '';
    occupationTextEditingController.text =
        widget.workerDetails.occupation ?? '';
    bioTextEditingController.text = widget.workerDetails.bio ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkerDetailsUpdateCubit, WorkerDetailUpdateState>(
      listener: (context, state) {
        state.maybeWhen(
            failure: (data) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(data),
                  ),
                ),
            success: () {
              context.read<WorkerDetailsCubit>().updateAllWorkersDetails(
                  workerDetails: widget.workerDetails.copyWith.call(
                      name: nameTextEditingController.text,
                      email: emailTextEditingController.text,
                      bio: bioTextEditingController.text,
                      occupation: occupationTextEditingController.text));
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content:
                      Text('You have succcessfully updated employee details'),
                ),
              );
            },
            orElse: () => null);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: AnimationLimiter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Employee Details',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: nameTextEditingController,
                              decoration:
                                  InputDecoration(hintText: 'e.g Jane Doe'),
                              style: TextStyle(),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: emailTextEditingController,
                              decoration: InputDecoration(
                                  hintText: 'e.g bobwere47@gmail.com'),
                              style: TextStyle(),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Occupation',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: occupationTextEditingController,
                              decoration:
                                  InputDecoration(hintText: 'e.g ML Engineer'),
                              style: TextStyle(),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Bio',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: bioTextEditingController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  hintText:
                                      'e.g software developer by day, designer by night'),
                              style: TextStyle(),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: MaterialButton(
                                    color: Color(0xFFF37F2C),
                                    child: Center(
                                      child: BlocBuilder<
                                              WorkerDetailsUpdateCubit,
                                              WorkerDetailUpdateState>(
                                          builder: (context, state) {
                                        return state.maybeWhen(
                                            loading: () => Center(
                                                  child: SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      )),
                                                ),
                                            orElse: () => Text(
                                                  'Update employee details',
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ));
                                      }),
                                    ),
                                    onPressed: () {
                                      if (nameTextEditingController
                                              .text.isNotEmpty &&
                                          emailTextEditingController
                                              .text.isNotEmpty &&
                                          bioTextEditingController
                                              .text.isNotEmpty &&
                                          occupationTextEditingController
                                              .text.isNotEmpty) {
                                        context
                                            .read<WorkerDetailsUpdateCubit>()
                                            .updateWorkersDetail(
                                                id: widget.workerDetails.id ??
                                                    0,
                                                bio: bioTextEditingController
                                                    .text,
                                                email:
                                                    emailTextEditingController
                                                        .text,
                                                name: nameTextEditingController
                                                    .text,
                                                occupation:
                                                    occupationTextEditingController
                                                        .text);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                                'Kindly fill all the inputs in order to proceed'),
                                          ),
                                        );
                                      }
                                    }),
                              )),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
