import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

@immutable
final class TopicsList extends StatefulWidget {
  const TopicsList({super.key, this.isSearchView = true});

  final bool isSearchView;

  @override
  State<TopicsList> createState() => _TopicsListState();
}

class _TopicsListState extends State<TopicsList> {
  late final IUserRepository _userRepository;
  UserModel? user;
  List<Topic> usersTopic = [];
  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
    getUser();
  }

  void getUser() {
    user = _userRepository.currentUser;
    usersTopic = user?.topics ?? [];
  }

  Future<void> setTopics(Topic topic) async {
    (usersTopic.any((e) => e.value == topic.value))
        ? usersTopic.removeWhere((e) => e.value == topic.value)
        : usersTopic.add(topic);
    await _userRepository.updateTopic(topics: usersTopic);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final listLength = widget.isSearchView ? Topic.allTopics.length : 4;
    return Column(
      children: List.generate(listLength, (index) {
        final topic = Topic.allTopics[index];
        if (index == 0) return emptyBox;
        return ListTile(
          onTap: () => setTopics(topic),
          contentPadding: NaPadding.zeroPadding,
          leading: SizedBox(
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: topic.image,
            ),
          ),
          title: LuciText.bodyLarge(
            topic.value?.capitalizeFirst,
            fontWeight: FontWeight.w500,
          ),
          subtitle: LuciText.bodySmall(
            topic.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            usersTopic.any((e) => e.value == topic.value)
                ? Icons.add_box_outlined
                : Icons.remove_circle_outline_outlined,
            color: usersTopic.any((e) => e.value == topic.value)
                ? AppTheme.primaryColor
                : AppTheme.bodyDark,
          ),
        );
      }),
    );
  }
}
