import 'package:tracklet_pro/features/plant/domain/repositories/order_repository.dart';
import 'package:tracklet_pro/features/plant/domain/repositories/order_repository_impl.dart';

/// Simple app-level injector (service locator)
/// Replace with get_it later if needed without changing call sites.
class Injector {
  Injector._();

  static late final OrderRepository _orderRepository;

  static void init() {
    _orderRepository = OrderRepositoryImpl();
  }

  static OrderRepository get orderRepository => _orderRepository;
}
