import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Widgets/GlobalAppBar.dart';
import 'package:hip_quest/Widgets/PrimaryButton.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:provider/provider.dart';
import '../util/ImagesResources.dart';
import 'Screens.dart';

class EventsViewScreen extends StatefulWidget {
  static String routeKey = '/eventsview';
  final int eventId;
  final String eventLink;

  const EventsViewScreen(
      {Key? key, required this.eventId, required this.eventLink})
      : super(key: key);

  @override
  State<EventsViewScreen> createState() => _EventsViewScreenState();
}

class _EventsViewScreenState extends State<EventsViewScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false)
          .getSingleEvent(context, widget.eventId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Event'),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Consumer<EventProvider>(builder: (_, data, __) {
          if (data.event == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.colorPrimary,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: ColorResources.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              ImagesResources.logo,
                              color: ColorResources.grey,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                width: 120,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: ColorResources.colorPrimary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: ColorResources.white,
                                      ),
                                      Text(
                                        data.event?.startDate
                                                .split(' ')
                                                .first ??
                                            '',
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
                          width: 340,
                          child: Text(
                            "Upcoming Event",
                            style: sansLight.copyWith(
                              color: ColorResources.colorPrimary,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 340,
                          child: Text(
                            data.event?.title ?? '',
                            style: sansSemiBold.copyWith(
                              color: ColorResources.black,
                              fontSize: Dimensions.fontSizeMaximum * 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Html(
                          shrinkWrap: true,
                          data: data.event?.body ?? '',
                          style: {
                            'p': Style(
                                margin: Margins.only(
                                    left: 0, top: 0, right: 0, bottom: 2)),
                          },
                        ),
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: PrimaryButton(
                            onPress: () {
                              print(widget.eventLink);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebviewScreen(
                                      url: widget.eventLink,
                                      title: 'Book Event',
                                    ),
                                  ));
                            },
                            text: "Book Now",
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
