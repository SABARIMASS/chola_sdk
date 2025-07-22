enum NetworkType { mobileData, wifi, noNetWork, waiting }

enum AppStatus { background, foreground, launched, terminated }

enum AppLaunckStatus {
  kNoInternet,
  kSplash,
  kLogin,
  kDashBoard,
  kLoading,
  kOnBoardScreen,
}

enum SocketStatus {
  isConnecting,
  connected,
  onError,
  isDisconnected,
  disconnect,
  timeOut,
  reconnect,
}

enum Status { success, error, loading }

enum AppLaunchProgressStatus { kLocation, kGetCore, kNone }

enum CameraAction { kGallery, kCamera, kPdf, kDoc }

enum MessageStatus { sent, received, read, none, request, delivered }
