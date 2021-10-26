import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/home/model/nft_list_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:wallet/widgets/list_placeholder.dart';
import 'package:wd_common_package/wd_common_package.dart';

///NFT
class NftDetailsPage extends StatefulWidget {
  final MintNftInfo mintNftInfo;

  NftDetailsPage({Key? key, required this.mintNftInfo}) : super(key: key);

  @override
  _NftDetailsPageState createState() => _NftDetailsPageState();
}

class _NftDetailsPageState extends State<NftDetailsPage> {
  final placeholder =
      getPlaceholder(double.maxFinite, double.maxFinite, 12, const Color(0xFF1B1B1C));

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Scaffold(
      appBar: WalletBar(
        leading: AppBackButton(),
        showBackButton: true,
        title: const Text('Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: buildNftPreview(),
          ),
          const SizedBox(height: 20),
          Text(
            widget.mintNftInfo.nftInfo.name,
            style: const TextStyle(height: 24 / 20, fontSize: 20, fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            widget.mintNftInfo.nftInfo.description,
            style: const TextStyle(height: 22 / 14),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: TextButton(
            child: const Text('Send'),
            onPressed: () {
              //send NFT to others
              service.router.pushNamed(RouteName.nftSendPage, arguments: widget.mintNftInfo);
            },
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                primary: appColors.textColor1,
                backgroundColor: appColors.dividerColor,
                fixedSize: const Size.fromHeight(56),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Widget buildNftPreview() {
    /// todo
   var preview = buildImagePreview();
    return preview;
  }

  ///NFT
  Widget buildImagePreview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      // color: Colors.black,
      child: FractionallySizedBox(
        widthFactor: 2 / 3,
        child: service.image.network(
          widget.mintNftInfo.nftInfo.image,
          fit: BoxFit.cover,
          width: double.maxFinite,
          loadingWidget: placeholder,
          loadFailedWidget: placeholder,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  ///NFT
  Widget buildAudioPreview() {
    // mintNft.image =
    //     'https://th.bing.com/th/id/OIP.9TSMJGQjXlsMp5bI82ii-gHaE8?pid=ImgDet&rs=1';
    return LayoutBuilder(builder: (context, box) {
      return Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 327 / 417,
            child: Container(
              color: Colors.white,
              constraints: box,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                  tileMode: TileMode.clamp,
                ),
                child: service.image.network(
                  widget.mintNftInfo.nftInfo.image,
                  fit: BoxFit.cover,
                  loadingWidget: placeholder,
                  loadFailedWidget: placeholder,
                ),
              ),
            ),
          ),
          service.svg.asset(
            Assets.assets_svg_ic_nft_audio_circle_svg,
            width: 108 / 156 * box.maxWidth,
          ),
          service.image.network(
            widget.mintNftInfo.nftInfo.image,
            fit: BoxFit.cover,
            shape: BoxShape.circle,
            width: 60 / 156 * box.maxWidth,
            height: 60 / 156 * box.maxWidth,
            loadingWidget: placeholder,
            loadFailedWidget: placeholder,
          ),
          service.svg.asset(
            Assets.assets_svg_ic_nft_audio_play_svg,
            width: 28 / 156 * box.maxWidth,
          ),
        ],
      );
    });
  }

  VideoPlayerController? _videoController;


  Widget buildVRPreview() => buildImagePreview();
}
