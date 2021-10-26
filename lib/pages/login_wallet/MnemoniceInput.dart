import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallet/common/util/dispose_array/dispose_array.dart';

class MnemoniceInputPage extends StatefulWidget {
  @override
  _MnemoniceInputPageState createState() => _MnemoniceInputPageState();
}

//
TextStyle get commonTextStyle => TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      height: 18 / 16,
      textBaseline: TextBaseline.ideographic,
    );

class _MnemoniceInputPageState extends State<MnemoniceInputPage> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController(text: '');
  double _opacity = 1;
  Duration durationTime = Duration(milliseconds: 500);
  late Timer timer = new Timer(durationTime, () => {});
  GlobalKey _keyGreen = GlobalKey();
  List<String> searchlist = [];

  List<String> MnemonicList = [];

  void dispose() {
    _controller.clear();
    timer.cancel();
    super.dispose();
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // key: _keyGreen,
      children: [
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: MediaQuery.of(context).size.width,
              key: _keyGreen,
              constraints: BoxConstraints(
                minHeight: 112,
              ),
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...MnemonicList.map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('$e'),
                            width: 72,
                            height: 26,
                            color: Color(0xffF7F8FA),
                          ),
                        )),
                    Text('${_controller.text.substring(MnemonicList.length)}'),
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(seconds: 2),
                      onEnd: () {},
                      child: Container(
                        // alignment: Alignment.topLeft,
                        width: 2,
                        height: 26,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Colors.red)),
              // child: Text(_controller.text),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Opacity(
            opacity: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(_focusNode);
              },
              child: Container(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _controller,
                  // textInputAction: TextInputAction.search, //
                  cursorHeight: 16,
                  cursorWidth: 2,
                  minLines: 4,
                  maxLines: 8,
                  cursorRadius: Radius.circular(1),
                  style: commonTextStyle,
                  enabled: true,
                  onChanged: (value) {
                    print('onchaned');
                    print(value);
                    String t = '';
                    List<String> resultSearch = [];
                    List<String> simplifyResultSearch = [];
                    searchlist = [];
                    print(_controller.text
                        .substring(MnemonicList.length)
                        .isNotEmpty);
                    print('---------------');
                    if (_controller.text.length > MnemonicList.length &&
                        _controller.text
                            .substring(MnemonicList.length)
                            .isNotEmpty) {
                      DisposeArray.extractFirstWordList().forEach((key, value) {
                        if (_controller.text
                                .substring(MnemonicList.length)[0] ==
                            key) {
                          resultSearch = value;
                        }
                      });
                      resultSearch.forEach((element) {
                        if (element.indexOf(_controller.text
                                .substring(MnemonicList.length)) !=
                            -1) {
                          simplifyResultSearch.add(element);
                        }
                      });
                      setState(() {
                        searchlist.addAll(simplifyResultSearch);
                      });

                      timer.cancel();
                      timer = new Timer(durationTime, () {
                        print(_controller.text
                            .substring(MnemonicList.length)
                            .isNotEmpty);
                        MnemonicList.add(
                            _controller.text.substring(MnemonicList.length));
                        setState(() {
                          for (int i = 0; i < MnemonicList.length; i++) {
                            t += '1';
                          }
                          _controller.text = t;
                        });
                        // }

                        _controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: _controller.text.length));
                      });
                    }

                    if (_controller.text.length < MnemonicList.length) {
                      // print('');
                      setState(() {
                        MnemonicList.removeLast();
                        for (int i = 0; i < MnemonicList.length; i++) {
                          t += '1';
                        }
                        _controller.text = t;
                      });
                    }

                    _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length));
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 16, top: 12),
                    hintText: '',
                    hintStyle: commonTextStyle,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
