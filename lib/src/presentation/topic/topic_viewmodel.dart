import 'package:mobx/mobx.dart';
import 'package:codegen/model/topic/topic.dart';

part 'topic_viewmodel.g.dart';

class TopicViewmodel = _TopicViewmodelBase with _$TopicViewmodel;

abstract class _TopicViewmodelBase with Store {
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

  void updateTopic() {
    // Userın topic listesini güncelle.
  }
}
