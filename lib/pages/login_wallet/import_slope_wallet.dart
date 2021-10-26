
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/login_wallet/EnglishMnemonice.dart';
import 'package:wallet/pages/login_wallet/model/wallet_import_model.dart';
import 'package:wallet/pages/login_wallet/view/path_select_view.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';

///。 。 
class ImportSlopeWalletPage extends StatefulWidget {
  final WalletCreateRelatedData pageData;

  const ImportSlopeWalletPage({Key? key, required this.pageData})
      : super(key: key);

  @override
  _ImportSlopeWalletPageState createState() => _ImportSlopeWalletPageState();
}

class _ImportSlopeWalletPageState extends State<ImportSlopeWalletPage> {
  ValueNotifier<String> _mnemonicValueNotifier = ValueNotifier("");
  ValueNotifier<String> _keyValueNotifier = ValueNotifier("");
  ValueNotifier<String> _nameNotifier = ValueNotifier("");
  ValueNotifier<int> _segmentedNotifier = ValueNotifier(0);
  ValueNotifier<String> _pathNotifier =
      ValueNotifier(SolanaWalletPath.m44_501_0_0.value);
  ValueNotifier<bool> _nameValidateNotifier = ValueNotifier(true);
  ValueNotifier<bool> _inputValidateNotifier = ValueNotifier(true);
  late TextEditingController _keyOrMnemonicCtrl = TextEditingController();
  late TextEditingController _nameCtrl = TextEditingController();
  late bool showMore20 = false;
  late AppColors _appColors;
  late WalletImportModel _model;
  late bool selectPath = false;

  @override
  void initState() {
    _keyOrMnemonicCtrl = TextEditingController();
    _nameCtrl = TextEditingController();
    _model = WalletImportModel(widget.pageData, _inputValidateNotifier);
    super.initState();
  }

