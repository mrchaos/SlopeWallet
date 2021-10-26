import 'package:flutter/cupertino.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/cache_service/cache_keys.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/module/wallet_module.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/lock_model.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/database/wallet_database.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/wallet_manager/wallet_const.dart';
import 'package:wallet/wallet_manager/wallet_encrypt.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wallet/widgets/verification_box/verfication_box.dart';
import 'package:wd_common_package/wd_common_package.dart';

class WalletPasswordModel extends ViewModel {
  /// 
  void savePassword(String password) {
    walletManager.savePassword(password: password);
  }

  /// /
  bool validatePassword(String password) {
    return walletManager.validatePassword(password: password);
  }

  /// slopetab
  bool get shouldAutoFocus {
    return !(pageData.isLoginPasswordVerify &&
        config.app.appType == WalletAppType.slope &&
        !pageData.isNeedBackToAPage);
  }

  /// 
  bool verifyInputPassword(String pwd) {
    return !isStrNullOrEmpty(pwd) && pageData.lastInputPassword == pwd;
  }

  void _popWithCounts(int count) {
    for (int i = 0; i < count; i++) {
      service.router.pop();
    }
  }

  late GlobalKey<VerificationBoxState> _verificationKey;
  late WalletCreateRelatedData pageData;
  late ValueNotifier<bool> pwdIsRightNotifier;

  WalletPasswordModel(
      WalletCreateRelatedData pageData,
      ValueNotifier<bool> pwdIsRightNotifier,
      GlobalKey<VerificationBoxState> verificationKey) {
    this.pageData = pageData;
    this.pwdIsRightNotifier = pwdIsRightNotifier;
    this._verificationKey = verificationKey;
  }

  PreferredSizeWidget? appBar() {
    if (pageData.isLoginPasswordVerify) {
      if (config.app.appType == WalletAppType.slope) {
        return pageData.isNeedBackToAPage
            ? WalletBar.backWithTitle('')
            : WalletBar.empty();
      } else {
        return WalletBar.title('Slope Wallet');
      }
    }else {
      return WalletBar.backWithTitle("");
    }
  }

  String get title {
    if (pageData.isSetupPassword) {
      if (pageData.isSecondPasswordPage) return 'Please Re-entry your Password';
      return 'Please Set Up Your Password';
    } else if (pageData.isChangePassword) {
      if (pageData.isSecondPasswordPage) return 'Please Re-entry your Password';
      return 'Please Set Up Your New Password';
    } else if (pageData.isChangePasswordVerify) {
      return 'Please Enter Your Password';
    } else if (pageData.isSecondPasswordPage) {
      return 'Please Re-entry your Password';
    } else if (pageData.isDeleteWallet) {
      return 'Delete Wallet';
    } else if (pageData.isMnemonicBackupVerify ||
        pageData.isKeyBackupVerify ||
        pageData.isLoginPasswordVerify) {
      return 'Password Verification';
    }
    return '';
  }

  String get errStr {
    if (pageData.isKeyBackupVerify ||
        pageData.isMnemonicBackupVerify ||
        pageData.isLoginPasswordVerify ||
        (pageData.isChangePasswordVerify && !pageData.isChangePassword)) {
      if (inputWrongTimes < 5) {
        return "Wrong password. Try again";
      } else if (inputWrongTimes < 10) {
        return 'Wait $inputWrongTimes minutes and try again';
      } else if (inputWrongTimes >= 10) {
        return 'You have tried a lot. You can re-download the app, reset your account & password';
      }
    }
    return 'The two passwords are inconsistent, please re-enter';
  }


  // ，，
  bool checkBioStatus () {
    if (pageData.isLoginPasswordVerify) {
      bool showBio = service.cache.getBool(hasBioBeenSetKey, defaultValue: false)!;
      return showBio;
    }
    return false;
  }


