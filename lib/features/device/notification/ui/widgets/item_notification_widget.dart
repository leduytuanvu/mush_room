import 'package:flutter/material.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_state.dart';
import 'package:sizer/sizer.dart';

class ItemNotificationWidget extends StatelessWidget {


  const ItemNotificationWidget({

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomBarBloc = injector<BottomBarBloc>(); // Get bloc from injector
    return StreamBuilder<BottomBarState>(
      stream: bottomBarBloc.stream, // Listen to bloc's state stream
      builder: (context, snapshot) {
        int currentIndex = 0; // Default value
        if (snapshot.hasData && snapshot.data is TabState) {
          currentIndex = (snapshot.data as TabState).currentIndex;
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 14, right: 3, left: 3),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
              BoxShadow(
              color: Colors.grey, // Color of the shadow
              offset: Offset(1, 1), // Offset of the shadow (x, y)
              blurRadius: 3.0,   // Blur radius
              spreadRadius: 0.0, // Spread radius
            ),
            ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Device name 1", style: theme.textTheme.bodySmall,),
                    Text("20/10/2022", style: theme.textTheme.bodySmall,),
                  ],),
                  const SizedBox(height: 6),
                  Text("Status of device", style: theme.textTheme.bodySmall!.copyWith(color: Colors.black, fontSize: 11.sp),),
                  const SizedBox(height: 2),
                  Text("Device connected", style: theme.textTheme.displaySmall!.copyWith(color: Colors.black, fontSize: 11.sp),),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
