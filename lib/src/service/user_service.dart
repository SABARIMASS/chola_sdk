import 'package:cholai_sdk/cholai_sdk.dart';
import 'package:cholai_sdk/src/local_storage/storage_service.dart';
import 'package:cholai_sdk/src/model/profile_create_api_data.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  Rx<UserInfoData> userInfo = UserInfoData().obs;
  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  Future getUserInfo() async {
    userInfo.value = await StorageX.getUserData() ?? UserInfoData();
    userInfo.refresh();
    SocketService().connectSocket(userInfo.value.userId!);
    return;
  }

  void logInUserInfo(UserInfoData userData) async {
    StorageX.saveAccessToken('');
    StorageX.saveUserData(userData);
    await getUserInfo();
  }

  void updateUserInfo(UserInfoData userData) {
    StorageX.saveUserData(userData);
    getUserInfo();
  }
}
