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

  /// `Addresses`
  String get addressesText {
    return Intl.message(
      'Addresses',
      name: 'addressesText',
      desc: '',
      args: [],
    );
  }

  /// `Location Service`
  String get locationServiceText {
    return Intl.message(
      'Location Service',
      name: 'locationServiceText',
      desc: '',
      args: [],
    );
  }

  /// `Location Service Permission`
  String get locationServicePermissionText {
    return Intl.message(
      'Location Service Permission',
      name: 'locationServicePermissionText',
      desc: '',
      args: [],
    );
  }

  /// `Be Sure that your location is enable.`
  String get locationServiceLongText {
    return Intl.message(
      'Be Sure that your location is enable.',
      name: 'locationServiceLongText',
      desc: '',
      args: [],
    );
  }

  /// `To enable location service, go to settings and enable this permission..`
  String get locationServicePermissionLongText {
    return Intl.message(
      'To enable location service, go to settings and enable this permission..',
      name: 'locationServicePermissionLongText',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeText {
    return Intl.message(
      'Close',
      name: 'closeText',
      desc: '',
      args: [],
    );
  }

  /// `My Location`
  String get myLocationText {
    return Intl.message(
      'My Location',
      name: 'myLocationText',
      desc: '',
      args: [],
    );
  }

  /// `Submit Address`
  String get locationRegistrationText {
    return Intl.message(
      'Submit Address',
      name: 'locationRegistrationText',
      desc: '',
      args: [],
    );
  }

  /// `Search Address`
  String get addressSearchText {
    return Intl.message(
      'Search Address',
      name: 'addressSearchText',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressText {
    return Intl.message(
      'Address',
      name: 'addressText',
      desc: '',
      args: [],
    );
  }

  /// `Your address list is empty.`
  String get emptyMyAddressListText {
    return Intl.message(
      'Your address list is empty.',
      name: 'emptyMyAddressListText',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get numberText {
    return Intl.message(
      'No',
      name: 'numberText',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unitText {
    return Intl.message(
      'Unit',
      name: 'unitText',
      desc: '',
      args: [],
    );
  }

  /// `List of addresses`
  String get addressListText {
    return Intl.message(
      'List of addresses',
      name: 'addressListText',
      desc: '',
      args: [],
    );
  }

  /// `New Address`
  String get newAddressText {
    return Intl.message(
      'New Address',
      name: 'newAddressText',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgainText {
    return Intl.message(
      'Try Again',
      name: 'tryAgainText',
      desc: '',
      args: [],
    );
  }

  /// `List is empty`
  String get emptinessText {
    return Intl.message(
      'List is empty',
      name: 'emptinessText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
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
