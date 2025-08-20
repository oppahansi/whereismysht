import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'add'**
  String get add;

  /// No description provided for @borrowed.
  ///
  /// In en, this message translates to:
  /// **'borrowed'**
  String get borrowed;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'close'**
  String get close;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'dark'**
  String get dark;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'date'**
  String get date;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'edit'**
  String get edit;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'english'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'german'**
  String get german;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'images'**
  String get images;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get language;

  /// No description provided for @lent.
  ///
  /// In en, this message translates to:
  /// **'lent'**
  String get lent;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'light'**
  String get light;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'loading'**
  String get loading;

  /// No description provided for @lost.
  ///
  /// In en, this message translates to:
  /// **'lost'**
  String get lost;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'note'**
  String get note;

  /// No description provided for @reopen.
  ///
  /// In en, this message translates to:
  /// **'reopen'**
  String get reopen;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'restore'**
  String get restore;

  /// No description provided for @returned.
  ///
  /// In en, this message translates to:
  /// **'returned'**
  String get returned;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'system'**
  String get system;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'theme'**
  String get theme;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'update'**
  String get update;

  /// No description provided for @add_item.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get add_item;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @borrowed_from.
  ///
  /// In en, this message translates to:
  /// **'Borrowed from'**
  String get borrowed_from;

  /// No description provided for @delete_from_history.
  ///
  /// In en, this message translates to:
  /// **'Delete \'{itemName}\' from history?'**
  String delete_from_history(Object itemName);

  /// No description provided for @edit_item.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get edit_item;

  /// No description provided for @export_db.
  ///
  /// In en, this message translates to:
  /// **'Export database'**
  String get export_db;

  /// No description provided for @export_canceled.
  ///
  /// In en, this message translates to:
  /// **'Export canceled'**
  String get export_canceled;

  /// No description provided for @export_failed.
  ///
  /// In en, this message translates to:
  /// **'Export failed'**
  String get export_failed;

  /// No description provided for @export_import.
  ///
  /// In en, this message translates to:
  /// **'Export/Import'**
  String get export_import;

  /// No description provided for @export_import_hint.
  ///
  /// In en, this message translates to:
  /// **'Phone factory resets erase local backups. After exporting, move the backup off the phone (computer/cloud) so you can restore it later.'**
  String get export_import_hint;

  /// No description provided for @export_success.
  ///
  /// In en, this message translates to:
  /// **'Export successful'**
  String get export_success;

  /// No description provided for @import_db.
  ///
  /// In en, this message translates to:
  /// **'Import database'**
  String get import_db;

  /// No description provided for @import_canceled.
  ///
  /// In en, this message translates to:
  /// **'Import canceled'**
  String get import_canceled;

  /// No description provided for @import_failed.
  ///
  /// In en, this message translates to:
  /// **'Import failed'**
  String get import_failed;

  /// No description provided for @lost_on.
  ///
  /// In en, this message translates to:
  /// **'Lost on'**
  String get lost_on;

  /// No description provided for @lent_to.
  ///
  /// In en, this message translates to:
  /// **'Lent to'**
  String get lent_to;

  /// No description provided for @lost_to.
  ///
  /// In en, this message translates to:
  /// **'Lost to'**
  String get lost_to;

  /// No description provided for @mark_as_lost.
  ///
  /// In en, this message translates to:
  /// **'Mark as lost'**
  String get mark_as_lost;

  /// No description provided for @mark_as_returned.
  ///
  /// In en, this message translates to:
  /// **'Mark as returned'**
  String get mark_as_returned;

  /// No description provided for @no_borrowed_items.
  ///
  /// In en, this message translates to:
  /// **'No borrowed items'**
  String get no_borrowed_items;

  /// No description provided for @no_history_items.
  ///
  /// In en, this message translates to:
  /// **'No history items'**
  String get no_history_items;

  /// No description provided for @no_items.
  ///
  /// In en, this message translates to:
  /// **'No items'**
  String get no_items;

  /// No description provided for @no_lent_items.
  ///
  /// In en, this message translates to:
  /// **'No lent items'**
  String get no_lent_items;

  /// No description provided for @no_lost_items.
  ///
  /// In en, this message translates to:
  /// **'No lost items'**
  String get no_lost_items;

  /// No description provided for @no_returned_items.
  ///
  /// In en, this message translates to:
  /// **'No returned items'**
  String get no_returned_items;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @pick_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from Gallery'**
  String get pick_from_gallery;

  /// No description provided for @pick_a_backup_file.
  ///
  /// In en, this message translates to:
  /// **'Pick a backup file'**
  String get pick_a_backup_file;

  /// No description provided for @prompt_for_exit.
  ///
  /// In en, this message translates to:
  /// **'Press again to exit the app.'**
  String get prompt_for_exit;

  /// No description provided for @required_field.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get required_field;

  /// No description provided for @restore_db.
  ///
  /// In en, this message translates to:
  /// **'Restore database'**
  String get restore_db;

  /// No description provided for @restore_done_restart.
  ///
  /// In en, this message translates to:
  /// **'Restored. Please restart the app.'**
  String get restore_done_restart;

  /// No description provided for @restore_warning.
  ///
  /// In en, this message translates to:
  /// **'This will overwrite your current data. Continue?'**
  String get restore_warning;

  /// No description provided for @returned_on.
  ///
  /// In en, this message translates to:
  /// **'Returned on'**
  String get returned_on;

  /// No description provided for @save_backup_to.
  ///
  /// In en, this message translates to:
  /// **'Save backup to file/downloads'**
  String get save_backup_to;

  /// No description provided for @save_to_phone.
  ///
  /// In en, this message translates to:
  /// **'Save to phone?'**
  String get save_to_phone;

  /// No description provided for @take_photo.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get take_photo;

  /// No description provided for @home_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_screen_title;

  /// No description provided for @borrowed_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Borrowed'**
  String get borrowed_screen_title;

  /// No description provided for @lent_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Lent'**
  String get lent_screen_title;

  /// No description provided for @history_screen_title.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history_screen_title;

  /// No description provided for @settings_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_screen_title;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
