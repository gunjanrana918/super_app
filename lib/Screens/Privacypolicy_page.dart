import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Privacyscreen extends StatelessWidget {
  const Privacyscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Privacy Policy"),
          backgroundColor: const Color(0xFF184f8d),
        ),
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(14.0),
              child: ReadMoreText("Gateway Distriparks Limited (henceforth referred as ‘GDL’) is committed to protecting the privacy and security of your information. The protection of your privacy in the processing of your personal data is an important concern to which we pay special attention during our business processes. We process personal data collected during visits to our websites according to the legal provisions valid for the countries in which the websites are maintained. This privacy notice describes the information about you that GDL collects through this site, how that information is used, maintained, shared, protected and how you can update it. It also applies to all personal data received by GDL from the European Economic Area (“EEA”) in any format, including electronic or paper. "
                 "It is effective on the date posted below and applies to our use of your information after that date.",
                style: TextStyle(fontSize: 15),
                trimLines: 2,
                colorClickableText: Colors.blue,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Length,
                trimCollapsedText: '.....Show more',
                trimExpandedText: '.....Show less',
                lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
            ),
            //Padding(padding: EdgeInsets.only(top: 3.0)),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("PERSONAL DATA WE COLLECT ABOUT YOU",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("We collect personal data from you, for example, if you register for an event, request information, product or use our services, or request customer support. We may ask you to provide information such as your name, address, zip code, phone number, email address, job title, IP Address, and information about your device. "
    "Not all of the personal data GDLholds about you, will always come directly from you. It may, for example, come from your employer, other organizations to which you belong, or a professional service provider such as your tax or accounting professional or attorney, if they use our Services. However, GDLcollects Personal data about you when you interact with this site and/or utilize services offered on this site. For example:"
    "If you apply for a job or other staffing opportunity through this site, you will be asked to submit your resume and as well as other contact information such as your email address, phone number and mailing address. We will use this information to consider you for the job opening that you specify. We may also use this information to contact you regarding other staffing opportunities,"
    "both opportunities advertised on this site.",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("HOW WE USE YOUR PERSONAL DATA",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("We can only use your personal data if we have a proper reason for doing so. According to the law, we can only use your data for one or more of these reasons:"
                  "To fulfil a contract, we have with you, or If we have a legal duty to use your data for a particular reason, orWhen you consent to it, or When it is in our legitimate interests."
    "Legitimate interests are our business or commercial reasons for using your data, but even so, we will not unfairly put our legitimate interests above what is best for you."
    "The use of your information is subject to the privacy notice in effect at the time of our use. GDL uses information provided to us for our general business use. This may include the following purposes:"
   " To respond to your requests;"
    "To provide services to you including customer services issues;"
    "To send communications to you about our or our affiliates’ current services, new services or promotions that we are developing, and opportunities that may be available to you;"
    "To alert you to new features or enhancements to our services;"
   " To communicate with you about job or career opportunities about which you have inquired;"
    "To ensure that our site and our services function in an effective manner for you;"
    "To measure or understand the effectiveness of advertising and outreach..",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("WHEN WE SHARE PERSONAL DATA",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("GDL shares or discloses personal data when necessary to provide services or conduct our business operations.GDL may, with your consent, disclose information about you to unaffiliated third-party customers of GDL in connection with your application for staffing opportunities advertised on this site, "
                      "or in connection with opportunities advertised on a website of one of our affiliates",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("WHERE WE STORE AND PROCESS PERSONAL DATA",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("GDL is a global organization, and your personal data may be stored and processed outside. We take steps to ensure that the information we collect is processed according to this Privacy notice and the requirements of applicable law wherever the data is located. GDL has networks, databases, servers, systems, support, and help desks located throughout our offices around the world. We collaborate with third parties such as cloud hosting services, suppliers, and technology support located around the world to serve the needs of our business, workforce, and customers. We take appropriate steps to ensure that personal data is processed, secured, and transferred according to applicable law. "
                      "In some cases, we may need to disclose or transfer your personal data within GDL or to third parties",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("HOW WE SECURE PERSONAL DATA",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("GDL takes data security seriously, and we use appropriate technologies and procedures to protect personal information. "
                      "Our information security policies and procedures are closely aligned with widely accepted international standards and "
                      "are reviewed regularly and updated as necessary to meet our business needs, changes in technology, and regulatory requirements",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("YOUR RIGHTS AND YOUR PERSONAL DATA",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("We respect your right to access and control your information, and we will respond to requests for information and, where applicable, will correct, amend, or delete your personal information. In such cases, "
                      "we will need you to respond with proof of your identity before you can exercise rights,",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("HOW LONG DO WE KEEP YOUR PERSONAL DATA?",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("We retain personal information for as long as we reasonably require it for legal or business purposes. In determining data retention periods, "
                      "GDL takes into consideration local laws, contractual obligations, and the expectations and requirements of our customers. When we no longer need personal information, "
                      "we securely delete or destroy it",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("CHANGES TO OUR PRIVACY NOTICE",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ReadMoreText("GDL may update privacy notice from time to time. We encourage you to check our site frequently to see the current privacy notice so that you may stay informed of how GDL is using and protecting your information. "
                      "Whenever a change to this notice is significant, we will place a prominent notice on this site and provided an updated effective date",
                    style: TextStyle(fontSize: 15),
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: '.....Show more',
                    trimExpandedText: '.....Show less',
                    lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                  Text("CONTACT INFORMATION",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // color: Colors.white,
                      // backgroundColor: Color(0xFF184f8d),
                      fontWeight: FontWeight.w700,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child:
                  Column(
                    children: [
                      Text("If you have questions or comments regarding this privacy notice, please contact us, or at:",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          // color: Colors.white,
                          // backgroundColor: Color(0xFF184f8d),
                          //fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Address :" "  Gateway Distriparks Limited, Sector-6, Dronagiri, Taluka Uran, District Raigad, Navi Mumbai - 400707",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          // color: Colors.white,
                          // backgroundColor: Color(0xFF184f8d),
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Phone: +91 (22) 27246500",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              // color: Colors.white,
                              // backgroundColor: Color(0xFF184f8d),
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Email: dpo@gateway-distriparks.com",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              // color: Colors.white,
                              // backgroundColor: Color(0xFF184f8d),
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
