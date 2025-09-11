import 'package:codegen/model/topic/topic.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'topic_viewmodel.g.dart';

class TopicViewmodel = _TopicViewmodelBase with _$TopicViewmodel;

abstract class _TopicViewmodelBase with Store {
  late final IUserRepository userRepository;
  @observable
  ObservableList<Topic> selectedTopics = ObservableList<Topic>();

  @action
  void addTopicToList(Topic topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
  }

  bool isSelected(Topic topic) {
    return selectedTopics.contains(topic);
  }

  Future<void> setSkipped() async => userRepository.setSkipped();

  void onNextPressed() {
    userRepository.updateTopic(topics: selectedTopics.toList());
    router.pushNamed(RoutePaths.fillProfile.name);
  }
}
