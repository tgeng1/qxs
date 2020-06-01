import 'package:qxs/api/common.dart';

class BooksServiceApi {

  static getBookList(pageNo, pageSize) async{
    String api = '/get-books?pageNo=$pageNo&pageSize=$pageSize';
    return await HttpUtil().call('get', api);
  }
}