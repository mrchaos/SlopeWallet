import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/widgets/verification_box/verification_box_item.dart';


class VerificationBox extends StatefulWidget {
  VerificationBox(
      {GlobalKey<VerificationBoxState>? key,
      required this.onSubmitted,
      required this.textStyle,
      required this.errorStyle,
      required this.decoration,
      required this.errorDecoration,
      required this.focusDecoration,
      this.reset,
      this.count = 6,
      this.itemWidget = 45,
      this.onValueChanged,
      this.cursorColor = Colors.transparent,
      this.type = VerificationBoxItemType.box,
      this.unFocus = true,
      this.autoFocus = true,
      this.showCursor = false,
      this.isDelete = false,
      this.cursorWidth = 2,
      this.cursorIndent = 10,
      this.cursorEndIndent = 10})
      : super(key: key);

  final VoidCallback? reset;

  /// ，6，4
  final int count;

  /// item
  final double itemWidget;

  /// 
  final ValueChanged<String> onSubmitted;
  final ValueChanged? onValueChanged;

  /// item，[VerificationBoxItemType]
  final VerificationBoxItemType type;

  /// item
  final Decoration decoration;
  final Decoration errorDecoration;
  final Decoration focusDecoration;

  /// 
  final TextStyle textStyle;
  final TextStyle errorStyle;

  /// ，true，，
  final bool unFocus;
  final bool isDelete;

  /// 
  final bool autoFocus;

  /// 
  final bool showCursor;

  /// 
  final Color cursorColor;

  /// 
  final double cursorWidth;

  /// 
  final double cursorIndent;

  /// 
  final double cursorEndIndent;

  @override
  State<StatefulWidget> createState() => VerificationBoxState();
}

class VerificationBoxState extends State<VerificationBox> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late List _contentList;
  ValueNotifier<bool> isRightInputNotifier = ValueNotifier(true);
  ValueNotifier<bool> _isEditingNotifier = ValueNotifier(false);
  bool _inputEnable = true;
  /// 
  void becomeFirstResponder() {
    _checkWrongTimes();
    if(_inputEnable && !_focusNode.hasFocus)
    FocusScope.of(context).requestFocus(_focusNode);
  }

  /// 
  void resignFirstResponder() {
    if(_focusNode.hasFocus)
    _focusNode.unfocus();
  }

  void _resetInput() {
    _controller.text = '';
    _contentList = List<String>.filled(widget.count, '');
    isRightInputNotifier.value = true;
    if(null != widget.reset){
      widget.reset!();
    }
  }

  void setInputRightOrError(bool res){
    isRightInputNotifier.value = res;
    _checkWrongTimes();
  }

  void _checkWrongTimes() {
    if(!widget.isDelete) {
      int times = getWrongTimes();
      int seconds = getSecondsIntervalWithLastWrongInput();
      if(times >= 5 && seconds < times*60){
        isRightInputNotifier.value = false;
        _inputEnable = false;
        _contentList = List.filled(widget.count, '•');
        _controller.text = "••••••";
      }else if(times == 10){ // ,app,
        isRightInputNotifier.value = false;
        _inputEnable = false;
        _contentList = List.filled(widget.count, '•');
        _controller.text = "••••••";
      } else {
        _inputEnable = true;
      }
      if(mounted){
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    _contentList = List<String>.filled(widget.count, '');
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    _checkWrongTimes();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _focusListener() {
    _isEditingNotifier.value = _focusNode.hasFocus;
    if (_controller.text.length == widget.count &&
        _isEditingNotifier.value &&
        !isRightInputNotifier.value) {
      _resetInput();
    }
  }

  Decoration getDecoration(int index, bool isRight, bool isEditing){
    if(isEditing){
      return _controller.text.length == index
              ? widget.focusDecoration
              : widget.decoration;
    }else {
      return isRight ? widget.decoration : widget.errorDecoration;
    }
  }

  TextStyle getTextStyle() {
    return isRightInputNotifier.value ? widget.textStyle : widget.errorStyle;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _checkWrongTimes();
        if(_inputEnable)
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: ValueListenableBuilder<bool>(
            valueListenable: _isEditingNotifier,
            builder: (ctx, isEditing, __) {
              return ValueListenableBuilder<bool>(
                  valueListenable: isRightInputNotifier,
                  builder: (context, isRight, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(widget.count, (index) {
                        return Container(
                          width: widget.itemWidget,
                          child: VerificationBoxItem(
                            data: _contentList[index],
                            textStyle: getTextStyle(),
                            type: widget.type,
                            decoration: getDecoration(index, isRight, isEditing),
                            showCursor: widget.showCursor &&
                                _controller.text.length == index,
                            cursorColor: widget.cursorColor,
                            cursorWidth: widget.cursorWidth,
                            cursorIndent: widget.cursorIndent,
                            cursorEndIndent: widget.cursorEndIndent,
                          ),
                        );
                      }),
                    );
                  });
            },
          )),
          _buildTextField(),
        ],
      ),
    );
  }


  /// TextField
  Widget _buildTextField() {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      showCursor: false,
      enableInteractiveSelection: false,
      enabled: _inputEnable,
      enableSuggestions: false,
      obscureText: true,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      cursorWidth: 0,
      autofocus: widget.autoFocus,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: widget.count,
      buildCounter: (context,
          {required int currentLength, required bool isFocused, maxLength}) {
        return Text('');
      },
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.transparent),
      onChanged: _onValueChange,
    );
  }

  _onValueChange(String value) {
    for (int i = 0; i < widget.count; i++) {
      if (i < value.length) {
        _contentList[i] = value.substring(i, i + 1);
        if (i > 0) {
          _contentList[i - 1] = '•';
        }
      } else {
        _contentList[i] = '';
      }
    }
    setState(() {});
    if (null != widget.onValueChanged) {
      widget.onValueChanged!(value);
    }
    if (value.length == widget.count) {
      if (widget.unFocus) {
        _focusNode.unfocus();
      }
      _contentList[value.length - 1] = '•';
      widget.onSubmitted(value);
    }
  }
}
