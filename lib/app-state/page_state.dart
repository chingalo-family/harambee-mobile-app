import 'package:flutter/foundation.dart';
import 'package:harambee_mobile_app/models/page_model.dart';

class PageState with ChangeNotifier {
  // initial state
  PageModel _currentPage;

  // selector
  PageModel get currentPage => _currentPage ?? null;

  // state reducers

}
