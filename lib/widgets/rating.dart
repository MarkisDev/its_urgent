import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key, required this.name, required this.number})
      : super(key: key);
  final String number;
  final String name;

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        size: 30.0,
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
        borderRadius: BorderRadius.circular(30),
      ),
      title: const Center(
        child: Text('Add message and call rating '),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Casual Call"),
                  Text("Urgent Call"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildStar(1),
                  _buildStar(2),
                  _buildStar(3),
                  _buildStar(4),
                  _buildStar(5),
                  _buildStar(6),
                  _buildStar(7),
                  _buildStar(8),
                  _buildStar(9),
                  _buildStar(10),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('CANCEL'),
        ),
        TextButton(
          child: Text('Call ${widget.name}'),
          onPressed: () {
            launchUrlString('tel: $widget.number');
            Navigator.of(context).pop(_stars);
          },
        )
      ],
    );
  }
}
