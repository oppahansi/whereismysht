// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get add => 'hinzufügen';

  @override
  String get borrowed => 'ausgeliehen';

  @override
  String get cancel => 'abbrechen';

  @override
  String get close => 'schließen';

  @override
  String get dark => 'dunkel';

  @override
  String get date => 'datum';

  @override
  String get delete => 'löschen';

  @override
  String get edit => 'bearbeiten';

  @override
  String get english => 'englisch';

  @override
  String get german => 'deutsch';

  @override
  String get images => 'bilder';

  @override
  String get item => 'gegenstand';

  @override
  String get language => 'sprache';

  @override
  String get lent => 'verliehen';

  @override
  String get light => 'hell';

  @override
  String get loading => 'lade';

  @override
  String get lost => 'verloren';

  @override
  String get note => 'notiz';

  @override
  String get reopen => 'wiedereröffnen';

  @override
  String get restore => 'wiederherstellen';

  @override
  String get returned => 'zurückgegeben';

  @override
  String get system => 'system';

  @override
  String get theme => 'design';

  @override
  String get to => 'an';

  @override
  String get update => 'aktualisieren';

  @override
  String get add_item => 'Gegenstand hinzufügen';

  @override
  String get are_you_sure => 'Sind Sie sicher?';

  @override
  String get borrowed_from => 'Ausgeliehen von';

  @override
  String delete_from_history(Object itemName) {
    return '\'$itemName\' aus dem Verlauf löschen?';
  }

  @override
  String get edit_item => 'Gegenstand bearbeiten';

  @override
  String get export_db => 'Datenbank exportieren';

  @override
  String get export_canceled => 'Export abgebrochen';

  @override
  String get export_failed => 'Export fehlgeschlagen';

  @override
  String get export_import => 'Export/Import';

  @override
  String get export_import_hint =>
      'Werksreset des Telefons löscht lokale Backups. Verschieben Sie das Backup nach dem Export von Ihrem Telefon (Computer/Cloud), damit Sie es später wiederherstellen können.';

  @override
  String get export_success => 'Export erfolgreich';

  @override
  String get import_db => 'Datenbank importieren';

  @override
  String get import_canceled => 'Import abgebrochen';

  @override
  String get import_failed => 'Import fehlgeschlagen';

  @override
  String get lost_on => 'Verloren am';

  @override
  String get lent_to => 'Verliehen an';

  @override
  String get lost_to => 'Verloren an';

  @override
  String get mark_as_lost => 'Als verloren markieren';

  @override
  String get mark_as_returned => 'Als zurückgegeben markieren';

  @override
  String get no_borrowed_items => 'Keine ausgeliehenen Gegenstände';

  @override
  String get no_history_items => 'Keine Verlaufsgegenstände';

  @override
  String get no_items => 'Keine Gegenstände';

  @override
  String get no_lent_items => 'Keine verliehenen Gegenstände';

  @override
  String get no_lost_items => 'Keine verlorenen Gegenstände';

  @override
  String get no_returned_items => 'Keine zurückgegebenen Gegenstände';

  @override
  String get ok => 'OK';

  @override
  String get pick_from_gallery => 'Aus Galerie auswählen';

  @override
  String get pick_a_backup_file => 'Backup-Datei auswählen';

  @override
  String get prompt_for_exit => 'Drücken Sie erneut, um die App zu beenden.';

  @override
  String get required_field => 'Pflichtfeld';

  @override
  String get restore_db => 'Datenbank wiederherstellen';

  @override
  String get restore_done_restart =>
      'Wiederhergestellt. Bitte starten Sie die App neu.';

  @override
  String get restore_warning =>
      'Dies wird Ihre aktuellen Daten überschreiben. Fortfahren?';

  @override
  String get returned_on => 'Zurückgegeben am';

  @override
  String get save_backup_to => 'Backup in Dateien/Downloads sichern';

  @override
  String get save_to_phone => 'Auf Telefon speichern?';

  @override
  String get take_photo => 'Foto aufnehmen';

  @override
  String get home_screen_title => 'Startseite';

  @override
  String get borrowed_screen_title => 'Ausgeliehen';

  @override
  String get lent_screen_title => 'Verliehen';

  @override
  String get history_screen_title => 'Verlauf';

  @override
  String get settings_screen_title => 'Einstellungen';
}
