import 'dart:io';

import 'package:controller/src/config/consent_manager.dart';
import 'package:controller/src/config/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({
    super.key,
    this.orientation = Orientation.portrait,
  });

  final Orientation orientation;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  // TODO: Add this [https://github.com/googleads/googleads-mobile-flutter/tree/main/samples/admob/banner_example]
  // var _isPrivacyOptionsRequired = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    _consentManager.gatherConsent((consentGatheringError) {
      // Check if a privacy options entry point is required.
      _getIsPrivacyOptionsRequired();

      // Attempt to initialize the Mobile Ads SDK.
      _initializeMobileAdsSDK();
    });

    // This sample attempts to load ads using consent obtained in the previous session.
    _initializeMobileAdsSDK();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  AdSize get adSize => widget.orientation == Orientation.portrait
      ? AdSize.fullBanner
      : AdSize.mediumRectangle;

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null && _isLoaded) {
      return RotatedBox(
        quarterTurns: widget.orientation == Orientation.landscape ? 1 : 0,
        child: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      );
    }
    return SizedBox(
      height: adSize.height.toDouble(),
      width: adSize.width.toDouble(),
    );
  }

  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the width of the screen.
  void _loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    if (!mounted) {
      return;
    }

    final String adUnitId = Platform.isAndroid
        ? EnviromentVariables.admobBannerIdAndroid
        : EnviromentVariables.admobBannerId;

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      widget.orientation,
      MediaQuery.sizeOf(context).width.truncate(),
    );

    if (size == null) {
      // Unable to get width of anchored banner.
      return;
    }

    BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: adSize,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // // Called when an ad opens an overlay that covers the screen.
        // onAdOpened: (Ad ad) {},
        // // Called when an ad removes an overlay that covers the screen.
        // onAdClosed: (Ad ad) {},
        // // Called when an impression occurs on the ad.
        // onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  /// Redraw the app bar actions if a privacy options entry point is required.
  void _getIsPrivacyOptionsRequired() async {
    if (await _consentManager.isPrivacyOptionsRequired()) {
      setState(() {
        // _isPrivacyOptionsRequired = true;
      });
    }
  }

  /// Initialize the Mobile Ads SDK if the SDK has gathered consent aligned with
  /// the app's configured messages.
  void _initializeMobileAdsSDK() async {
    if (_isMobileAdsInitializeCalled) {
      return;
    }

    if (await _consentManager.canRequestAds()) {
      _isMobileAdsInitializeCalled = true;

      // Initialize the Mobile Ads SDK.
      MobileAds.instance.initialize();

      // Load an ad.
      _loadAd();
    }
  }
}
