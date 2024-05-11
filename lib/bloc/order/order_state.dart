part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}
final class OrderSuccess extends OrderState {
  
}
final class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
  @override
  List<Object> get props => [message];
}
final class OrderPending extends OrderState {}
