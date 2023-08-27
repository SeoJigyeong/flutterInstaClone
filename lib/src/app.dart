import 'package:flutter/material.dart';
import 'package:flutter_clone_instagram/src/components/image_data.dart';
import 'package:flutter_clone_instagram/src/controller/bottom_nav_controller.dart';
import 'package:flutter_clone_instagram/src/pages/active_history.dart';
import 'package:flutter_clone_instagram/src/pages/home.dart';
import 'package:flutter_clone_instagram/src/pages/mypage.dart';
import 'package:flutter_clone_instagram/src/pages/search.dart';
import 'package:get/get.dart';

/* GetView<BottomNavController>는
* GetView를 통해 보다 간결하게 GetxController나 GetxService를 StatelessWidget에 추가할 수 있다.
* */
class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* (onwillpop =  뒤로가기) 누르면 이벤트가 호출된다.
    *  1. child 와 onwillPopScope로 구성된다.
    * Scaffold 안에 appbar와 body, bottomNavigationBar로 구성된다.
    * BottomNavigationBar객체에 icon을 넣을 수 있다.
    * icon에 실 경로를 넣을 수도 있지만, image_date.dart 컴포넌트를 따로 만드는 방법도 있다(ImageData).
    * */
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const Home(),
              Navigator(
                key: controller.searchPageNaviationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(
                    builder: (context) => const Search(),
                  );
                },
              ),
              Container(),
              const ActiveHistory(),
              const MyPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            /*Bottion 네비게이션 바가 활성화되면 올라가는 현상이 있는데
            * fixed처리를 하면된다.
            * currentIndex로 처음에 활성화될 아이콘을 선택하면 된다.
            * elevation 설정을 하지 않아야 위로 뜨는 현상이 없어진다.
            * backgroundColor도 따로 설정이 가능하다.
            * */
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff),
                activeIcon: ImageData(IconsPath.homeOn),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.searchOff),
                activeIcon: ImageData(IconsPath.searchOn),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.uploadIcon),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.activeOff),
                activeIcon: ImageData(IconsPath.activeOn),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                label: 'home',
              ),
            ],
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
