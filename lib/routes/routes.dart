import 'package:get/get.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = "/splash";
  static const String signIn = "/signin";
  static const String home = "/home";

  ///==============================Timekeeping app==================================
  static const String chooseAppScreen = "/chooseAppScreen";
  static const String tkHomePage = "/tkHomePage";
  static const String employeeList = "/employeeList";
  // MEAS ======================================================================================================

  //EMPLOYEE

  static const String managementEmployee = "/managementEmployee";
  static const String profile = "/profile";
  static const String notification = "/notification";
  static const String personalInformation = "/personalInformation";
  static const String relativeInformation = "relativeInformation";
  static const String relative = "/relative";
  static const String listRelative = "/listRelative";
  static const String profileRelative = "/profileRelative";

  //SALARY
  static const String salaryStatistic = "/salaryStatistic";
  static const String managementSalary = "/managementSalary";
  static const String salaryRanking = "/salaryRanking";
  static const String salaryInfor = "/salaryInfor";
  static const String salaryRanks = "/salaryRanks";
  static const String createEmployeeSalary = "/createEmployeeSalary";
  //============================================================================================================
//ADMIN
  static const String adminPage = "/adminPage";
  static const String choosePage = "/choosePage";
  ///////////////////////////////////////////////////
  static const String createBonusPage = "/createBonusPage";
  static const String bonusListPage = "/bonusListPage";
  static const String showBonusesByEmployeeId1 = "/showBonusesByEmployeeId";
  ///////////////////////////////////////////////////
  static const String createDisciplinePage = "/createDisciplinePage";
  static const String disciplineListPage = "/disciplineListPage";
  static const String showDisciplinesByEmployeeId =
      "/showDisciplinesByEmployeeId";
  static const String rankSalaryPersonal = "/rankSalaryPersonal";
  static const String orderPage = "/orderPage";
  static const String mainPage = "/mainPage";
  // ///Alias ​​mapping page
  // static final List<GetPage> getPages = [
  //   // GetPage(name: signIn, page: () => const SignInPage()),
  //   GetPage(name: home, page: () => const Signin()),

  //   ///===================Timekeeping App=============================

  //   GetPage(
  //     name: chooseAppScreen,
  //     page: () => const ChooseAppScreen(),
  //   ),
  //   GetPage(
  //     name: tkHomePage,
  //     page: () => const HomePage(
  //         // arguments: Get.arguments,
  //         ),
  //   ),
  //   //MEAS =============================================================================================
  //   // GetPage(name: managementEmployee, page: () => HomePage()),
  //   // GetPage(name: managementSalary, page: () => salary()),
  // ];
}
