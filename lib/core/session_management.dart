import 'package:get_storage/get_storage.dart';

class SessionManagement {
  static const String APP_KEY = "eCart_app";
  static const String TOKEN_KEY = "token_key";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String EXPIRES_KEY = "expires_at";
  static const String NAME_KEY = "name_key";
  static const String EMAIL_KEY = "email_key";
  static const String PROFILE_IMAGE_KEY = "profile_image_key";
  static const String PHONE_KEY = "phone_key";
  static const String IS_GUEST = "is_guest";
  static const String IS_USER = "is_user";

  static late GetStorage _box;

  static Future<GetStorage> init() async {
    await GetStorage.init(APP_KEY);
    _box = GetStorage(APP_KEY);
    return _box;
  }

  static String? get accessToken => _box.read(TOKEN_KEY);

  static String? get refreshToken => _box.read(REFRESH_TOKEN);

  static String? get expiryDate => _box.read(EXPIRES_KEY);

  static String? get name => _box.read(NAME_KEY);

  static String? get email => _box.read(EMAIL_KEY);

  static String? get phone => _box.read(PHONE_KEY);

  static String? get imageUrl => _box.read(PROFILE_IMAGE_KEY);

  static bool get isGuest => _box.read(IS_GUEST) ?? false;

  static bool get isUser => _box.read(IS_USER) ?? false;

  static createUserSession(
      {required String accessToken,
      required String refreshToken,
      required String name,
      required String email,
      String? phone,
      required String image}) {
    _box.write(IS_USER, true);
    _box.write(IS_GUEST, false);
    _box.write(TOKEN_KEY, accessToken);
    _box.write(REFRESH_TOKEN, refreshToken);
    _box.write(NAME_KEY, name);
    _box.write(EMAIL_KEY, email);
    _box.write(PHONE_KEY, phone);
    _box.write(PROFILE_IMAGE_KEY, image);
    DateTime expiryDate = DateTime.now().add(Duration(minutes: 29));
    _box.write(EXPIRES_KEY, expiryDate.toIso8601String());
  }

  static createGuestSession() {
    _box.write(IS_GUEST, true);
    _box.write(IS_USER, false);
    _box.write(NAME_KEY, "Guest");
  }

  static logout() {
    _box.erase();
  }

  static refreshTokens(
      {required String accessToken, required String refreshToken}) {
    _box.write(TOKEN_KEY, accessToken);
    _box.write(REFRESH_TOKEN, refreshToken);
    DateTime expiryDate = DateTime.now().add(Duration(minutes: 29));
    _box.write(EXPIRES_KEY, expiryDate.toIso8601String());
  }

}