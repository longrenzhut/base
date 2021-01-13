
import '../extension/ListExt.dart';
import 'package:rxdart/rxdart.dart';

//通信


class Bus<T>{
  PublishSubject<Message<T>> _subject;
  int _tag;

  PublishSubject<Message<T>> get subject => _subject;

  int get tag => _tag;

  Bus(int tag) {
    this._tag = tag;
    _subject = PublishSubject<Message<T>>();
  }

}

class RxBus {

  static const int Code_1 = 1;

  List<Bus> _busList;

  RxBus._internal(){
    _busList = [];
  }

  static final RxBus _singleton =  RxBus._internal();

  factory RxBus() {
    return _singleton;
  }

  static RxBus get singleton => _singleton;



  Stream<Message<T>> register<T>(int tag) {

    Bus _eventBus;
    //已经注册过的tag不需要重新注册
    if (_busList.isNotEmpty) {
      _busList.forEach((bus) {
        if (bus.tag == tag) {
          _eventBus = bus;
          return;
        }
      });
    }
    if (_eventBus == null) {
      _eventBus = Bus(tag);
      _busList.add(_eventBus);
    }

    var stream =  _eventBus.subject.stream.where((event) {
      var isc = event.tag == tag;
      return isc;
    }).cast<Message<T>>();
    return stream;
  }

  ///发送事件
  void post<T>(int tag,T data) {
    var rxBus = _busList.find((element) => element.tag == tag);

    var msg = Message<T>();
    msg.tag = tag;
    msg.data = data;
    rxBus.subject.sink.add(msg);
  }

  void dispose(List<int> tagList){
    if(!tagList.isNotEmptyOrNull())
      return;
    var toRemove = [];
    _busList.forEach((rxBus) {
      if(tagList.contains(rxBus.tag)){
        rxBus.subject.close();
        toRemove.add(rxBus);
      }
    });

    toRemove.forEach((rxBus) {
      _busList.remove(rxBus);
    });

  }

}


class Message<T>{

  int _tag;
  T _data;



  int get tag => _tag;

  set tag(int value) {
    _tag = value;
  }

  T get data => _data;

  set data(T value) {
    _data = value;
  }


}