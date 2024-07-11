import 'package:clean_arc/data/models/ListUser_model.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  final ListUserData user;

  UserDetailScreen({required this.user});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'About',
        style: TextStyle(fontFamily: 'SFPro-BItalic'),
      )),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Hero(
                  tag: widget.user.avatar,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.user.avatar),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${widget.user.first_name} ${widget.user.last_name}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFPro-BB'),
                ),
                SizedBox(height: 10),
                Text(
                  widget.user.email,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontFamily: 'SFPro-BRegular'),
                ),
                SizedBox(height: 30),
                _buildDetailCard('User ID', widget.user.userID.toString()),
                _buildDetailCard('Email', widget.user.email),
                _buildDetailCard('First Name', widget.user.first_name),
                _buildDetailCard('Last Name', widget.user.last_name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String content) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'SFPro-BB'),
        ),
        subtitle: Text(
          content,
          style: TextStyle(fontFamily: 'SFPro-BMedium'),
        ),
      ),
    );
  }
}
