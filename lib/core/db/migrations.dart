// Package Imports
import 'package:sqflite/sqflite.dart';

typedef Migration = Future<void> Function(Database db);

class DbMigrations {
  // Key = target version. Each step upgrades from (version-1) -> version.
  static final Map<int, Migration> upgraders = <int, Migration>{
    // 1: baseline. If you ship an asset that already contains the full v1 schema,
    // you typically don't need to do anything here.
    1: (db) async {
      // No-op (asset contains v1 schema). Keep for completeness.
    },

    // 2: example migration (add a column)
    // 2: (db) async {
    //   await db.execute(
    //     'ALTER TABLE item_transaction ADD COLUMN example_flag INTEGER NOT NULL DEFAULT 0',
    //   );
    // },
  };

  static Future<void> run(Database db, int from, int to) async {
    for (var v = from + 1; v <= to; v++) {
      final step = upgraders[v];
      if (step != null) {
        await step(db);
      }
    }
  }
}