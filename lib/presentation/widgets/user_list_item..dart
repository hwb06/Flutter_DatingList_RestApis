import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_datingapp_restapi/data/models/user_model.dart';

class UserListItem extends StatelessWidget {
  final Results user;
  final VoidCallback onTapMessage;
  final VoidCallback onTapCall;

  const UserListItem({
    Key? key,
    required this.user,
    required this.onTapMessage,
    required this.onTapCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: CachedNetworkImageProvider(
                user.picture?.medium ?? '',
              ),
            ),
            title: Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${user.name?.first ?? ''} - ${user.dob?.age ?? ''}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.verified,
                    size: 16,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  '${user.location?.city ?? ''}, ${user.location?.country ??
                      ''}',
                  style: TextStyle(color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '3 km from you',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: Wrap(
              spacing: 4,
              children: [
                IconButton(
                  icon: Icon(Icons.message, color: Colors.deepPurple),
                  onPressed: onTapMessage,
                  padding: EdgeInsets.all(8),
                ),
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.deepPurple),
                  onPressed: onTapCall,
                  padding: EdgeInsets.all(8),
                ),
              ],
            ),
          ),
          if (user.dob?.date != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
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