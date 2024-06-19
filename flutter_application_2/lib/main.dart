import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(133, 72, 177, 252),
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 68, 157, 236))
          .copyWith(background: const Color.fromARGB(133, 72, 177, 252)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<bool> _isVisible = [true, false, false, false, false];

  void _nextTab() {
    if (_selectedIndex < _isVisible.length - 1) {
      setState(() {
        _selectedIndex++;
        _isVisible[_selectedIndex] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            minWidth: 150,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              if (_isVisible[index]) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            labelType: NavigationRailLabelType.all,
            elevation: null,
            destinations: [
              NavigationRailDestination(
                icon: _isVisible[0] ? Icon(Icons.home) : SizedBox.shrink(),
                label: _isVisible[0] ? Text('Home') : SizedBox.shrink(),
              ),
              NavigationRailDestination(
                icon: _isVisible[1]
                    ? Icon(Icons.account_circle)
                    : SizedBox.shrink(),
                label: _isVisible[1] ? Text('Profile') : SizedBox.shrink(),
              ),
              NavigationRailDestination(
                icon: _isVisible[2] ? Icon(Icons.palette) : SizedBox.shrink(),
                label: _isVisible[2] ? Text('Hobby') : SizedBox.shrink(),
              ),
              NavigationRailDestination(
                icon: _isVisible[3]
                    ? Icon(Icons.lightbulb_outline)
                    : SizedBox.shrink(),
                label: _isVisible[3] ? Text('Interest') : SizedBox.shrink(),
              ),
              NavigationRailDestination(
                icon: _isVisible[4] ? Icon(Icons.contacts) : SizedBox.shrink(),
                label: _isVisible[4] ? Text('Contact') : SizedBox.shrink(),
              ),
            ],
          ),
          Container(
            width: 1,
            color: Colors.transparent,
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                HomePage(),
                ProfilePage(), 
                HobbyPage(),
                InterestPage(),
                ContactsPage()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedIndex < _isVisible.length - 1
          ? FloatingActionButton(
              onPressed: _nextTab,
              child: Icon(Icons.navigate_next),
              tooltip: 'Next',
            )
          : null,
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Center(
          child: Text(
            'Introduce Myself',
            style: TextStyle(
              fontSize: 30,
              color: const Color.fromARGB(246, 0, 0, 0),
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showDetails = false;

  void toggleDetails() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 600,
        height: 700,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            SizedBox(height: 30),
            Text(
              '서영빈',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2003.07.04',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleDetails,
              child: Text(showDetails ? 'Hide Details' : 'Show Details'),
            ),
            if (showDetails) ...[
              SizedBox(height: 10),
              Text(
                'University: 단국대학교 SW융합대학 컴퓨터공학과\nResidence: 용인시 기흥구\nInsta ID: seybeses',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.7
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HobbyPage extends StatelessWidget {
  final List<Hobby> hobbies = [
    Hobby(imagePath: 'assets/game1.png'),
    Hobby(imagePath: 'assets/game2.png'),
    // Add more hobbies as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 100.0),
      children: [
        _buildHobbyBoxWithImages(hobbies),
        SizedBox(height: 20), // 두 박스 사이 간격 추가
        _buildEmptyHobbyBox(),
      ],
    );
  }

  Widget _buildHobbyBoxWithImages(List<Hobby> hobbies) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 750,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: hobbies.map((hobby) {
                return Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      hobby.imagePath,
                      height: 250, // 이미지 높이 설정
                      width: 250, // 이미지 너비 설정
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyHobbyBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20), // 원하는 만큼 이동
      child: Align(
        alignment: Alignment.center, // 중앙 정렬
        child: Container(
          margin: EdgeInsets.all(10),
          width: 750, // 너비 설정
          height: 350, // 높이 설정
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Listen to music',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSongImage('assets/song1.jpg'),
                  _buildSongImage('assets/song2.jpg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        height: 280, // 이미지 높이 조정
        width: 280, // 이미지 너비 조정
      ),
    );
  }
}

class Hobby {
  final String imagePath;

  Hobby({required this.imagePath});
}

class InterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(133, 72, 177, 252),
      body: ListView(
        padding: const EdgeInsets.only(top: 100.0),
        children: [
          _buildInterestBox(
            title: 'Books',
            images: [
              'assets/book1.jpg',
              'assets/book2.png',
            ],
          ),
          SizedBox(height: 20), // 두 박스 사이 간격 추가
          _buildInterestBox(
            title: 'Travel',
            images: [
              'assets/travel1.jpg',
              'assets/travel2.jpg',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInterestBox({required String title, required List<String> images}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 750,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: images.map((imagePath) {
                return Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      height: 230, // 이미지 높이 설정
                      width: 230, // 이미지 너비 설정// 이미지가 박스에 꽉 차게 설정
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(133, 72, 177, 252),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                // 이메일 관련 동작
              },
              child: Icon(
                Icons.email,
                size: 100.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16.0), // 텍스트와의 간격 조정
            Text(
              'syb9822446@naver.com',
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 70.0), // 아이콘과 이미지 사이 간격
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10.0), // 왼쪽 마진 조정
                InkWell(
                  onTap: () {
                    _launchInstagram();
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/instagram.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 60.0), // 인스타그램과 깃허브 사이 간격
                InkWell(
                  onTap: () {
                    _launchGitHub();
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/github.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20.0), // 오른쪽 마진 조정
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchInstagram() async {
    const url = 'https://www.instagram.com/seybeses/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchGitHub() async {
    const url = 'https://github.com/seybeses';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}