  @override
  void dispose() {
    _keyOrMnemonicCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  final double space = 24;
  final double segmentHeight = 46;
  final double textHeight = 20;
  final double textBottom = 8;
  final double inputFieldHeight = 112;
  final double pathSelectHeight = 46;
  final double importBtnHeight = 72;

  @override
  Widget build(BuildContext context) {
    _appColors = context.read<AppTheme>().currentColors;
    //，1
    final splits = _keyOrMnemonicCtrl.text.trim().split(RegExp('(\\s)+'));
    splits.removeWhere((e) => e.trim().isEmpty);
    var showSelectPath =
        MnmoniceListData.contains(splits.isNotEmpty ? splits[0] : '');
    return Scaffold(
      appBar: WalletBar.backWithTitle('Import Wallet'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: ValueListenableBuilder<int>(
              valueListenable: _segmentedNotifier,
              builder: (ctx, index, child) {
                if (index == 1) _inputValidateNotifier.value = true;
                String txt = index == 0
                    ? _mnemonicValueNotifier.value
                    : _keyValueNotifier.value;
/*                _keyOrMnemonicCtrl.value = TextEditingValue(
                    text: txt,
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: txt.length)));*/
                return Column(
                  children: [
                    _buildKeyOrMnemonicField(index),
                    SizedBox(height: space),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: showSelectPath
                          ? textHeight + textBottom + pathSelectHeight + space
                          : 0,
                      child: SingleChildScrollView(
                        child: _buildPathSelect(),
                      ),
                    ),
                    child!,
                  ],
                );
              },
              child: _buildNameField(),
            ),
          )),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _segmentedNotifier,
          builder: (ctx, index, _) => _buildImportButton(index)),
    );
  }

  Widget _buildKeyOrMnemonicField(int index) {
    return ValueListenableBuilder<bool>(
        valueListenable: _inputValidateNotifier,
        builder: (ctx, isValidate, _) {
          List<String> _wordList =
              walletManager.parseMnemonicsInput(_keyOrMnemonicCtrl.text);
          isValidate = _wordList.length > 1 ? isValidate : true;
          //，1
          final splits = _keyOrMnemonicCtrl.text.trim().split(RegExp('(\\s)+'));
          splits.removeWhere((e) => e.trim().isEmpty);
          final mnemonicNum = splits.length;
          final showMnemonicNum =
              MnmoniceListData.contains(splits.isNotEmpty ? splits[0] : '');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'Private Key / Mnemonic',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: _appColors.textColor1),
                    ),
                    const Spacer(),
                    Text(
                      showMnemonicNum ? mnemonicNum.toString() : '',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: _appColors.textColor4),
                    ),
                  ],
                ),
              ),
              Container(
                height: inputFieldHeight,
                margin: EdgeInsets.only(left: 24, right: 24, top: 12),
                padding: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: isValidate
                          ? _appColors.dividerColor
                          : _appColors.redAccent,
                      width: 1),
                ),
                child: TextField(
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: _keyOrMnemonicCtrl,
                  cursorColor: _appColors.purpleAccent,
                  onChanged: (value) {
                    if (index == 0) {
                      _mnemonicValueNotifier.value = value;
                      List<String> newList =
                          walletManager.parseMnemonicsInput(value);
                      _inputValidateNotifier.value = isStrNullOrEmpty(value);

                      /// 
                      for (int i = 0; i < newList.length; i++) {
                        int idx = MnmoniceListData.indexOf(newList[i]);
                        if (idx == -1) {
                          _model.errStr = 'No related words';
                          _inputValidateNotifier.value = false;
                          return;
                        } else {
                          _inputValidateNotifier.value = true;
                        }
                      }
                    } else {
                      _keyValueNotifier.value = value;
                    }
                    setState(() {
                      selectPath = walletManager
                                  .parseMnemonicsInput(_keyOrMnemonicCtrl.text)
                                  .length >
                              1
                          ? true
                          : false;
                    });
                  },
                  maxLines: 10,
                  style: TextStyle(
                    height: 22 / 14,
                    fontSize: 14,
                    color: _appColors.textColor1,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Please enter private key or Mnemonic words',
                    hintStyle: TextStyle(
                      height: 18 / 14,
                      fontSize: 14,
                      color: context.isLightTheme
                          ? _appColors.textColor4
                          : _appColors.textColor3,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 16, top: 10, right: 16, bottom: 12),
                    border: InputBorder.none,
                    suffixIcon: (_keyOrMnemonicCtrl.text.length > 0)
                        ? GestureDetector(
                            onTap: () {
                              _keyOrMnemonicCtrl.text = '';
                              setState(() {});
                            },
                            child: service.svg.asset(
                                Assets.assets_svg_cleantext_svg,
                                fit: BoxFit.scaleDown,
                                color: _appColors.noChangeColor),
                          )
                        : null,
                    suffixIconConstraints: BoxConstraints(
                      minHeight: 12,
                      minWidth: 12,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                padding: EdgeInsets.only(left: 24, top: 4),
                duration: Duration(milliseconds: 200),
                height: isValidate ? 0 : space,
                child: Text(
                  _model.errStr,
                  style: TextStyle(color: _appColors.redAccent, fontSize: 12),
                ),
              )
            ],
          );
        });
  }

  Widget _buildPathSelect() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            height: textHeight,
            alignment: Alignment.centerLeft,
            child: Text(
              'Path',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                color: _appColors.textColor1,
              ),
            ),
          ),
          SizedBox(height: textBottom),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              String? path = await PathSelectView.show(
                  context, _model.walletPaths, _pathNotifier.value);
              if (null != path) _pathNotifier.value = path;
            },
            child: Container(
              height: segmentHeight,
              padding: EdgeInsets.only(left: 16, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: _appColors.dividerColor),
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder<String>(
                        valueListenable: _pathNotifier,
                        builder: (context, path, child) => Text(
                              !isStrNullOrEmpty(path) ? path : 'Please select',
                              style: TextStyle(
                                fontSize: 14,
                                height: 22 / 14,
                                color: !isStrNullOrEmpty(path)
                                    ? _appColors.textColor1
                                    : _appColors.textColor3,
                              ),
                            )),
                    service.svg.asset(Assets.assets_svg_ic_menu_trailing_svg,
                        color: _appColors.textColor1,
                        fit: BoxFit.contain,
                        height: 20)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: textHeight,
          margin: EdgeInsets.only(left: 24, bottom: 8),
          child: Text(
            'Wallet Name',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: _appColors.textColor1),
          ),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: _nameValidateNotifier,
            builder: (ctx, isValidName, _) {
              return ValueListenableBuilder<String>(
                  valueListenable: _nameNotifier,
                  builder: (ctx, name, _) {
                    return Container(
                      height: 46,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: isValidName && _nameCtrl.text.length < 21
                                ? _appColors.dividerColor
                                : _appColors.redAccent,
                            width: 1),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: TextField(
                            controller: _nameCtrl,
                            autocorrect: false,
                            enableSuggestions: false,
                            onChanged: (value) {
                              _nameNotifier.value = value;
                              WalletEntity? e = WalletMainModel
                                  .instance.allWallets
                                  .firstWhereOrNull(
                                      (element) => element.walletName == value);
                              _nameValidateNotifier.value = e == null;
                              setState(() {
                                showMore20 = value.length > 20;
                              });
                            },
                            style: TextStyle(
                                fontSize: 14, color: _appColors.textColor1),
                            cursorColor: _appColors.purpleAccent,
                            decoration: InputDecoration(
                              hintText: 'Enter wallet name',
                              contentPadding: EdgeInsets.only(bottom: 4),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: context.isLightTheme
                                    ? _appColors.textColor4
                                    : _appColors.textColor3,
                              ),
                              border: InputBorder.none,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(21),
                            ],
                          )),
                          //  
                          if (_nameCtrl.text.length > 0)
                            GestureDetector(
                              onTap: () {
                                _nameCtrl.text = '';
                                showMore20 = false;
                                _nameValidateNotifier.value = true;
                                setState(() {});
                              },
                              child: service.svg.asset(
                                  Assets.assets_svg_cleantext_svg,
                                  fit: BoxFit.scaleDown,
                                  color: _appColors.noChangeColor),
                            )
                          else
                            Container(),
                          Container(
                            padding: EdgeInsets.only(top: 9),
                            width: 38,
                            height: 34,
                            child: Text(
                              '${_nameCtrl.text.length}/20',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: _nameCtrl.text.length > 20
                                      ? _appColors.redAccent
                                      : _appColors.textColor3,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }),
        ValueListenableBuilder<bool>(
            valueListenable: _nameValidateNotifier,
            builder: (ctx, isValidName, _) {
              return AnimatedContainer(
                margin: EdgeInsets.only(top: 4, left: 24),
                duration: Duration(milliseconds: 200),
                height: isValidName ? 0 : 16,
                child: Text('This name has been created, try another one.',
                    style:
                        TextStyle(fontSize: 12, color: _appColors.redAccent)),
              );
            }),
        Visibility(
            visible: showMore20,
            child: AnimatedContainer(
              margin: EdgeInsets.only(top: 4, left: 24),
              duration: Duration(milliseconds: 200),
              height: 16,
              child: Text('No more than 20 characters.',
                  style: TextStyle(fontSize: 12, color: _appColors.redAccent)),
            ))
      ],
    );
  }

  Widget _buildImportButton(int index) {
    bool canImport = _keyOrMnemonicCtrl.text.isNotEmpty &&
        (_nameCtrl.text.length > 0 && _nameCtrl.text.length <= 20) &&
        _nameValidateNotifier.value;
    return SafeArea(
      child: ValueListenableBuilder<String>(
        valueListenable:
            index == 0 ? _mnemonicValueNotifier : _keyValueNotifier,
        builder: (ctx, inputText, _) {
          return ValueListenableBuilder<String>(
              valueListenable: _nameNotifier,
              builder: (ctx, name, _) {
                return Container(
                  height: 56,
                  margin: const EdgeInsets.only(top: 24, bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: TextButton(
                    child: const Text('Start Import'),
                    style: TextButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: _appColors.purpleAccent
                          .withOpacity(canImport ? 1 : 0.5),
                      onSurface: Colors.white.withOpacity(0.5),
                      primary: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: canImport
                        ? () {
                            List<String> _wordList = walletManager
                                .parseMnemonicsInput(_keyOrMnemonicCtrl.text);
                            if (_wordList.length > 1) {
                              _model.mnemonicImport(context, inputText, name,
                                  _model.walletPathMap[_pathNotifier.value]!);
                            } else {
                              _model.privateKeyImport(context, inputText, name);
                            }
                          }
                        : null,
                  ),
                );
              });
        },
      ),
    );
  }
}
