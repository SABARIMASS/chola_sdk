class Assets {
  Assets._();
  static final Assets _instance = Assets._();
  static Assets get instance => _instance;
  static String loginBackground = "assets/background/background.png";
  static String cameraIcon = "lib/app/core/assets/images/camera.png";
  static String galleryIcon = "lib/app/core/assets/images/gallery_icon.png";
  static String appImage = "lib/app/core/assets/images/playstore.png";
  static String noImages = "lib/app/core/assets/images/no_image.jpg";
  static String paymentSuccessLottie = "assets/lottie/payment_success.json";
  static String noConnection = "lib/app/core/assets/svg_image/noConnection.svg";
  static String noData = "lib/app/core/assets/svg_image/noData.svg";
  static String showMessage = "lib/app/core/assets/svg_image/showMessage.svg";
}
