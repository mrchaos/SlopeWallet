import 'package:tuple/tuple.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_module_bean.dart';
import 'package:wallet/data/bean/browser_list.dart';
import 'package:wallet/pages/alumni/activity/model/ama_model.dart';
import 'package:wallet/pages/alumni/activity/model/ido_model.dart';
import 'package:wallet/pages/alumni/activity/view/ama_detail_page.dart';
import 'package:wallet/pages/alumni/activity/view/ido_detail_page.dart';
import 'package:wallet/pages/alumni/news/news_details/news_details_page.dart';
import 'package:wallet/pages/alumni/news/news_list/alumni_news_list_page.dart';
import 'package:wallet/pages/alumni/rank/rank_detail.dart';
import 'package:wallet/pages/browser/browser_Search_Page/browser_Search_Page.dart';
import 'package:wallet/pages/browser/browser_currency_details_page/browser_currency_details_page.dart';
import 'package:wallet/pages/browser/browser_module_list/brow_module_list_page.dart';
import 'package:wallet/pages/change_network/change_network_page.dart';
import 'package:wallet/pages/coin_detail/coin_detail_page.dart';
import 'package:wallet/pages/create_wallet/mnemonic_recommend_page.dart';
import 'package:wallet/pages/create_wallet/mnemonic_save_page.dart';
import 'package:wallet/pages/create_wallet/mnemonic_verification_page.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/create_wallet/wallet_create_page.dart';
import 'package:wallet/pages/create_wallet/wallet_password_page.dart';
import 'package:wallet/pages/create_wallet/wallet_reset_password_page.dart';
import 'package:wallet/pages/create_wallet/web_relogin_page.dart';
import 'package:wallet/pages/guide_page.dart';
import 'package:wallet/pages/home/about_main_page.dart';
import 'package:wallet/pages/home/create_coin_page/add_manual_token_page/add_manual_token_page.dart';
import 'package:wallet/pages/home/create_coin_page/create_coin_page.dart';
import 'package:wallet/pages/home/model/nft_list_model.dart';
import 'package:wallet/pages/home/select_coin_page.dart';
import 'package:wallet/pages/home/view/wallet_drawer.dart';
import 'package:wallet/pages/home/wallet_main_page.dart';
import 'package:wallet/pages/home/wallet_pay_page.dart';
import 'package:wallet/pages/home/wallet_scan_page.dart';
import 'package:wallet/pages/login_wallet/import_slope_wallet.dart';
import 'package:wallet/pages/navigation_page.dart';
import 'package:wallet/pages/nft/nft_details_page.dart';
import 'package:wallet/pages/nft/nft_send_page.dart';
import 'package:wallet/pages/notification/notify_page.dart';
import 'package:wallet/pages/profile/bulk_transfer_page.dart';
import 'package:wallet/pages/profile/message_center/message_center_page.dart';
import 'package:wallet/pages/profile/mnemonic_backup/mnemonic_backup_page.dart';
import 'package:wallet/pages/profile/mnemonic_backup/mnemonic_security_tips_page.dart';
import 'package:wallet/pages/profile/my_faq_detail_page.dart';
import 'package:wallet/pages/profile/my_faq_page.dart';
import 'package:wallet/pages/profile/my_profile_language.dart';
import 'package:wallet/pages/profile/my_profile_page.dart';
import 'package:wallet/pages/profile/private_key_export/export_key_page.dart';
import 'package:wallet/pages/profile/private_key_export/export_tips_page.dart';
import 'package:wallet/pages/profile/service_agreement/service_agreement.dart';
import 'package:wallet/pages/profile/wallet_detail_page.dart';
import 'package:wallet/pages/profile/wallet_list_page.dart';
import 'package:wallet/pages/swap/select_swap_coin_page.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/CommonWebview/common_webview.dart';
import 'package:wallet/widgets/web_view_page.dart';
import 'package:wallet/widgets/webview/webview_for_network.dart';
import 'package:wd_common_package/wd_common_package.dart';

///
class RouteName {
  /// ，Tab
  static const String navigationPage = "NavigationPage";

  //
  static const String walletGuidePage = "walletGuidePage";

  /// url
  static const String webView = "WebViewForNetwork";

