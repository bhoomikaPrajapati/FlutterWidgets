import 'package:flutter/cupertino.dart';

class ImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("images/profile.png");
    Image image = Image(
      image: assetImage,
      height: 200.0,
      width: 200.0,
    );
    return Container(
      child: image,
    );
  }
}
