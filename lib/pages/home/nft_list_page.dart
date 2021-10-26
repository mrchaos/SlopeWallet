import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/nft/nft_details_page.dart';
import 'package:wallet/slope_widget/text_field.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/list_placeholder.dart';
import 'package:wallet/widgets/placeholder/no_data_place_holder.dart';

import 'model/nft_list_model.dart';

final searchNFTNotifier = ValueNotifier<bool>(false);

class NftListPage extends StatefulWidget {
  const NftListPage({
    Key? key,
  }) : super(key: key);

  @override
  _NftListPageState createState() => _NftListPageState();
}

class _NftListPageState extends State<NftListPage> with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();
  final _focus = FocusNode();

  @override
  bool get wantKeepAlive => true;
  final _refreshController =
      RefreshController(initialRefresh: true, initialRefreshStatus: RefreshStatus.refreshing);

  void _onRefresh(NftListViewModel viewModel) async {
    try {
      /// 
      await viewModel.refreshNftList().timeout(const Duration(seconds: 30));
    } finally {
      _refreshController.refreshCompleted(resetFooterState: true);
      // print('Im Done Here too');
    }
  }

  @override
  void initState() {
    super.initState();
    searchNFTNotifier.addListener(_onSearchStatusChange);
  }

  NftListViewModel? _viewModel;

  void _onSearchStatusChange() {
    if (searchNFTNotifier.value != true) {
      // logger.d('_NftListPageState.buildSearchBox: cancel search NFT');
      _searchController.clear();
      _viewModel?.searchText = '';
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    _focus.unfocus();
    searchNFTNotifier.removeListener(_onSearchStatusChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) {
        _viewModel = NftListViewModel();
        return _viewModel!;
      },
      child: buildNftList(),
    );
  }

  Widget buildNftList() {
    return Builder(builder: (context) {
      final appColors = context.appColors;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SmartRefresher(
          enablePullUp: false,
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: () => _onRefresh(context.read<NftListViewModel>()),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child: ValueListenableBuilder<bool>(
                valueListenable: searchNFTNotifier,
                child: buildSearchBox(),
                builder: (c, isSearch, child) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  height: isSearch ? 44 : 0,
                  child: child!,
                  margin: EdgeInsets.only(bottom: 16, top: isSearch ? 8 : 0),
                ),
              )),

              //NTF
              SliverVisibility(
                visible: context.select((NftListViewModel vm) => vm.mintNftList.isEmpty),
                sliver: SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: NoDataPlaceHolder(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
              _collectionList(context)
            ],
          ),
        ),
      );
    });
  }

  ///NFT
  Widget buildSearchBox() {
    return Builder(builder: (context) {
      final appColors = context.appColors;
      return Row(
        children: [
          Expanded(
            child: SlopeSearchTextField(
              hintText: 'Search for your collection',
              controller: _searchController,
              focusNode: _focus,
              onChanged: (text) => context.read<NftListViewModel>().searchText = text,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              context.read<NftListViewModel>().searchText = '';
              searchNFTNotifier.value = false;
            },
            child: service.svg.asset(
              context.isLightTheme
                  ? Assets.assets_svg_ic_exit_search_nft_light_svg
                  : Assets.assets_svg_ic_exit_search_nft_dark_svg,
            ),
          )
        ],
      );
    });
  }

  /// NFT
  SliverVisibility _collectionList(BuildContext context) {
    final mintNftList = context.select((NftListViewModel vm) => vm.mintNftList);
    return SliverVisibility(
      visible: mintNftList.isNotEmpty,
      sliver: SliverLayoutBuilder(
        builder: (c, box) {
          return SliverToBoxAdapter(
            child: StaggeredGridView.countBuilder(
              itemCount: mintNftList.length,
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.only(bottom: 16),
              physics: const NeverScrollableScrollPhysics(),
              staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              itemBuilder: (c, index) {
                var mintNft = mintNftList[index];
                return NftTile(nft: mintNft);
              },
            ),
          );
        },
      ),
    );
  }
}

const _kBorderRadius = 12.0;

///NFT
class NftTile extends StatelessWidget {
  final MintNftInfo nft;

  NftTile({Key? key, required this.nft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    // print('NftTile.build ${mintNft.name}: ${mintNft.image}');
    return LayoutBuilder(builder: (context, box) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //NFT
          service.router.pushNamed(RouteName.nftDetailPage, arguments: nft);
        },
        child: OpenContainer(
          closedElevation: 0,
          openElevation: 0,
          openBuilder: (c, action) => NftDetailsPage(mintNftInfo: nft),
          openColor: Colors.transparent,
          closedColor: Colors.transparent,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kBorderRadius),
          ),
          closedBuilder: (c, action) => Container(
            constraints: box,
            decoration: BoxDecoration(
              color: context.isLightTheme ? appColors.onBackgroundColor : appColors.dividerColor,
              borderRadius: BorderRadius.circular(_kBorderRadius),
              border: Border.all(
                  width: 1, color: AppTheme.of(context).currentColors.textColor4.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  child: buildNftPreview(),
                  borderRadius: BorderRadius.circular(_kBorderRadius),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    nft.nftInfo.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 18 / 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildNftPreview() {
    Widget preview;
    switch (nft.nftInfo.properties?.category ?? MetadataCategory.image) {
      case MetadataCategory.audio:
        preview = buildAudioPreview();
        break;
      case MetadataCategory.video:
        preview = buildVideoPreview();
        break;
      case MetadataCategory.vr:
        preview = buildVRPreview();
        break;
      case MetadataCategory.image:
      default:
        preview = buildImagePreview();
        break;
    }
    return preview;
  }

  ///NFT
  Widget buildImagePreview() {
    return LayoutBuilder(
      builder: (c, box) => Container(
        color: Colors.black,
        child: ExtendedImage.network(
          nft.nftInfo.image,
          width: box.maxWidth,
          constraints: BoxConstraints(maxHeight: box.maxWidth * 3 / 2),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  var placeholder = getPlaceholder(double.maxFinite, double.maxFinite, 12, const Color(0xFF1B1B1C));

  ///NFT 
  Widget buildAudioPreview() {
    // mintNft.image =
    //     'https://th.bing.com/th/id/OIP.9TSMJGQjXlsMp5bI82ii-gHaE8?pid=ImgDet&rs=1';
    return LayoutBuilder(builder: (context, box) {
      return Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 156 / 156,
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
                  nft.nftInfo.image,
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
            nft.nftInfo.image,
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

  Stack buildVideoPreview() {
    // mintNft.image = 'https://th.bing.com/th/id/OIP.9TSMJGQjXlsMp5bI82ii-gHaE8?pid=ImgDet&rs=1';
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: service.image.network(
            nft.nftInfo.image,
            fit: BoxFit.cover,
            width: double.maxFinite,
            loadingWidget: placeholder,
            loadFailedWidget: placeholder,
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.all(12),
          child: service.svg.asset(
            Assets.assets_svg_ic_nft_audio_play_svg,
            width: 20,
          ),
        ),
      ],
    );
  }

  Widget buildVRPreview() => buildImagePreview();
}
