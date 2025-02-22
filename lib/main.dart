


import 'package:assignment3/profile_picture.dart';
import 'package:assignment3/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'network_utils.dart';void main() {
  NetworkUtils.initNetworkListener();
  runApp(SimpleCalculatorApp());

  runApp(SimpleCalculatorApp());
}

class SimpleCalculatorApp extends StatefulWidget {
  @override
  _SimpleCalculatorAppState createState() => _SimpleCalculatorAppState();
}

class _SimpleCalculatorAppState extends State<SimpleCalculatorApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    var themePreference = await ThemePreferences().getThemeMode();
    setState(() {
      _themeMode = _getThemeMode(themePreference);
    });
  }

  ThemeMode _getThemeMode(ThemeModePreference themePreference) {
    switch (themePreference) {
      case ThemeModePreference.Light:
        return ThemeMode.light;
      case ThemeModePreference.Dark:
        return ThemeMode.dark;
    }
  }

  void updateTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Calculator', // Keep this line
      localizationsDelegates: [
        TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      theme: ThemeData.light(), // Keep this line
      darkTheme: ThemeData.dark(), // Keep this line
      themeMode: _themeMode, // Keep this line
      home: TabNavigation(), // Keep this line
    );
  }


  }


class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SignInScreen(),
    SignUpScreen(),
    Calculation(),
    SettingsScreen(),
    HelpScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "Home Screen",
          style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.teal),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'User Name',
                style: TextStyle(color: Colors.teal[600]),
              ),
              accountEmail: Text(
                'user@example.com',
                style: TextStyle(color: Colors.teal[600]),
              ),


              currentAccountPicture: ProfilePicture(),
               decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              leading: Icon(Icons.login, color: Colors.orange[900]),
              title: Text('Sign In'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration, color: Colors.blue[900]),
              title: Text('Sign Up'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate, color: Colors.green),
              title: Text('Calculator'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.blue),
              title: Text('Help'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login, color: Colors.lightGreenAccent),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration, color: Colors.orangeAccent),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate, color: Colors.indigoAccent),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help, color: Colors.blue),
            label: 'Help',
          ),
        ],
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In", style: TextStyle(color: Colors.teal[900])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle sign in logic here
                String username = _usernameController.text;
                String password = _passwordController.text;
                print('Username: $username, Password: $password');
              },
              child: Text('Sign In', style: TextStyle(color: Colors.teal[900])),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: TextStyle(color: Colors.teal[900])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle sign up logic here
                String username = _usernameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                print('Username: $username, Email: $email, Password: $password');
              },
              child: Text('Sign Up', style: TextStyle(color: Colors.teal[900])),
            ),
          ],
        ),
      ),
    );
  }
}

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  List<dynamic> inputList = [0];
  String output = '0';

  void _handleClear() {
    setState(() {
      inputList = [0];
      output = '0';
    });
  }

  void _handlePress(String input) {
    setState(() {
      if (_isOperator(input)) {
        if (inputList.last is int) {
          inputList.add(input);
          output += input;
        }
      } else if (input == '=') {
        while (inputList.length > 2) {
          int firstNumber = inputList.removeAt(0) as int;
          String operator = inputList.removeAt(0);
          int secondNumber = inputList.removeAt(0) as int;
          int partialResult = 0;

          if (operator == '+') {
            partialResult = firstNumber + secondNumber;
          } else if (operator == '-') {
            partialResult = firstNumber - secondNumber;
          } else if (operator == '*') {
            partialResult = firstNumber * secondNumber;
          } else if (operator == '/') {
            partialResult = firstNumber ~/ secondNumber;
            // Protect against division by zero
            if (secondNumber == 0) {
              partialResult = firstNumber;
            }
          }

          inputList.insert(0, partialResult);
        }

        output = '${inputList[0]}';
      } else {
        int? inputNumber = int.tryParse(input);
        if (inputNumber != null) {
          if (inputList.last is int && !_isOperator(output[output.length - 1])) {
            int lastNumber = (inputList.last as int);
            lastNumber = lastNumber * 10 + inputNumber;
            inputList.last = lastNumber;

            output = output.substring(0, output.length - 1) + inputNumber.toString();
          } else {
            inputList.add(inputNumber);
            output += inputNumber.toString();
          }
        }
      }
    });
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator', style: TextStyle(color: Colors.teal[900])),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Divider(height: 0),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildCalcButton('7'),
                  _buildCalcButton('8'),
                  _buildCalcButton('9'),
                  _buildCalcButton('/'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildCalcButton('4'),
                  _buildCalcButton('5'),
                  _buildCalcButton('6'),
                  _buildCalcButton('*'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildCalcButton('1'),
                  _buildCalcButton('2'),
                  _buildCalcButton('3'),
                  _buildCalcButton('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildCalcButton('0'),
                  _buildCalcButton('C'),
                  _buildCalcButton('='),
                  _buildCalcButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalcButton(String buttonText) {
    return MaterialButton(
      padding: EdgeInsets.all(24),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24),
      ),
      onPressed: () {
        if (buttonText == 'C') {
          _handleClear();
        } else {
          _handlePress(buttonText);
        }
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final ThemePreferences _themePreferences = ThemePreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.teal[900])),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _themePreferences.setThemeMode(ThemeModePreference.Light);
                _updateTheme(context, ThemeMode.light);
                _showSnackBar(context, 'Switched to Light Theme');
              },
              child: Text('Switch to Light Theme', style: TextStyle(color: Colors.teal[900])),
            ),
            ElevatedButton(
              onPressed: () async {
                await _themePreferences.setThemeMode(ThemeModePreference.Dark);
                _updateTheme(context, ThemeMode.dark);
                _showSnackBar(context, 'Switched to Dark Theme');
              },
              child: Text('Switch to Dark Theme', style: TextStyle(color: Colors.teal[900])),
            ),

          ElevatedButton(
            onPressed: () {
              _showLanguageDialog(context);
            },
            child: Text('Change Language'),
          ),
        ],
      ),
    ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text('English'),
                value: 'en',
                groupValue: 'en', // default language
                onChanged: (value) {
                  _changeLanguage(context, value!);
                },
              ),
              RadioListTile(
                title: Text('French'),
                value: 'fr',
                groupValue: 'en', // default language
                onChanged: (value) {
                  _changeLanguage(context, value!);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    // Save the language code to shared preferences
    // ...
    Navigator.pop(context);
  }

  }

  void _updateTheme(BuildContext context, ThemeMode themeMode) {
    var appState = context.findAncestorStateOfType<_SimpleCalculatorAppState>();
    appState?.updateTheme(themeMode);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    ));
  }


class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help", style: TextStyle(color: Colors.teal[900])),
      ),
      body: Center(
        child: Text(
          "Help content goes here.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

enum ThemeModePreference {
  Light,
  Dark,
}

class ThemePreferences {
  static const String _themeKey = 'theme_preference';

  Future<ThemeModePreference> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeIndex = prefs.getInt(_themeKey) ?? ThemeModePreference.Light.index;
    return ThemeModePreference.values[themeIndex];
  }

  Future<void> setThemeMode(ThemeModePreference themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index);
  }
}