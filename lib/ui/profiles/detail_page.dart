import 'package:flutter/material.dart';
import 'package:graduate_app/model/people_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.profile}) : super(key: key);

  final ProfileCard profile;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 5, 16, 24),
                child: Hero(
                  tag: "mainImage",
                  transitionOnUserGestures: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.profile.image,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.profile.name,
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Text(
                  widget.profile.email,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "私の避難場所は ",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      TextSpan(
                        text: widget.profile.evacuation,
                        style: TextStyle(fontSize: 25, color: Colors.amber),
                      ),
                      TextSpan(
                        text: " です。",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