  void submit(String password) async {
    if (pageData.isDeleteWallet) {
      bool isValidate = validatePassword(password);
      service.router.pop(isValidate);
    } else if (pageData.isLoginPasswordVerify) {
      bool canInput = checkIfCanInput();
      if (!canInput) return;
      bool isValidate = validatePassword(password);
      if (isValidate) {
        resetWrongTimes();
        if (config.app.appType == WalletAppType.slope) {
          if (null != WalletModule.slopeDidLoadWallet) {
            WalletModule.slopeDidLoadWallet!();
          }
          if (null != WalletModule.slopeDidLoginWallet) {
            WalletModule.slopeDidLoginWallet!();
          }
          if (pageData.isNeedBackToAPage) {
            _popWithCounts(pageData.backPopPageCount);
          }
        } else {
          service.router.pushReplacementNamed(RouteName.navigationPage);
        }
      } else {
        setWrongTimes();
      }
    } else if (pageData.isSetupPassword) {
      if (pageData.isSecondPasswordPage) {
        // 
        bool match = verifyInputPassword(password);
        if (!match) {
          pwdIsRightNotifier.value = false;
          _verificationKey.currentState?.isRightInputNotifier.value = false;
          return;
        }
        assert(pageData.wallet != null,
            "/(WalletEntity)");
        try {
          // ()
          savePassword(password);
          await saveWallet(pageData.wallet!);
          if (config.app.appType == WalletAppType.slope) {
            if (null != WalletModule.slopeDidLoadWallet) {
              WalletModule.slopeDidLoadWallet!();
            }
            if (null != WalletModule.slopeDidLoginWallet) {
              WalletModule.slopeDidLoginWallet!();
            }
            if (pageData.isNeedBackToAPage) {
              _popWithCounts(pageData.backPopPageCount);
            }
          } else {
            service.router.pushNamedAndRemoveUntil(
                RouteName.navigationPage, (route) => false);
          }
        } catch (e) {
          logger.d(e.toString());
          showToast(e.toString());
        }
      } else {
        service.router.pushNamed(RouteName.walletPasswordPage,
            arguments: pageData.copyWith(
                isSecondPasswordPage: true, lastInputPassword: password));
      }
    } else if (pageData.isKeyBackupVerify || pageData.isMnemonicBackupVerify) {
      /// 10,,false
      bool canInput = checkIfCanInput();
      if (!canInput) return;
      bool isValidate = validatePassword(password);
      if (isValidate) {
        resetWrongTimes();
        assert(
            pageData.wallet != null, "/(WalletEntity)");
        if (pageData.isMnemonicBackupVerify) {
          service.router.pushNamed(RouteName.mnemonicSecurityTipsPage,
              arguments: pageData.wallet!);
        } else if (pageData.isKeyBackupVerify) {
          service.router
              .pushNamed(RouteName.exportTipsPage, arguments: pageData.wallet!);
        }
      } else {
        setWrongTimes();
      }
    } else if (pageData.isChangePassword) {
      // 
      if (pageData.isSecondPasswordPage) {
        // 
        bool match = verifyInputPassword(password);
        if (!match) {
          pwdIsRightNotifier.value = false;
          _verificationKey.currentState?.isRightInputNotifier.value = false;
          return;
        }
        List<WalletEntity> oldWallets = await walletDatabase.queryAllWallet();
        assert(oldWallets.length > 0, ",");
        String md5Pwd = WalletEncrypt.generateMD5(password + md5Salt);
        String aesKey = WalletEncrypt.generateMD5(md5Pwd + aesSalt);
        List<WalletEntity> newWallets = [];
        oldWallets.forEach((element) {
          // 
          element.privateKey = element.decryptPrivateKey();
          element.mnemonic = element.decryptMnemonic();
          // 
          Map<String, String> newMap =
              element.encrypt(md5Password: md5Pwd, aesKey: aesKey);
          // WalletEntity
          WalletEntity newEntity = WalletEntity.fromJson(newMap);
          newWallets.add(newEntity);
        });
        try {
          showLoading();
          // 
          for (int i = 0; i < newWallets.length; i++) {
            walletDatabase.updateWallet(walletEntity: newWallets[i]);
            await Future.delayed(Duration(milliseconds: 300));
          }
          // ,
          await WalletMainModel.instance.queryAllWallets();
          // /(,)
          walletManager.cleanPassword();
          walletManager.savePassword(password: password);
          _popWithCounts(2);
        } catch (e) {
          showToast(e.toString());
        } finally {
          hideLoading();
        }
      } else {
        service.router.pushNamed(RouteName.walletPasswordPage,
            arguments: pageData.copyWith(
                isSecondPasswordPage: true, lastInputPassword: password));
      }
    } else if (pageData.isChangePasswordVerify) {
      ///
      bool canInput = checkIfCanInput();
      if (!canInput) return;
      bool isValidate = validatePassword(password);
      if (isValidate) {
        resetWrongTimes();
        service.router.pushReplacementNamed(RouteName.walletPasswordPage,
            arguments: pageData.copyWith(isChangePassword: true));
      } else {
        setWrongTimes();
      }
    }
  }
}

extension SaveWalletExt on WalletPasswordModel {
  /// /
  Future<bool> saveWallet(WalletEntity walletEntity) async {
    if (isStrNullOrEmpty(walletEntity.walletName))
      walletEntity.walletName = "SOLANA Wallet1";
    await walletManager.saveWallet(walletEntity: walletEntity);
    return true;
  }
}

int _inputWrongTimes = 0;
String inputWrongTimesKey = "inputWrongTimesKey";
String lastWrongDateKey = "lastWrongDateKey";

/// 
int getSecondsIntervalWithLastWrongInput() {
  DateTime? last = _getLastWrongDate();
  if (null != last) {
    return DateTime.now().difference(last).inSeconds;
  }
  return 0;
}

/// 
int getWrongTimes() {
  return service.cache.getInt(inputWrongTimesKey, defaultValue: 0)!;
}

/// 
void resetPasswordWrongTimes() {
  service.cache.setInt(inputWrongTimesKey, 0);
  service.cache.setString(lastWrongDateKey, '');
}

/// 
DateTime? _getLastWrongDate() {
  String? lastWrongEnterDateString = service.cache.getString(lastWrongDateKey);
  return DateTime.tryParse(lastWrongEnterDateString ?? '');
}

extension PwdInputWrongTimesExt on WalletPasswordModel {
  int get inputWrongTimes => _inputWrongTimes;

