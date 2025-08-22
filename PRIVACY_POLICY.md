# Privacy Policy for “Lend & Borrow”

Effective date: 2025-01-01  
Contact: lendnborrow@proton.me

1) Overview
- “Lend & Borrow” is an offline-first app that runs entirely on-device.
- No accounts, no cloud, no online services.
- No analytics, telemetry, crash reporting, tracking, or ads.
- All data is stored locally on your device and only leaves your device if you explicitly export it.

See also: [README.md](README.md) and [LICENSE](LICENSE).

2) Data Collection and Sharing
- We do not collect, transmit, or share personal data.
- We do not use third‑party services or SDKs for analytics, ads, or tracking.
- The app does not require or use internet access.

3) On-Device Data and Storage
- Data you enter (e.g., items, notes, dates, optional photos) is stored locally in an on-device database.
- The database is not transmitted to any server by the app.
- Exports and imports are user-initiated file operations (e.g., via iOS Files / Android Downloads). See iOS picker code: [ios/Runner/BackupChannel.swift](ios/Runner/BackupChannel.swift).
- Backups are plain files; handle and store them securely according to your preferences.

4) Permissions and Platform Features
- Photos/Media/Files: to attach item photos and to export/import backups.
- Camera: to take item photos directly.
- iOS Document Picker / Android file access: to export/import your local database.
- No network permission is requested or used (offline-only, per [README.md](README.md)).

5) Security
- Data remains on your device. The app does not add encryption at rest to the local database or backups; rely on your device’s OS-level protections and your own storage practices.
- When exporting, you control the destination and retention of backup files.

6) Data Retention and Deletion
- You control all data. Delete items in-app, delete backups from your storage, or uninstall the app to remove app data from your device.
- We hold no server-side copies.

7) Children’s Privacy
- The app is not directed to children. We do not knowingly collect personal information from children.

8) Regional Notices
- EU/EEA (GDPR): No personal data is processed or transferred by us; no data leaves your device unless you export it.
- California (CCPA/CPRA): We do not “sell” or “share” personal information as defined by law.

9) Apple App Privacy (App Store)
- Data Collected: None.
- Tracking: None.
- Optional Photos remain on-device (or in your backups if you export them).

10) Google Play Data Safety
- Data collected: No.
- Data shared with third parties: No.
- Data is processed on-device only; you can delete app data and backups at any time.

11) Changes to this Policy
- We may update this policy as needed. Material changes will be reflected in this file with an updated effective date.

12) Contact
- For questions: lendnborrow@proton.me