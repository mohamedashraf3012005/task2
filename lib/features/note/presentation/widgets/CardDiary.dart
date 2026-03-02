import 'package:flutter/material.dart';

class CardDiary extends StatelessWidget {
  String title;
  String category;
  String date;
  Color color;
  CardDiary({
    super.key,
    required this.title,
    required this.category,
    required this.color,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Card(
        color: const Color(0xFFFEFEFE),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                width: 7,
                height: 45,
                decoration: BoxDecoration(color: color),
              ),
            ],
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                category,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Text(
                date,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
