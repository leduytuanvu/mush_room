import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/register/ui/pages/privacy_policy_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/terms_of_service.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(color: Colors.black),
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Sign Up",
              style: textTheme.titleMedium,
            ),
            SizedBox(height: 6),
            Text(
              "Enter your credentials to continue",
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            Text(
              "Username",
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 60),
            Text(
              "Email",
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 60),
            Text(
              "Password",
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 60),
            Wrap(
              children: [
                Text(
                  "By continuing you agree to our ",
                  style: textTheme.bodyMedium,
                ),
                GestureDetector(
                  onTap: () {
                    appNavigation(context, TermsOfServicePage());
                  },
                  child: Text(
                    "Terms of Service",
                    style: textTheme.bodyMedium!
                        .copyWith(color: AppConstants.linkColor),
                  ),
                ),
                Text(
                  " and ",
                  style: textTheme.bodyMedium,
                ),
                SizedBox(height: 22),
                GestureDetector(
                  onTap: () {
                    appNavigation(context, PrivacyPolicyPage());
                  },
                  child: Text(
                    "Privacy Policy",
                    style: textTheme.bodyMedium!
                        .copyWith(color: AppConstants.linkColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            MushRoomButtonWidget(label: "Sign Up", onPressed: () {}),
            SizedBox(height: 20),
            Center(
              child: Wrap(
                children: [
                  Text(
                    "Already have an account? ",
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    "Sign In",
                    style: textTheme.bodyMedium!
                        .copyWith(color: AppConstants.linkColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
