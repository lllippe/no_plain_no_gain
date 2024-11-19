import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/screens/allUserDiets_screen/user_diet_screen.dart';
import 'package:no_plain_no_gain/screens/common_screen/menu_drawer.dart';
import 'package:no_plain_no_gain/screens/login_screen/login_screen.dart';
import 'package:no_plain_no_gain/screens/store_screen/store_screen.dart';
import 'package:no_plain_no_gain/screens/warnings_screen/warning.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;

  const HomeScreen({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String email = '';
  String userId = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();

    (widget.selectedIndex > 0)
        ? _selectedIndex = widget.selectedIndex
        : _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[];
    var deviceData = MediaQuery.of(context);
    double width_screen = deviceData.size.width;
    double heigth_screen = deviceData.size.height;
    setState(() {
      _widgetOptions.add(Warning(
        width_screen: width_screen,
        heigth_screen: heigth_screen,
      ));
      _widgetOptions.add(const UserDietScreen());
      //_widgetOptions.add(const FoodSearchScreen());
      //_widgetOptions.add(AddUserMesureScreen(
      //  width_screen: width_screen,
      //  heigth_screen: heigth_screen,
      //));
      _widgetOptions.add(const StoreScreen());
    });
    return Scaffold(
      appBar: AppBar(
        shape: const  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15),
          ),
        ),
        foregroundColor: Colors.greenAccent,
        title: const Text('No plan, no gain!'),
        titleTextStyle: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
              //logout(context);
            },
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Sair',
          )
        ],
      ),
      body: SizedBox(
          width: width_screen,
          child: _widgetOptions
              .elementAt(_selectedIndex) //ListTileSelectExample(),
          ),
      drawer: Drawer(child: menuDrawer(context)),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(color: Colors.white70, width: 3),
          ),
        ),
        child: bottomNavigationMenu(),
      ),
    );
  }

  BottomNavigationBar bottomNavigationMenu() {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.announcement_rounded),
          label: 'Avisos',
          backgroundColor: Colors.greenAccent,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'Minhas dietas',
          backgroundColor: Colors.greenAccent,
        ),
        //BottomNavigationBarItem(
        //  icon: Icon(Icons.apartment_rounded),
        //  label: 'Minhas medidas',
        //  backgroundColor: Colors.greenAccent,
        //),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart_sharp),
          label: 'Loja',
          backgroundColor: Colors.greenAccent,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.greenAccent,
      onTap: _onItemTapped,
    );
  }

  void refresh() async {
    int sizeList = 0;
    SharedPreferences.getInstance().then((prefs) {
      String? firstName = prefs.getString('first_name');
      String? lastName = prefs.getString('last_name');

      //if (firstName != null && lastName != null) {
      //  email = firstName;
      //} else {
      //  Navigator.pushReplacementNamed(context, 'login');
      //}
    });
  }
}
