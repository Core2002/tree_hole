class HoleConfig {
  static const String hostName ="hole.fifu.fun";
  static const int port = 8080;
  static String getURL(){
    return "http://$hostName:$port";
  }
}
