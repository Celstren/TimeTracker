class ConstantHelper {
  static const int USER_TYPE_ADMIN_ID = 1;
  static const int USER_TYPE_OWNER_ID = 2;
  static const int USER_TYPE_VET_ID   = 3;

  static const List<int> USER_TYPES    = [USER_TYPE_ADMIN_ID, USER_TYPE_OWNER_ID, USER_TYPE_VET_ID];
  static const String AUDIO_DEFAULT_NAME = "/record_"; // flutter_audio_recorder
}
