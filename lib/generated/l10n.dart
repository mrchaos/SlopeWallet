// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `{howMany,plural, =0{There are no emails left}=1{There is {howMany} email left}other{There are {howMany} emails left}}`
  String remainingEmailsMessage(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: 'remainingEmailsMessage',
      desc: '',
      args: [howMany],
    );
  }

  /// `You haven't set Face ID. Please enable Face ID at ‘Settings-Face ID&Passcode’`
  String get enableFaceIdErrorToast {
    return Intl.message(
      'You haven\'t set Face ID. Please enable Face ID at ‘Settings-Face ID&Passcode’',
      name: 'enableFaceIdErrorToast',
      desc: '',
      args: [],
    );
  }

  /// `You haven't set Fingerprint. Please enable Fingerprint at ‘Settings-Fingerprint`
  String get enableFingerprintErrorToast {
    return Intl.message(
      'You haven\'t set Fingerprint. Please enable Fingerprint at ‘Settings-Fingerprint',
      name: 'enableFingerprintErrorToast',
      desc: '',
      args: [],
    );
  }

  /// `Failed to set, please try later`
  String get enableBiometricsErrorToast {
    return Intl.message(
      'Failed to set, please try later',
      name: 'enableBiometricsErrorToast',
      desc: '',
      args: [],
    );
  }

  /// `welcome {name}`
  String welcome(Object name) {
    return Intl.message(
      'welcome $name',
      name: 'welcome',
      desc: '',
      args: [name],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
