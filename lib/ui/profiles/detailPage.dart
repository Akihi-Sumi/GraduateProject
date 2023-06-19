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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(74),
        child: AppBar(
          backgroundColor: Colors.orangeAccent[400],
          leading: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 24,
            ),
          ),
          title: Text(
            widget.profile.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Hero(
                  tag: "mainImage",
                  transitionOnUserGestures: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.profile.image,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
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
