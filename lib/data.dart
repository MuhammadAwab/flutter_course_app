import 'Articles.dart';

class Data{
  String _status;
  int _totalResults;
  List<Articles> _articles;
  Data(String status,int totalResults,List<Articles> articles){
    this._status=status;
    this._totalResults=totalResults;
    this._articles=articles;
  }
}