import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FrequentlyQuestionPage extends StatelessWidget {
  const FrequentlyQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: _buildContent(theme),
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
        title: Text(
          " Frequently Question",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildContent(ThemeData theme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                '''
                
If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.
 ''',
                style: theme.textTheme.bodySmall!.copyWith(fontSize: 14.sp),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );
}
