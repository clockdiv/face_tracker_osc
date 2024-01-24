import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGrey6,
      padding: const EdgeInsets.only(
        top: 96,
        left: 16,
        right: 16,
        bottom: 32,
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.,

            children: [
              Text(
                'About',
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Container(
                  color: CupertinoColors.white,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        //          const SizedBox(height: 20),
                        Text(
                          'Developed at the "Digital Lab" as part of the "Ernst Busch" Academy of Dramatic Arts in Berlin/Germany. The "Digital Lab" was funded by "Stiftung Innovation in der Hochschullehre".',
                          style: TextStyle(
                              color: CupertinoColors.black, fontSize: 12),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Although there are several similar apps in the App Store, we wanted to have a simple face tracking app that sends tracking features to a network device via OSC. We use it to control software synthesizers, animations in Blender or physical actuators like servo motors in puppets.',
                          style: TextStyle(
                              color: CupertinoColors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              SizedBox(
                // color: CupertinoColors.activeBlue,
                width: double.infinity,
                child: SvgPicture.asset('assets/logos/Logo_ErnstBusch.svg',
                    width: 240),
              ),
              const SizedBox(height: 40),
              SizedBox(
                // color: CupertinoColors.activeGreen,
                width: double.infinity,
                child: SvgPicture.asset(
                    'assets/logos/Logo_LaborFuerDigitalitaet.svg',
                    width: 120),
              ),
              const SizedBox(height: 40),
              SizedBox(
                // color: CupertinoColors.activeOrange,
                width: double.infinity,
                child: SvgPicture.asset(
                    'assets/logos/Logo_StiftungHochschullehre.svg',
                    width: 160),
              ),
              const SizedBox(height: 40),
              const Text(
                'MIT License, Copyright (c) 2024',
                style: TextStyle(color: CupertinoColors.black, fontSize: 12),
              ),
              const Text(
                'Hochschule für Schauspielkunst Ernst Busch',
                style: TextStyle(color: CupertinoColors.black, fontSize: 12),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                    text: 'github.com/clockdiv/face_tracker_osc',
                    style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 12,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Uri url = Uri.https(
                            'github.com', '/clockdiv/face_tracker_osc');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                    text: 'hfs-berlin.de',
                    style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 12,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Uri url = Uri.https('hfs-berlin.de');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