  ///
  static const String walletAddrList = "WalletAddrList";

  ///
  static const String walletDetail = "walletDetail";

  ///
  static const String walletImportPage = "walletImportPage";

  ///
  static const String myProfilePage = "MyProfilePage";

  ///
  static const String coinDetail = "CoinDetail";

  /// pay
  static const String walletPayPage = "WalletPayPage";

  ///
  static const String createWalletPage = "CreateWalletPage";

  ///
  static const String mnemonicRecommendPage = "mnemonicRecommendPage";

  ///
  static const String mnemonicSavePage = "mnemonicSavePage";

  ///
  static const String mnemonicVerificationPage = "mnemonicVerificationPage";

  /// tips
  static const String mnemonicSecurityTipsPage = "MnemonicSecurityTipsPage";

  ///
  static const String mnemonicBackupPage = "MnemonicBackupPage";

  ///
  static const String walletPasswordPage = "WalletPasswordPage";

  ///
  static const String walletResetPasswordPage = "WalletResetPasswordPage";

  ///
  static const String exportKeyPage = "ExportKeyPage";

  static const String walletMainPage = "WalletMainPage";

  //
  static const String importSlopeWallet = 'importSlopeWallet';

  //
  static const String exportTipsPage = 'exportTipsPage';

  //
  static const String myProfileLanguage = 'myProfileLanguage';

  ///
  static const String walletListPage = 'WalletListPage';

  /// Drawer
  static const String walletDrawer = 'WalletDrawer';

  /// scan
  static const String walletScanPage = "WalletScanPage";

  // select coin
  static const String CreateCoinPage = 'CreateCoinPage';

  // about us
  static const String aboutMainPage = 'AboutMainPage';

  // webview
  static const String webViewPage = 'WebViewPage';

  // select coin for pay
  static const String selectCoinPage = 'SelectCoinPage';

  static const String browserModuleListPage = 'browserModuleListPage';

  /// browser
  static const String browserSearchPage = 'browserSearchPage';

  /// browser
  static const String browserCurrencyDetailsPage = 'browserCurrencyDetailsPage';

  static const String serviceAgreementPage = 'serviceAgreementPage';

  // faq
  static const String myFaqPage = 'MyFaqPage';

  // faq detail
  static const String myFaqDetailPage = 'MyFaqDetailPage';

  /// web
  static const String webReLoginPage = 'webReLoginPage';

  //
  static const String bulkTransPage = 'BulkTransPage';

  /// nft
  static const String nftDetailPage = 'nftDetailPage';

  static const String swapCoinPage = 'SwapCoinPage';

  /// nft
  static const String nftSendPage = 'nftSendPage';

  static const String newsDetailsPage = 'newsDetailsPage';

  //Activity：IDO
  static const String idoDetailPage = 'idoDetailPage';

  //Activity：AMA
  static const String amaDetailPage = 'amaDetailPage';

  static const String rankSeeAll = 'rankSeeAll';

  static const String alumniNewsListPage = 'alumniNewsListPage';

  /// flutterweb (pub_key )
  static const String beachHouses = 'flutterInteractWithWeb';
  static const String changeNetwork = 'changeNetwork';

  static const String commonWebViewPage = 'commonWebViewPage';

  //
  static const String MessageCenterPage = 'MessageCenterPage';

  //
  static const String addManualTokenPage = 'addManualTokenPage';

  static const String notificationPage = 'notificationPage';

  const RouteName._internal();
}

