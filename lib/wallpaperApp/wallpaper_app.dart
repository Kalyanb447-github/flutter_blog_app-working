import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'wallpaper_details.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
const String testDevice = '';

class WallpaperAppHome extends StatefulWidget {
  //firebase analytics
 final FirebaseAnalytics analytics;
 final FirebaseAnalyticsObserver observer;
 WallpaperAppHome({this.analytics,this.observer});
  @override
  _WallpaperAppHomeState createState() => _WallpaperAppHomeState();
}
class _WallpaperAppHomeState extends State<WallpaperAppHome> {
  //using for admob
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['wallpaper', 'walls', 'amoled'],
    birthday: DateTime.now(),
    childDirected: true,
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;



  //snall add
  InterstitialAd createInterstitialAdd() {
    return InterstitialAd(
        // adUnitId: InterstitialAd.testAdUnitId,//test
        adUnitId: 'ca-app-pub-8454239144965561/1396468268',
        // size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print('InterstitialAd event : $event');
        });
  }

  //full screen add
  BannerAd createBannerAdd() {
    return BannerAd(
        //  adUnitId: BannerAd.testAdUnitId,//test
        adUnitId: 'ca-app-pub-8454239144965561/7845971323',
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print('banner event : $event');
        });
  }

  //using for firebase cloud picture
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;

  CollectionReference collectionReference =
      Firestore.instance.collection('wallpapers');
    
    
     //firebase analytics
      Future<Null> _currentScreen() async {
   await widget.analytics.setCurrentScreen(
      screenName: 'wall screen',
      screenClassOverride: 'wallscreen'
   );
  }
  Future<Null> _sendAnalytics() async {
   await widget.analytics.logEvent(
     name: 'tap to full screen',
     parameters:<String,dynamic>{} 
   );

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //for add
    FirebaseAdMob.instance.initialize(
     // appId: FirebaseAdMob.testAppId,//test
     appId :'ca-app-pub-8454239144965561~7031938320',
    );
    _bannerAd = createBannerAdd()
      ..load()
      ..show();
    //for firestore
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        wallpapersList = dataSnapshot.documents;
      });
    });
    //for firebase analytics
    _currentScreen();
  }

  @override
  void dispose() {
    //for add
    //close the add
    _bannerAd?.dispose();
    _interstitialAd.dispose();

    //for firestore
    //subscription is not null
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Wallpaper app"),
      ),
      body: wallpapersList != null
          ? StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 4,
              itemCount: wallpapersList.length,
              itemBuilder: (context, index) {
                String imgPath = wallpapersList[index].data['url'];
                return Material(
                  elevation: 8,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      //for analytics
                      _sendAnalytics();
                      //for admob
                      createInterstitialAdd()
                        ..load()
                        ..show();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WallpaperDetails(imgPath),
                          ));
                    },
                    child: Hero(
                      tag: 'imgPath',
                      child: FadeInImage(
                        image: NetworkImage(imgPath),
                        fit: BoxFit.cover,
                        placeholder: AssetImage('images/wallfy.png'),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 3),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
