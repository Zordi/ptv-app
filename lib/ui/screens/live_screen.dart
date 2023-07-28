import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

class LiveScreen extends StatefulWidget {
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late YoutubePlayerController _youtubePlayerController;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'NqclYh2isVI',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _controller = VideoPlayerController.network("http://103.59.94.49/stream/hls/marsis.m3u8")
      ..initialize().then((_) {
        _controller.play();
        _controller.setVolume(1.0);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _youtubePlayerController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List? chatMessages;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Live Screen'),
      ),
      body: Column(
        children: [

          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'PTV merupakan saluran televisi digital. Unikom bekerjasama dengan PTV yang merupakan salah satu media audio visual yang menyajikan ragam tayang berkualitas dan bisa dinikmati berbagai kalangan.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blueAccent[700]!, // Active tab indicator color
                        width: 2.0, // Active tab indicator height
                      ),
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.blueAccent[700], // Active tab label color
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.black, // Inactive tab label color
                  ),
                  tabs: [
                    Tab(text: 'Schedule'),
                    Tab(text: 'Chat'),
                    Tab(text: 'Review'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Schedule Tab Content
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      // Placeholder for the program image
                                      child: FittedBox(
                                        fit: BoxFit.cover, // Set the desired fit mode
                                        child: Image.asset('assets/poster3.PNG'),
                                      ), // Add this line
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fajar Berkah',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '05.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // Placeholder for the share button
                                      child: Image.asset('assets/img_cut.png'), // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Program TV yang membahas tentang Islam rahmat bagi seluruh alam, menggunakan konsep diskusi dan sharing dengan narasumber Ustadz.',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      // Placeholder for the program image
                                      child: FittedBox(
                                        fit: BoxFit.cover, // Set the desired fit mode
                                        child: Image.asset('assets/poster2.PNG'),
                                      ), // Add this line
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'UN News',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '06.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // Placeholder for the share button
                                      child: Image.asset('assets/img_cut.png'), // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Berbagai informasi nasional akan disajikan secara faktual dan aktual dalam program UN News',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      // Placeholder for the program image
                                      child: FittedBox(
                                        fit: BoxFit.cover, // Set the desired fit mode
                                        child: Image.asset('assets/poster.PNG'),
                                      ), // Add this line
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'The Cetars',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '07.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // Placeholder for the share button
                                      child: Image.asset('assets/img_cut.png'), // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Program TV yang membahas isu-isu panas yang beredar di kalangan masyarakat dengan gaya yang lucu dan unik khas wanita heboh. Dipandu oleh 3 orang Host wanita, yang dipimpin oleh Host bernama Ceu Tar.',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      // Placeholder for the program image
                                      child: FittedBox(
                                        fit: BoxFit.cover, // Set the desired fit mode
                                        child: Image.asset('assets/poster6.PNG'),
                                      ), // Add this line
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dunia Digital',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '08.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // Placeholder for the share button
                                      child: Image.asset('assets/img_cut.png'), // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Perkembangan teknologi di dunia sudah berkembang pesat. Disini akan memberikan semua informasi dunia digital.',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      // Placeholder for the program image
                                      child: FittedBox(
                                        fit: BoxFit.cover, // Set the desired fit mode
                                        child: Image.asset('assets/poster7.PNG'),
                                      ), // Add this line
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Eduhistory',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '10.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // Placeholder for the share button
                                      child: Image.asset('assets/img_cut.png'), // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Semua informasi mengenai sejarah, mulai dari nasional hingga internasional bisa di saksikan di program Edduhistory.',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      // Placeholder for the program image
                                      child: FittedBox(
                                        fit: BoxFit.cover, // Set the desired fit mode
                                        child: Image.asset('assets/poster5.PNG'),
                                      ), // Add this line
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sabda',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '15.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // Placeholder for the share button
                                      child: Image.asset('assets/img_cut.png'), // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Menceritakan kehidupan anak-anak yang lucu dan menghibur. Tentunya akan memberikan pengetahuan untuk adik-adik dirumah',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      // Placeholder for the program image
                                      child: FittedBox(
                                        fit: BoxFit.cover, // Set the desired fit mode
                                        child: Image.asset('assets/poster4.PNG'),
                                      ), // Add this line
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Senja Berkah',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          '16.00',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      // Placeholder for the share button
                                      child: Image.asset('assets/img_cut.png'), // Add this line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Program TV yang membahas tentang Islam rahmat bagi seluruh alam, menggunakan konsep diskusi dan sharing dengan narasumber ustadz.',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Chat Tab Content
                      Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: chatMessages?.length ?? 0,
                              itemBuilder: (context, index) {
                                // Build your chat message widget using chatMessages?[index]
                              },
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Type your message...',
                                      border: OutlineInputBorder(),
                                    ),
                                    // Handle chat message input
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    // Handle send button pressed
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Chat Tab Content
                      Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: chatMessages?.length ?? 0,
                              itemBuilder: (context, index) {
                                // Build your chat message widget using chatMessages?[index]
                              },
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Type your message...',
                                      border: OutlineInputBorder(),
                                    ),
                                    // Handle chat message input
                                  ),
                                ),
                                SizedBox(width: 2.0),
                                IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    // Handle send button pressed
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Review Tab Content
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Your Name'),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Rating'),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              maxLines: 3,
                              decoration: InputDecoration(labelText: 'Review'),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                // Submit review logic
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      )
        ],
      ),
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
}
