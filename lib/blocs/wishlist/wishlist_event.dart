part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class StartWishlist extends WishlistEvent{
  @override
  List<Object?> get props => [];
}

class AddWishlistProduct extends WishlistEvent{
  final Product product;

  const AddWishlistProduct(this.product);

  @override
  List<Object> get props => [product];

}

class RemoveWishlistProduct extends WishlistEvent{
  final Product product;

  const RemoveWishlistProduct(this.product);

  @override
  List<Object> get props => [product];

}