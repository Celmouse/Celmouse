class EnviromentVariables {
  static String get admobBannerId {
    const id = String.fromEnvironment(
      'ADMOB_BANNER_ID',
      defaultValue: 'ca-app-pub-3940256099942544/2934735716',
    );
    return id;
  }

  static String get admobBannerIdAndroid {
    const id = String.fromEnvironment(
      'ADMOB_BANNER_ID_ANDROID',
      defaultValue: 'ca-app-pub-3940256099942544/6300978111',
    );
    return id;
  }
}
