import 'dart:async';

import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart'
    show getWrongTimes, getSecondsIntervalWithLastWrongInput;
import 'package:wd_common_package/wd_common_package.dart';

class LockModel extends ViewModel {
  bool _lock = false;

  bool get lock => _lock;

  Timer? _timer;
  int _time = 0;

  int get time => _time;

  factory LockModel() => _getInstance();

  static LockModel get instance => _getInstance();

  static LockModel? _instance;

  LockModel._internal() {
    int times = getWrongTimes();
    int seconds = getSecondsIntervalWithLastWrongInput();
    if (times < 5) _lock = false;
    if (times >= 5) {
      if (seconds < times * 60) {
        var i = times * 60 - seconds;
        startCountdown(i);
        _lock = true;
      } else if (seconds >= (times + 2) * 60) {
        //
        _lock = false;
      }
    }
  }

  static LockModel _getInstance() {
    if (_instance == null) {
      _instance = LockModel._internal();
    }
    return _instance!;
  }

  changeLock(bool lock,{int? time}) {
    _lock = lock;
    if(lock && time != 0) {
      startCountdown(time!);
    }
    notifyListeners();
  }

  startCountdown(int current) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('_time: $_time');
      _time = current--;
      if (current == 0) {
        timer.cancel();
        _timer = null;
        _lock = false;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    if(_timer!=null) {
      if(_timer!.isActive) _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }
}
