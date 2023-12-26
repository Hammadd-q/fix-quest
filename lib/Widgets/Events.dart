import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/EventsViewScreen.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/data/model/response/EventModel.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/Utils.dart';

class Events extends StatelessWidget {
  final EventModel event;

  const Events({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventsViewScreen(eventId: event.id,eventLink: event.event_link,)));
      },
      child: Container(
        alignment: Alignment.center, // This is needed
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          color: ColorResources.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorResources.white, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(ImagesResources.logo),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 109,
                      height: 27,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColorResources.colorPrimary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: ColorResources.white,
                            ),
                            Text(
                              event.startDate.split(' ').first,
                              style: sansRegular.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        event.title,
                        style: sansSemiBold.copyWith(
                          color: ColorResources.black,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ),
                    // Text(
                    //   "1 min ago",
                    //   style: sansSemiBold.copyWith(
                    //     color: ColorResources.colorPrimary,
                    //     fontSize: Dimensions.fontSizeSmall,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
                width: double.infinity,
              ),
              // Container(
              //   padding: EdgeInsets.all(20),
              //   child: Text(
              //     "Lorem: Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
              //     overflow: TextOverflow.ellipsis,
              //     maxLines: 2,
              //     style: sansRegular.copyWith(
              //       color: ColorResources.black,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
