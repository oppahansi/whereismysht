// Flutter Imports
import "package:flutter/material.dart";
import "package:flutter/services.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_riverpod/legacy.dart";
import "package:material_symbols_icons/symbols.dart";

// Project Imports
import "package:where_is_my_sht/core/provider/item_transaction_provider.dart";
import "package:where_is_my_sht/core/utils/colors.dart";
import "package:where_is_my_sht/core/utils/extensions.dart";
import "package:where_is_my_sht/core/utils/screen_sizes.dart";
import "package:where_is_my_sht/feature/borrowed/borrowed_screen.dart";
import "package:where_is_my_sht/feature/history/history_screen.dart";
import "package:where_is_my_sht/feature/home/home_screen.dart";
import "package:where_is_my_sht/core/widgets/add_item_form.dart";
import "package:where_is_my_sht/feature/lent/lent_screen.dart";
import "package:where_is_my_sht/feature/settings/settings_screen.dart";
import "package:where_is_my_sht/l10n/app_localizations.dart";

final currentTabIndexProvider = StateProvider<int>((ref) => 0);
final lastBackPressedProvider = StateProvider<DateTime?>((ref) => null);

class MainScreen extends ConsumerStatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? lastBackPressTime;

  late final PageController pageController;
  bool isBarVisible = true;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: ref.read(currentTabIndexProvider),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentTabIndexProvider);
    final localizations = AppLocalizations.of(context)!;
    final displayAddItemButton =
        currentIndex == getRouteIndex(LentScreen.path) ||
        currentIndex == getRouteIndex(BorrowedScreen.path);

    ref.listen(currentTabIndexProvider, (previous, next) {
      if (next != pageController.page?.round()) {
        pageController.jumpToPage(next);
      }
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final modalRoute = ModalRoute.of(context);
        if (modalRoute?.isCurrent == false) {
          context.pop();
          return;
        }

        final now = DateTime.now();
        const duration = Duration(seconds: 2);

        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > duration) {
          lastBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizations.prompt_for_exit),
              duration: duration,
            ),
          );

          return;
        }

        SystemNavigator.pop();
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: scaffoldKey,
          backgroundColor: surfaceDimColor(context),
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              ref.read(currentTabIndexProvider.notifier).state = index;
            },
            children: [
              HomeScreen(),
              BorrowedScreen(),
              LentScreen(),
              HistoryScreen(),
              SettingsScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            selectedItemColor: primaryColor(context),
            selectedIconTheme: IconThemeData(
              color: secondaryColor(context),
              size: 32,
            ),
            unselectedIconTheme: IconThemeData(
              color: primaryColor(context),
              size: 24,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              ref.read(currentTabIndexProvider.notifier).state = index;
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Symbols.home),
                label: localizations.home_screen_title,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Symbols.download),
                label: localizations.borrowed_screen_title,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Symbols.upload),
                label: localizations.lent_screen_title,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Symbols.history),
                label: localizations.history_screen_title,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Symbols.settings),
                label: localizations.settings_screen_title,
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
          floatingActionButton: displayAddItemButton
              ? getAddItemButton(context, ref)
              : null,
        ),
      ),
    );
  }
}

Widget getAddItemButton(BuildContext context, WidgetRef ref) {
  return FloatingActionButton(
    onPressed: () async {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            color: surfaceDimColor(context),
          ),
          constraints: BoxConstraints(minHeight: screenHeight(context, 0.5)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: AddItemForm(),
          ),
        ),
      );

      // Refresh the correct list based on active tab
      final idx = ref.read(currentTabIndexProvider);
      if (idx == getRouteIndex(LentScreen.path)) {
        ref.invalidate(lentItemsProvider);
      } else if (idx == getRouteIndex(BorrowedScreen.path)) {
        ref.invalidate(borrowedItemsProvider);
      }
    },
    child: const Icon(Symbols.add),
  );
}

int getRouteIndex(String path) {
  final bottomRoutes = [
    HomeScreen.path,
    BorrowedScreen.path,
    LentScreen.path,
    HistoryScreen.path,
    SettingsScreen.path,
  ];

  return bottomRoutes.indexWhere((route) => route == path);
}