class RouterTable {
  ///
  static Map<String, BaseRoute> table = {
    RouteName.navigationPage: BaseRoute(
      builder: (context, setting) => NavigationPage(),
      routerType: RouterType.no_animate,
    ),
    RouteName.walletGuidePage: BaseRoute(
      builder: (context, setting) => GuidePage(),
      routerType: RouterType.no_animate,
    ),
    RouteName.webView: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments != null);
        assert(setting.arguments is Map<String, dynamic>);
        String url = "";
        String? title;
        if (setting.arguments is Map<String, dynamic>) {
          AiJson aJson = AiJson(setting.arguments);
          url = aJson.getString("url");
          title = aJson.getString("title");
        }
        return WebViewForNetwork(
          initUrl: url,
          title: title,
        );
      },
    ),
    RouteName.walletDetail: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is WalletEntity, "WalletEntity");
        return WalletDetailPage(entity: setting.arguments as WalletEntity);
      },
    ),
    RouteName.coinDetail: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is Map);
        Map mapTemp = setting.arguments as Map;
        WalletEntity wallet = mapTemp['wallet'];
        CoinEntity coin = mapTemp['coin'];
        return CoinDetailPage(walletEntity: wallet, coinEntity: coin);
      },
    ),
    RouteName.myProfilePage: BaseRoute(
      builder: (context, setting) => MyProfilePage(),
    ),
    RouteName.importSlopeWallet: BaseRoute(
      builder: (context, setting) {
        return ImportSlopeWalletPage(
          pageData: setting.arguments as WalletCreateRelatedData,
        );
      },
    ),
    RouteName.createWalletPage: BaseRoute(
      builder: (context, setting) => WalletCreatePage(
        pageData: WalletCreateRelatedData(isSetupPassword: true),
      ),
    ),

    RouteName.mnemonicRecommendPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is WalletCreateRelatedData);
        return MnemonicRecommendPage(pageData: setting.arguments as WalletCreateRelatedData);
      },
    ),
    RouteName.mnemonicSavePage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is WalletCreateRelatedData);
        return MnemonicSavePage(
          pageData: setting.arguments as WalletCreateRelatedData,
        );
      },
    ),
    RouteName.mnemonicVerificationPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is List<dynamic>);
        var arr = setting.arguments as List;
        return MnemonicVerificationPage(isBackup: arr.first, pageData: arr.last);
      },
    ),
    RouteName.walletPasswordPage: BaseRoute(
      builder: (context, setting) {
        if (setting.arguments != null && setting.arguments is WalletCreateRelatedData) {
          return WalletPasswordPage(pageData: setting.arguments as WalletCreateRelatedData);
        }
        return WalletPasswordPage(pageData: WalletCreateRelatedData(isLoginPasswordVerify: true));
      },
    ),
    RouteName.walletResetPasswordPage: BaseRoute(
      builder: (context, setting) {
        if (setting.arguments != null && setting.arguments is WalletCreateRelatedData) {
          return WalletResetPasswordPage(pageData: setting.arguments as WalletCreateRelatedData);
        }
        return WalletResetPasswordPage(pageData: WalletCreateRelatedData(isResetPassword: true));
      },
    ),
    RouteName.walletMainPage: BaseRoute(
      builder: (context, setting) => WalletMainPage(),
    ),
    RouteName.exportTipsPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is WalletEntity, "WalletEntity");
        return ExportTipsPage(entity: setting.arguments as WalletEntity);
      },
    ),
    RouteName.mnemonicSecurityTipsPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is WalletEntity, "WalletEntity");
        return MnemonicSecurityTipsPage(entity: setting.arguments as WalletEntity);
      },
    ),
    RouteName.mnemonicBackupPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is WalletEntity, "WalletEntity");
        return MnemonicBackupPage(entity: setting.arguments as WalletEntity);
      },
    ),
    RouteName.exportKeyPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is WalletEntity, "WalletEntity");
        return ExportKeyPage(entity: setting.arguments as WalletEntity);
      },
    ),
    RouteName.walletPayPage: BaseRoute(
      builder: (context, setting) {
        if (setting.arguments is! Map) return WalletPayPage();
        Map mapTemp = setting.arguments as Map;
        String url = mapTemp['url'] ?? '';
        if (null == mapTemp['coin']) {
          return WalletPayPage(url: url);
        }
        CoinEntity coin = mapTemp['coin'];
        return WalletPayPage(url: url, coinEntity: coin);
      },
    ),

    RouteName.myProfileLanguage: BaseRoute(
      builder: (context, setting) => MyProfileLanguagePage(),
    ),

    RouteName.walletListPage: BaseRoute(
      builder: (context, setting) {
        // assert(setting.arguments is bool, "");
        return WalletListPage();
      },
    ),

    RouteName.walletDrawer: BaseRoute(
      builder: (context, setting) {
        return WalletDrawer();
      },
    ),
    // BaseRoute<String?>： WalletScanPagepopString?
    RouteName.walletScanPage: BaseRoute<String?>(
      builder: (context, setting) => WalletScanPage(),
      routerType: RouterType.fade,
    ),
    RouteName.CreateCoinPage: BaseRoute(
      builder: (context, setting) => CreateCoinPage(),
    ),
    RouteName.aboutMainPage: BaseRoute(
      builder: (context, setting) => AboutMainPage(),
    ),
    RouteName.webViewPage: BaseRoute(
      builder: (context, setting) => WebViewPage(),
    ),
    RouteName.selectCoinPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is Function(CoinEntity));
        var temp = setting.arguments as Function(CoinEntity);
        return SelectCoinPage(selectCallback: temp);
      },
    ),

    RouteName.browserSearchPage: BaseRoute(
      builder: (context, setting) => BrowserSearchPage(),
    ),
    RouteName.browserCurrencyDetailsPage: BaseRoute(builder: (context, setting) {
      Map mapTemp = setting.arguments as Map;
      BrowserItemBean browserItemInfo = mapTemp['browserItemInfo'];
      return BrowserCurrencyDetailsPage(browserItemInfo: browserItemInfo);
    }),

    RouteName.serviceAgreementPage: BaseRoute(
      builder: (context, setting) => ServiceAgreementPage(),
    ),
    RouteName.myFaqPage: BaseRoute(
      builder: (context, setting) => MyFaqPage(),
    ),
    RouteName.myFaqDetailPage: BaseRoute(builder: (context, setting) {
      return MyFaqDetailPage(detailId: setting.arguments as num);
    }),
    RouteName.webReLoginPage: BaseRoute(
      builder: (context, setting) => WebReLoginPage(),
    ),
    RouteName.bulkTransPage: BaseRoute(
      builder: (context, setting) => BulkTransferPage(),


    RouteName.nftDetailPage: BaseRoute(
      builder: (context, setting) {
        assert(setting.arguments is MintNftInfo);
        final mintNft = setting.arguments as MintNftInfo;
        return NftDetailsPage(mintNftInfo: mintNft);
      },
    ),


    RouteName.newsDetailsPage: BaseRoute(
      builder: (context, setting) {
        Map mapTemp = setting.arguments as Map;
        int id = mapTemp["newsId"];
        return NewsDetailsPage(newsId: id);
      },
    ),

    RouteName.idoDetailPage: BaseRoute(
      builder: (context, setting) {
        Map mapTemp = setting.arguments as Map;
        Ido idoItemInfo = mapTemp['idoItemInfo'];
        return IdoDetailPage(idoItemInfo: idoItemInfo);
      },
    ),

    RouteName.amaDetailPage: BaseRoute(
      builder: (context, setting) {
        Map mapTemp = setting.arguments as Map;
        Ama amaItemInfo = mapTemp['amaItemInfo'];
        return AmaDetailPage(amaItemInfo: amaItemInfo);
      },
    ),

    RouteName.rankSeeAll: BaseRoute(builder: (_, __) => RankDetail()),

    RouteName.alumniNewsListPage: BaseRoute(builder: (context, setting) {
      Map mapTemp = setting.arguments as Map;
      int type = mapTemp["type"];
      AlumniNewsModuleBean alumniNewsListModule = mapTemp["newsListModule"];
      return AlumniNewsListPage(type: type, alumniNewsListModule: alumniNewsListModule);
    }),
    RouteName.changeNetwork: BaseRoute(
      builder: (context, setting) => ChangeNetworkPage(),
    ),

    RouteName.commonWebViewPage: BaseRoute(builder: (context, setting) {
      Map mapTemp = setting.arguments as Map;
      String title = mapTemp["title"] ?? '';
      String linkUrl = mapTemp["linkUrl"];

      if (title.isEmpty) {
        return CommonWebViewPage(linkUrl: linkUrl);
      } else {
        return CommonWebViewPage(
          linkUrl: linkUrl,
          title: title,
        );
      }
    }),

    RouteName.MessageCenterPage: BaseRoute(
      builder: (context, setting) => MessageCenterPage(),
    ),

    RouteName.addManualTokenPage: BaseRoute(
      builder: (context, setting) => AddManualTokenPage(),
    ),
    RouteName.notificationPage: BaseRoute(
      builder: (context, setting) => Notify(),
    ),
  };
}
