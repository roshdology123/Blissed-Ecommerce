import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/models.dart';
import '../../repositories/local_storage/local_storage_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;

  WishlistBloc({
    required LocalStorageRepository localStorageRepository,
}) : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<StartWishlist>(_onStartWishlist);
    on<AddWishlistProduct>(_onAddWishlistProduct);
    on<RemoveWishlistProduct>(_onRemoveWishlistProduct);
  }

  void _onStartWishlist(StartWishlist event,
      Emitter<WishlistState> emit,) async {
    emit(WishlistLoading());
    try {
      Box box = await _localStorageRepository.openBox();
      List<Product> products = _localStorageRepository.getWishlist(box);
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        WishlistLoaded(
          wishlist: Wishlist(products: products),
        ),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  void _onAddWishlistProduct(
      AddWishlistProduct event,
      Emitter<WishlistState> emit,
      ) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.addProductToWishlist(box, event.product);
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
              products: List.from((
                  state as WishlistLoaded).wishlist.products)
                ..add(event.product),
            ),
          ),

        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveWishlistProduct(RemoveWishlistProduct event,
      Emitter<WishlistState> emit,) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.removeProductFromWishlist(box, event.product);
        emit(
          WishlistLoaded(
            wishlist: Wishlist(
                products: List.from((
                    state as WishlistLoaded).wishlist.products)
                  ..remove(event.product)
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

}