  set inputWrongTimes(int value) {
    _inputWrongTimes = value;
    if(!pageData.isDeleteWallet) {
      pwdIsRightNotifier.value = _inputWrongTimes == 0;
      _verificationKey.currentState
        ?.setInputRightOrError(pwdIsRightNotifier.value);
    }
  }

  /// 
  bool checkIfCanInput() {
    if(!pageData.isDeleteWallet) {
      int times = getWrongTimes();
      int seconds = getSecondsIntervalWithLastWrongInput();
      if (times < 5) {
        LockModel.instance.changeLock(false);
        return true;
      }
      if (times >= 5) {
        if (seconds < times * 60) {
          inputWrongTimes = times;
          LockModel.instance.changeLock(true, time: times * 60 - seconds);
          return false;
        } else if (seconds >= (times + 2) * 60) {
          // 
          resetWrongTimes();
          LockModel.instance.changeLock(false);
          return true;
        } else if (times == 10) {
          inputWrongTimes = times;
          LockModel.instance.changeLock(true, time: 10);
          return false;
        }
        LockModel.instance.changeLock(false);
        return true;
      }
      LockModel.instance.changeLock(true);
      return false;
    }
    return true;
  }

  /// 
  void setWrongTimes() {
    int times = getWrongTimes();
    times += 1;
    service.cache.setString(lastWrongDateKey, DateTime.now().toIso8601String());
    service.cache.setInt(inputWrongTimesKey, times);
    inputWrongTimes = times;
  }

  /// 
  void resetWrongTimes() {
    inputWrongTimes = 0;
    service.cache.setInt(inputWrongTimesKey, 0);
    service.cache.setString(lastWrongDateKey, '');
    pwdIsRightNotifier.value = true;
  }
}

/// dex// //// 
class WalletCreateRelatedData {
  bool isSetupPassword; // 
  bool isChangePassword; // 
  bool isResetPassword; // 
  bool isDeleteWallet; // 
  bool isChangePasswordVerify; // 
  bool isKeyBackupVerify; // 
  bool isMnemonicBackupVerify; // 
  bool isLoginPasswordVerify; // 
  bool isSecondPasswordPage; // 
  bool isCreatePageAppBarShowBack; // 
  String lastInputPassword; // 
  WalletEntity? wallet; // /
  bool isNeedBackToAPage; // 
  int backPopPageCount; // pop,
  bool? isH5JumpScheme; // h5
  String? h5JumpLink; // h5
  WalletCreateRelatedData(
      {this.isSetupPassword = false, // 
      this.isChangePasswordVerify = false,
      this.isChangePassword = false, // 
      this.isResetPassword = false, // 
      this.isDeleteWallet = false, // 
      this.isKeyBackupVerify = false, // /
      this.isMnemonicBackupVerify = false, // /
      this.isLoginPasswordVerify = false, // 
      this.isSecondPasswordPage = false, // 
      this.isCreatePageAppBarShowBack = false,
      this.lastInputPassword = '', // 
      this.wallet,
      this.isNeedBackToAPage = false,
      this.backPopPageCount = 0,
      this.isH5JumpScheme = false,
      this.h5JumpLink = ''});

  WalletCreateRelatedData copyWith({
    bool? isSetupPassword, // 
    bool? isChangePassword, // 
    bool? isResetPassword, // 
    bool? isDeleteWallet, // 
    bool? isChangePasswordVerify,
    bool? isKeyBackupVerify, // /
    bool? isMnemonicBackupVerify,
    bool? isLoginPasswordVerify, // 
    bool? isSecondPasswordPage, // 
    bool? isCreatePageAppBarShowBack,
    String? lastInputPassword, // 
    WalletEntity? wallet,
    bool? isNeedBackToAPage,
    int? backPopPageCount,
    WalletAppType? appType,
  }) {
    return WalletCreateRelatedData(
      isSetupPassword: isSetupPassword ?? this.isSetupPassword,
      isChangePassword: isChangePassword ?? this.isChangePassword,
      isResetPassword: isResetPassword ?? this.isResetPassword,
      isDeleteWallet: isDeleteWallet ?? this.isDeleteWallet,
      isChangePasswordVerify:
          isChangePasswordVerify ?? this.isChangePasswordVerify,
      isKeyBackupVerify: isKeyBackupVerify ?? this.isKeyBackupVerify,
      isMnemonicBackupVerify:
          isMnemonicBackupVerify ?? this.isMnemonicBackupVerify,
      isLoginPasswordVerify:
          isLoginPasswordVerify ?? this.isLoginPasswordVerify,
      isSecondPasswordPage: isSecondPasswordPage ?? this.isSecondPasswordPage,
      isCreatePageAppBarShowBack:
          isCreatePageAppBarShowBack ?? this.isCreatePageAppBarShowBack,
      lastInputPassword: lastInputPassword ?? this.lastInputPassword,
      wallet: wallet ?? this.wallet,
      isNeedBackToAPage: isNeedBackToAPage ?? this.isNeedBackToAPage,
      backPopPageCount: backPopPageCount ?? this.backPopPageCount,
    );
  }
}
