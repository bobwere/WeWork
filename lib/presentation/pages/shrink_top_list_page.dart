import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/common/constants.dart';
import 'package:we_work/infrastructure/model/worker_details.dart';
import 'package:we_work/bloc/worker_details/worker_details_cubit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:we_work/presentation/widgets/animated_card.dart';
import 'package:we_work/presentation/pages/workers_details_page.dart';
import 'package:we_work/presentation/widgets/image_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController = ScrollController();
  List<Image> characters = [];

  @override
  void initState() {
    characters.addAll([
      Image.asset("assets/images/toyface_1.png"),
      Image.asset("assets/images/toyface_2.png"),
      Image.asset("assets/images/toyface_3.png"),
      Image.asset("assets/images/toyface_4.png"),
      Image.asset("assets/images/toyface_5.png"),
      Image.asset("assets/images/toyface_6.png"),
      Image.asset("assets/images/toyface_7.png"),
      Image.asset("assets/images/toyface_8.png"),
    ]);

    scrollController = ScrollController();
    context.read<WorkerDetailsCubit>().fetchAllWorkersDetails();

    for (var character in characters) {
      precacheImage(character.image, context);
    }
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WorkerDetailsCubit, WorkerDetailState>(
          builder: (context, state) {
            return state.map(
                initial: (_) => buildLoadingWidget(),
                loading: (_) => buildLoadingWidget(),
                success: (data) => buildLoadedWidget(data.listOfWorkerDetails),
                failure: (message) =>
                    buildErrorWidget(context, message.failure));
          },
        ),
      ),
    );
  }

  Widget buildLoadingWidget() {
    return Container(
      child: Center(
        child:
            SizedBox(height: 30, width: 30, child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildErrorWidget(BuildContext context, String message) {
    final workerCubit = BlocProvider.of<WorkerDetailsCubit>(context);
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            workerCubit.fetchAllWorkersDetails();
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            height: 50,
            width: 500,
            decoration: BoxDecoration(
              color: Color(0xFFF37F2C),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoadedWidget(List<WorkerDetails> workerDetailsList) {
    return AnimationLimiter(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(child: ImageSlider()),
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Our Employees',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 10,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final workerDetail = workerDetailsList[index];
              var hexCodes = [];
              var hexCodeIndex = 0;
              var images = [];
              var imagesIndex = 0;

              for (var i = 0; i < workerDetailsList.length; i++) {
                hexCodes.add(hexColors[hexCodeIndex]);
                hexCodeIndex++;
                if (hexCodeIndex == hexColors.length) {
                  hexCodeIndex = 0;
                }
              }

              for (var i = 0; i < workerDetailsList.length; i++) {
                images.add(characters[imagesIndex]);
                imagesIndex++;
                if (imagesIndex == characters.length) {
                  imagesIndex = 0;
                }
              }

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkersDetailsPage(
                              workerDetails: workerDetail,
                            ),
                          ),
                        );
                      },
                      child: AnimatedCard(
                        controller: scrollController,
                        image: images[index],
                        index: index,
                        hexCode: hexCodes[index],
                        workerDetail: workerDetail,
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: workerDetailsList.length),
          )
        ],
      ),
    );
  }
}
