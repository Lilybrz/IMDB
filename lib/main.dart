import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color.fromARGB(255, 243, 33, 96);
    Color surfaceColor = const Color(0x0dffffff);
    return MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        theme: _themeMode == ThemeMode.dark
            ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
            : MyAppThemeConfig.light().getTheme(_locale.languageCode),
        home: MyHomePage(
          toggleThemeMode: () {
            setState(() {
              if (_themeMode == ThemeMode.dark) {
                _themeMode = ThemeMode.light;
              } else {
                _themeMode = ThemeMode.dark;
              }
            });
          },
          selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
            setState(() {
              _locale = newSelectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
            });
          },
        ));
  }
}

class MyAppThemeConfig {
  final Brightness brightness;
  final Color appBarColor;
  final Color scaffoldBackgarounColor;
  final Color primaryTextColor;
  final Color surfaceColor;
  final Color secondaryTextColor;
  final primaryColor = const Color.fromARGB(255, 243, 33, 96);

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        appBarColor = Colors.black,
        scaffoldBackgarounColor = const Color.fromARGB(255, 30, 30, 30),
        surfaceColor = const Color(0x0dffffff),
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        appBarColor = const Color.fromARGB(255, 235, 235, 235),
        scaffoldBackgarounColor = Colors.white,
        surfaceColor = const Color(0x0d000000),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        brightness: brightness,
        scaffoldBackgroundColor: scaffoldBackgarounColor,
        dividerTheme: DividerThemeData(color: surfaceColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: appBarColor,
            foregroundColor: primaryTextColor,
            elevation: 0),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: surfaceColor,
        ),
        textTheme:
            languageCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme);
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(TextTheme(
        bodyMedium: TextStyle(fontSize: 15, color: primaryTextColor),
        bodyLarge: TextStyle(fontSize: 11, color: secondaryTextColor),
        titleLarge:
            TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: secondaryTextColor),
      ));

  TextTheme get faPrimaryTextTheme => TextTheme(
        bodyMedium: TextStyle(
            fontSize: 15, color: primaryTextColor, fontFamily: 'Lalezar'),
        bodyLarge: TextStyle(
            fontSize: 11, color: secondaryTextColor, fontFamily: 'Estedad'),
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: 'Estedad'),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: secondaryTextColor,
            fontFamily: 'Estedad'),
            labelLarge: TextStyle(fontFamily: 'Estedad'),
      );
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;
  const MyHomePage(
      {super.key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ActorsType {
  micheal,
  david,
  adria,
  benedict,
  niamh,
}

class _MyHomePageState extends State<MyHomePage> {
  ActorsType actorsType = ActorsType.micheal;
  _Language _language = _Language.en;

  void updateSelectedState(ActorsType actorsType) {
    setState(() {
      this.actorsType = actorsType;
    });
  }

  void updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      this._language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profileTitle,
            style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          InkWell(
            onTap: widget.toggleThemeMode,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/GoodOmens.jpg',
                        width: 80,
                        height: 80,
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(localization.name,
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(localization.genre,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 15)),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.film_fill,
                                size: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                              const SizedBox(width: 3),
                              Text(localization.director,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Text(
                localization.summery,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.selectedLanguage, style:Theme.of(context)
                          .textTheme
                          .titleLarge!.copyWith(fontSize: 14)),
                  CupertinoSlidingSegmentedControl<_Language>(
                      groupValue: _language,
                      children: {
                        _Language.en: Text(localization.enLanguage,
                            style: Theme.of(context)
                          .textTheme
                          .titleLarge!.copyWith(fontSize: 12)),
                        _Language.fa: Text(localization.faLanguage,
                            style: Theme.of(context)
                          .textTheme
                          .titleLarge!.copyWith(fontSize: 12))
                      },
                      onValueChanged: (value) {
                        if (value != null) updateSelectedLanguage(value);
                      }),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(localization.actors,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 2),
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 12,
                  ),
                ],
              ),
            ),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Actors(
                    type: ActorsType.micheal,
                    title: 'Micheal Sheen',
                    imagePath: 'assets/images/ezi.png',
                    isActive: actorsType == ActorsType.micheal,
                    onTap: () {
                      updateSelectedState(ActorsType.micheal);
                    },
                  ),
                  Actors(
                    type: ActorsType.david,
                    title: 'David Tannant',
                    imagePath: 'assets/images/crowly.png',
                    isActive: actorsType == ActorsType.david,
                    onTap: () {
                      updateSelectedState(ActorsType.david);
                    },
                  ),
                  Actors(
                    type: ActorsType.adria,
                    title: 'Adria Arjona',
                    imagePath: 'assets/images/witch.png',
                    isActive: actorsType == ActorsType.adria,
                    onTap: () {
                      updateSelectedState(ActorsType.adria);
                    },
                  ),
                  Actors(
                    type: ActorsType.benedict,
                    title: 'Benedict Cumberbatch',
                    imagePath: 'assets/images/benedict.png',
                    isActive: actorsType == ActorsType.benedict,
                    onTap: () {
                      updateSelectedState(ActorsType.benedict);
                    },
                  ),
                  Actors(
                    type: ActorsType.niamh,
                    title: 'Niamh Walsh',
                    imagePath: 'assets/images/actor.png',
                    isActive: actorsType == ActorsType.niamh,
                    onTap: () {
                      updateSelectedState(ActorsType.niamh);
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localization.comments,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                        labelText: localization.username,
                        prefixIcon: Icon(CupertinoIcons.at)),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                        labelText: localization.yourcomment,
                        prefixIcon:
                            Icon(CupertinoIcons.bubble_left_bubble_right)),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(localization.save),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Actors extends StatelessWidget {
  final ActorsType type;
  final String title;
  final String imagePath;
  final bool isActive;
  final Function() onTap;

  const Actors({
    super.key,
    required this.type,
    required this.title,
    required this.imagePath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 110,
        height: 110,
        alignment: Alignment.center,
        decoration: isActive
            ? BoxDecoration(
                color: const Color.fromARGB(35, 255, 255, 255),
                borderRadius: BorderRadius.circular(16))
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Container(
                child: Image.asset(
                  imagePath,
                  width: 80,
                  height: 60,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

enum _Language {
  en,
  fa,
}
