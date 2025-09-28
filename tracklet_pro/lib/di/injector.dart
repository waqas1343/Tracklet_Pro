import 'package:tracklet_pro/features/plant/presentation/screens/order/data/repositories/order_repository.dart';

/// Simple app-level injector (service locator)
/// Replace with get_it later if needed without changing call sites.
class Injector {
  Injector._();

  static late final OrderRepository _orderRepository;

  static void init() {
    _orderRepository = OrderRepository();
  }

  static OrderRepository get orderRepository => _orderRepository;
}
