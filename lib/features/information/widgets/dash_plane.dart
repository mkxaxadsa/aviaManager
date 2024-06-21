import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashPlane extends StatelessWidget {
  const DashPlane({
    super.key,
    this.dash = '- — — — — — — -',
    this.width = 189,
    this.right = 82,
  });

  final String dash;
  final double width;
  final double right;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19,
      width: width,
      child: Stack(
        children: [
          Text(
            dash,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              color: Color(0xffE0E0E0),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          Positioned(
            right: right,
            bottom: -1,
            child: SvgPicture.asset('assets/icons/plane.svg'),
          ),
        ],
      ),
    );
  }
}
