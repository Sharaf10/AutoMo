import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/option.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';

class PrivacyPolicyPage extends StatefulWidget {
  User user;

  PrivacyPolicyPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState(user: user);
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  late User user;

  _PrivacyPolicyPageState({required this.user});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kButtonColor,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Option(user: user),
              ));
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Privacy Policy',
              style: kPageHeading,
            ),
            const SizedBox(height: 12),
            buildPolicyCard(),
            buildInfoCard(),
            buildCookieCard(),
            buildServiceCard(),
            buildSecurityCard(),
            buildLinkCard(),
            buildChildCard(),
            buildChangesCard(),
            buildContactCard(),
          ],
        ),
      );

  Widget buildPolicyCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "I built the AutoMo app as a Free app. This SERVICE is provided by me at no cost and is intended for use as is.This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at AutoMo unless otherwise defined in this Privacy Policy.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );

  Widget buildInfoCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Information Collection and Use',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to Name, Email Address, Photos from Gallery. The information that we request will be retained by us and used as described in this privacy policy.The app does use third party services that may collect information used to identify you.Link to privacy policy of third party service providers used by the app",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              Text(
                "Firebase Crashlytics",
                style: kFAQbodyText,
                textAlign: TextAlign.center,
              ),
              Text(
                "Log Data",
                style: kFAQbodyText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                "We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );

  Widget buildCookieCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cookie',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              Text(
                "This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device.",
                textAlign: TextAlign.justify,
                style: kFAQbodyText,
              ),
              const SizedBox(height: 4),
              Text(
                "If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );

  Widget buildServiceCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Service Providers',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "We may employ third-party companies and individuals due to the following reasons:",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              Text(
                "To facilitate our Service;",
                style: kFAQbodyText,
                textAlign: TextAlign.left,
              ),
              Text(
                "To provide the Service on our behalf;",
                style: kFAQbodyText,
                textAlign: TextAlign.left,
              ),
              Text(
                "To perform Service-related services; or",
                style: kFAQbodyText,
                textAlign: TextAlign.left,
              ),
              Text(
                "To assist us in analyzing how our Service is used.",
                style: kFAQbodyText,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 6),
              Text(
                "We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );

  Widget buildSecurityCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              Text(
                "But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.",
                textAlign: TextAlign.justify,
                style: kFAQbodyText,
              ),
            ],
          ),
        ),
      );

  Widget buildLinkCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Links to Other Sites',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              Text(
                "Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.",
                textAlign: TextAlign.justify,
                style: kFAQbodyText,
              ),
            ],
          ),
        ),
      );

  Widget buildChildCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Children’s Privacy',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              Text(
                "In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.",
                textAlign: TextAlign.justify,
                style: kFAQbodyText,
              ),
            ],
          ),
        ),
      );

  Widget buildChangesCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Changes to This Privacy Policy',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 4),
              Text(
                "We will notify you of any changes by posting the new Privacy Policy on this page.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 3),
              Text(
                "This policy is effective as of 2021-03-23. ",
                textAlign: TextAlign.justify,
                style: kFAQbodyText,
              ),
            ],
          ),
        ),
      );

  Widget buildContactCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Us',
                style: kheadingText,
              ),
              const SizedBox(height: 8),
              Text(
                "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at Mohamed.Kiyasdeen@study.beds.ac.uk.",
                style: kFAQbodyText,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );
}
