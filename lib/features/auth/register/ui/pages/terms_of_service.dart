import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Terms Of Service",
            style: textTheme.titleSmall!.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color of the back icon
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  '''
1. Terms
By accessing this Website, accessible from https://combros.vn/, you are agreeing to be bound by these Website Terms and Conditions of Use and agree that you are responsible for the agreement with any applicable local laws. If you disagree with any of these terms, you are prohibited from accessing this site. The materials contained in this Website are protected by copyright and trade mark law.

2. Use License
Permission is granted to temporarily download one copy of the materials on Combros's Website for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not
This will let Combros to terminate upon violations of any of these restrictions. Upon termination, your viewing right will also be terminated and you should destroy any downloaded materials in your possession whether it is printed or electronic format. These Terms of Service has been created with the help of the Terms Of Service Generator.

3. Disclaimer
All the materials on Combros's Website are provided "as is". Combros makes no warranties, may it be expressed or implied, therefore negates all other warranties. Furthermore, Combros does not make any representations concerning the accuracy or reliability of the use of the materials on its Website or otherwise relating to such materials or any sites linked to this Website.

4. Limitations
Combros or its suppliers will not be held accountable for any damages that will arise with the use or inability to use the materials on Combros's Website, even if Combros or an authorized representative of this Website has been notified, orally or written, of the possibility of such damage. Some jurisdictions do not allow limitations on implied warranties or limitations of liability for incidental damages, these limitations may not apply to you.

5. Revisions and Errata
The materials appearing on Combros's Website may include technical, typographical, or photographic errors. Combros will not promise that any of the materials in this Website are accurate, complete, or current. Combros may change the materials contained on its Website at any time without notice. Combros does not make any commitment to update the materials.

6. Links
Combros has not reviewed all of the sites linked to its Website and is not responsible for the contents of any such linked site. The presence of any link does not imply endorsement by Combros of the site. The use of any linked website is at the user's own risk.

7. Site Terms of Use Modifications
Combros may revise these Terms of Use for its Website at any time without prior notice. By using this Website, you are agreeing to be bound by the current version of these Terms and Conditions of Use.

8. Your Privacy
Please read our Privacy Policy.

9. Governing Law
Any claim related to Combros's Website shall be governed by the laws of af without regards to its conflict of law provisions.
  ''',
                  style: textTheme.bodyMedium,
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
