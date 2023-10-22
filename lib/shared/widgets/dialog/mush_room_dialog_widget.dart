import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';

class MushRoomDialogWidget extends StatelessWidget {
  final Widget image;
  final String title;
  final String titleButton1;
  final String titleButton2;
  final Function()? function1;
  final Function()? function2;
  final Function()? functionClose;

  const MushRoomDialogWidget({
    Key? key,
    this.image = const SizedBox.shrink(),
    this.title = "",
    this.titleButton1 = "",
    this.titleButton2 = "",
    this.function1,
    this.function2,
    this.functionClose,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          GestureDetector(child: Container(
            color: Colors.transparent,
          ), onTap: functionClose,),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 8.0,
                    color: Colors.black45,
                  ),
                ],
              ),
              width: screenWidth * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Use min to let the Column size itself
                  children: [
                    (titleButton1.isNotEmpty || titleButton2.isNotEmpty)
                        ? Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(onTap: functionClose,child: Icon(Icons.close)),
                    )
                        : SizedBox.shrink(),
                    image,
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(title, style: theme.textTheme.titleSmall),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          if (titleButton1.isNotEmpty)
                            Expanded(
                              child: MushRoomButtonWidget(label: titleButton1, onPressed: function1!),
                            ),
                          SizedBox(width: 8),
                          if (titleButton2.isNotEmpty)
                            Expanded(
                              child: MushRoomButtonWidget(label: titleButton2, onPressed: function2!),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
