import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSettings extends StatefulWidget {
  ScreenSettings({super.key});

  // String _ipAdress = "192.168.4.1";
  // String _port = "3333";

  // void set ip(String ip) {
  //   _ipAdress = ip;
  //   developer.log("new ip is: $_ipAdress");
  // }

  // void set port(String port) {
  //   _port = port;
  // }

  // String get ip => _ipAdress;
  // String get port => _port;

  @override
  State<ScreenSettings> createState() {
    return _ScreenSettingsState();
  }
}

class _ScreenSettingsState extends State<ScreenSettings> {
  Color _textBorderIpAdress = CupertinoColors.systemGrey5.withAlpha(0);
  Color _textBorderPort = CupertinoColors.systemGrey5.withAlpha(0);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _ipAddress;
  late Future<String> _port;
  late Future<bool> _showHelp;
  late Future<bool> _showFeatures;
  bool showHelp = true;
  bool showFeatures = true;

  late TextEditingController _ipTextController =
      TextEditingController(text: ("waiting for ip..."));
  late TextEditingController _portTextController =
      TextEditingController(text: ("waiting for port..."));

  // bool _showAllFeatures = true;
  final FocusNode _focusNodeIPTextfield = FocusNode();
  final FocusNode _focusNodePortTextfield = FocusNode();

  // _ScreenSettingsState() {
  //   _ipTextController = TextEditingController(text: (widget.ip));
  //   _portTextController = TextEditingController(text: (widget.port));
  // }
  @override
  void initState() {
    super.initState();
    _readPrefs();
  }

  void _readPrefs() {
    developer.log('\n\nreadPrefs');
    _ipAddress = _prefs.then((SharedPreferences prefs) {
      String ip = prefs.getString('ip') ?? '192.168.0.100';
      _ipTextController.text = ip;
      developer.log('Read Prefs, ip = $ip');
      return ip;
    });
    _port = _prefs.then((SharedPreferences prefs) {
      String port = prefs.getString('port') ?? '4444';
      _portTextController.text = port;
      developer.log('Read Prefs, port = $port');
      return port;
    });

    // _prefs.then((SharedPreferences prefs) {
    //   _showFeatures = prefs.getBool('showFeatures') ?? true;
    //   _showHelp = prefs.getBool('showHelp') ?? true;
    //   developer.log('Read Prefs in initState, showFeatures = $_showFeatures');
    //   developer.log('Read Prefs in initState, showHelp = $_showHelp');
    // });
    _showFeatures = _prefs.then((SharedPreferences prefs) {
      setState(() {
        showFeatures = prefs.getBool('showFeatures') ?? true;
      });
      developer.log('Read Prefs, showFeatures = $showFeatures');
      return showFeatures;
    });
    _showHelp = _prefs.then((SharedPreferences prefs) {
      setState(() {
        showHelp = prefs.getBool('showHelp') ?? true;
      });
      developer.log('Read Prefs, showHelp = $showHelp');
      return showHelp;
    });
  }

  Future<void> _setIpAddress() async {
    final SharedPreferences prefs = await _prefs;
    developer.log("setting ip address in Future<void>...");
    final String ip = _ipTextController.text.toString();

    setState(() {
      _ipAddress = prefs.setString('ip', ip).then((value) => ip);
    });
  }

  Future<void> _setPort() async {
    final SharedPreferences prefs = await _prefs;
    developer.log("setting port in Future<void>...");
    final String port = _portTextController.text.toString();

    setState(() {
      _port = prefs.setString('port', port).then((value) => port);
    });
  }

  Future<void> _toggleShowFeatures(bool value) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setBool('showFeatures', value).then((value) => value);
    });
    _readPrefs();
    developer.log('set showFeatures to $value');
  }

  Future<void> _toggleShowHelp(bool value) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setBool('showHelp', value).then((value) => value);
    });
    _readPrefs();
    developer.log('set showHelp to $value');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGrey6,
      padding: const EdgeInsets.only(
        top: 96,
        left: 0,
        right: 0,
        bottom: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Text(
              'Settings',
              style:
                  CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
          ),

          /* ------------------------------------------------------- */
          /* --- Network Settings ---------------------------------- */
          /* ------------------------------------------------------- */
          CupertinoListSection.insetGrouped(
            // header: Text(
            //   'NETWORK SETTINGS',
            // ),

            children: [
              CupertinoListTile(
                padding: const EdgeInsets.all(16),
                title: const Text('IP-Address'),
                subtitle: const Text('IP of the Receiver'),
                trailing: SizedBox(
                  width: 140,
                  child: CupertinoTextField(
                    focusNode: _focusNodeIPTextfield,
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: _textBorderIpAdress),
                    ),
                    controller: _ipTextController,
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.right,
                    maxLength: 15,
                    onTap: () {
                      setState(() {
                        _textBorderIpAdress = CupertinoColors.systemGrey5;
                        _textBorderPort =
                            CupertinoColors.systemGrey5.withAlpha(0);
                      });
                    },
                    onSubmitted: (ipadress) {
                      setState(() {
                        _textBorderIpAdress =
                            CupertinoColors.systemGrey5.withAlpha(0);
                      });
                      _setIpAddress();
                    },
                    onTapOutside: (e) {
                      _textBorderIpAdress =
                          CupertinoColors.systemGrey5.withAlpha(0);
                      if (_focusNodeIPTextfield.hasFocus) {
                        _focusNodeIPTextfield.unfocus();
                      }
                      _setIpAddress();
                    },
                  ),
                ),
              ),
              CupertinoListTile(
                padding: const EdgeInsets.all(16),
                title: const Text('Port'),
                subtitle: const Text('Port of the Receiver'),
                trailing: SizedBox(
                  width: 140,
                  child: CupertinoTextField(
                    focusNode: _focusNodePortTextfield,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: _textBorderPort),
                    ),
                    controller: _portTextController,
                    keyboardType: TextInputType.datetime,
                    textAlign: TextAlign.right,
                    maxLength: 5,
                    onTap: () {
                      setState(() {
                        _textBorderPort = CupertinoColors.systemGrey5;
                        _textBorderIpAdress =
                            CupertinoColors.systemGrey5.withAlpha(0);
                      });
                    },
                    onSubmitted: (port) {
                      setState(() {
                        _textBorderPort =
                            CupertinoColors.systemGrey5.withAlpha(0);
                      });
                      _setPort();
                    },
                    onTapOutside: (e) {
                      _textBorderPort =
                          CupertinoColors.systemGrey5.withAlpha(0);
                      if (_focusNodePortTextfield.hasFocus) {
                        _focusNodePortTextfield.unfocus();
                      }
                      _setPort();
                    },
                  ),
                ),
              ),
            ],
          ),

          /* ------------------------------------------------------- */
          /* --- App Settings ---------------------------------- */
          /* ------------------------------------------------------- */
          CupertinoListSection.insetGrouped(
            // header: Text(
            //   'APP SETTINGS',
            // ),
            children: [
              //SafeArea(
              CupertinoListTile(
                padding: const EdgeInsets.all(16),
                title: Text('Show disabled Tracking Features'),
                subtitle: Text(
                    'Show also all disabled tracking features in the list'),
                trailing: CupertinoSwitch(
                  value: showFeatures,
                  onChanged: (value) {
                    _toggleShowFeatures(value);
                  },
                ),
              ),
              CupertinoListTile(
                padding: const EdgeInsets.all(16),
                title: Text('Show Help'),
                subtitle: Text('Show the initial app tutorial'),
                trailing: CupertinoSwitch(
                  value: showHelp,
                  onChanged: (value) {
                    _toggleShowHelp(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
