import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env') // Specify the path to your .env file
abstract class Env {
  @EnviedField(varName: 'FIREBASE_API_KEY_WEB')
  static final String apiKeyWeb = _Env.apiKeyWeb; // Use obfuscate: true for extra security (optional)

  @EnviedField(varName: 'FIREBASE_APP_ID_WEB')
  static final String appIdWeb = _Env.appIdWeb;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID_WEB')
  static final String messagingSenderIdWeb = _Env.messagingSenderIdWeb;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID_WEB')
  static final String projectIdWeb = _Env.projectIdWeb;

  @EnviedField(varName: 'FIREBASE_AUTH_DOMAIN_WEB')
  static final String authDomainWeb = _Env.authDomainWeb;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET_WEB')
  static final String storageBucketWeb = _Env.storageBucketWeb;

  @EnviedField(varName: 'FIREBASE_API_KEY_ANDROID')
  static final String apiKeyAndroid = _Env.apiKeyAndroid;

  @EnviedField(varName: 'FIREBASE_APP_ID_ANDROID')
  static final String appIdAndroid = _Env.appIdAndroid;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID_ANDROID')
  static final String messagingSenderIdAndroid = _Env.messagingSenderIdAndroid;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID_ANDROID')
  static final String projectIdAndroid = _Env.projectIdAndroid;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET_ANDROID')
  static final String storageBucketAndroid = _Env.storageBucketAndroid;

  @EnviedField(varName: 'FIREBASE_API_KEY_IOS')
  static final String apiKeyIOS = _Env.apiKeyIOS;

  @EnviedField(varName: 'FIREBASE_APP_ID_IOS')
  static final String appIdIOS = _Env.appIdIOS;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID_IOS')
  static final String messagingSenderIdIOS = _Env.messagingSenderIdIOS;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID_IOS')
  static final String projectIdIOS = _Env.projectIdIOS;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET_IOS')
  static final String storageBucketIOS = _Env.storageBucketIOS;

  @EnviedField(varName: 'FIREBASE_IOS_CLIENT_ID')
  static final String iosClientId = _Env.iosClientId;

  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID')
  static final String iosBundleId = _Env.iosBundleId;
}