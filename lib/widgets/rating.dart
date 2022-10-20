import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key, required this.name, required this.number})
      : super(key: key);
  final String number;
  final String name;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        size: 19.sp,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      title: Center(
        child: Text(
          'Add message and call rating ',
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      content: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Reason to call',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(''),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 17.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Casual Call",
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    "Urgent Call",
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 17.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 1; i <= 10; i++) _buildStar(i),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 12.7.sp,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Call ${widget.name}',
                style: TextStyle(
                  fontSize: 12.7.sp,
                ),
              ),
              onPressed: () {
                launchUrlString('tel:${widget.number}');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
