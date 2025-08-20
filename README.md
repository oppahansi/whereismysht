# Where is my Sht?

A minimal, offline-first Flutter app to track items you lend or borrow. No accounts, no cloud, no surprises—just record who borrowed what, when it was returned, and keep a simple history.

## Download

coming soon  
[![Where Is My Sht?](https://developer.apple.com/app-store/marketing/guidelines/images/badge-example-preferred.png)](https://developer.apple.com/app-store/marketing/guidelines/images/badge-example-preferred.png)
[<img src="res/GetItOnGooglePlay_Badge.png" alt="Get it on Google Play" height="55" />](https://play.google.com/store/apps/details?id=de.oppahansi.where_is_my_sht)

## Features
- Home overview with quick sections for Borrowed, Lent, and History
- Add/Edit items with notes
- Mark items as returned and keep a history
- Optional photos: take a photo or pick from gallery (saved to db only, not phone)
- Local database with Export/Import backups (to/from Files/Downloads)
- Settings screen
- Dark/Light/System theme
- 100% offline: no internet permission, no analytics, no ads, no tracking

## Why another app?
Many existing “lend/borrow” trackers feel stuck or unfriendly. This project exists because:
- Many apps are outdated or abandoned
- Old-looking and cluttered UIs
- Paywalls for basic functionality
- Ads in core flows
- Tracking and telemetry without valid reasons
- Fed up with compromises—this app is simple, modern, private, and offline-first

## Privacy and Offline Guarantees
- No data tracking
- No data collecting
- No telemetry
- No ads
- No Google Play Services / Firebase dependency
- No network dependency (no internet permission; works fully offline)
- All data stays on device; backups are files you explicitly export/import
- No hidden background jobs, no remote config—what you see is what you get

## Why buy the store version instead of self-building?
The license allows personal, non‑commercial self-builds, but purchasing on the App Store/Google Play meaningfully supports this project:
- Funds ongoing maintenance, bug fixes, and new features (like more languages and accessibility)
- Keeps the app ad‑free, tracker‑free, and source‑available
- Provides convenience (automatic updates, vetted/signatured binaries)
- Sends a clear signal that users value private, offline‑first software

If you can, please buy the store version to support sustainable privacy‑respecting apps. If you prefer, you can still build locally for personal use.

## Privacy Policy
See the full policy here: [PRIVACY_POLICY.md](PRIVACY_POLICY.md)

- Apple App Privacy (App Store): Data Collected — None; Tracking — None.
- Google Play Data Safety: Data collected — No; Data shared — No; Processing — On-device only.

## License (Short Summary)
This project uses the “Where is my Sht? Source-Available License.” See [LICENSE](LICENSE) for full terms. In short:
- Personal use: You may view, modify, compile, use, and distribute source or binaries for non-commercial/personal use.
- No commercial distribution of binaries without explicit permission.
- Share-alike: Derivative works must use the same license, include attribution to oppahansi, and make full source code publicly available.
- Name and branding: Do not use the app name/logo without permission.
- No warranty; governed by the laws of Germany.

## Contributing

Contributions are welcome — especially translations.

- Issues: report bugs, request features, or pick up “help wanted” tasks.
- Code: keep PRs small, follow existing style, and run linters/tests.
- Docs: improvements and clarifications are appreciated.

**Note**:  
I am using the [better_imports](https://github.com/oppahansi/better_imports) utility to format my import statements in dart files. Not formatted import statements will not be accepted.

### Translating

This project uses ARB files via flutter_intl.

1) Use l10n/app_en.arb as the source of keys/messages.
2) Add l10n/app_<lang>.arb (e.g., app_de.arb, app_es.arb) and translate values.
3) Build/run the app; the Flutter Intl generator produces AppLocalizations in lib/l10n.
4) If needed, add your locale to supportedLocales in MaterialApp.

Open a PR with the new/updated ARB and, if useful, screenshots for layout checks.
