import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../product/product_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductBloc _productBloc;
  StreamSubscription? _productSubscription;

  SearchBloc({
    required ProductBloc productBloc,
  })  : _productBloc = productBloc,
        super(SearchLoading()) {
    on<LoadSearch>(_onLoadSearch);
    on<SearchProduct>(_onSearchProduct);
    on<UpdateResults>(_onUpdateResults);
  }

  void _onLoadSearch(
      LoadSearch event,
      Emitter<SearchState> emit,
      ) {
    emit(const SearchLoaded());
  }

  void _onSearchProduct(
      SearchProduct event,
      Emitter<SearchState> emit,
      ) {
    List<Product> products = (_productBloc.state as ProductLoaded).products;

    if (event.category != null) {
      products = products
          .where((product) => product.category == event.category!.name)
          .toList();
    }

    if (event.productName.isNotEmpty) {
      List<Product> searchResults = products
          .where((product) => product.name
          .toLowerCase()
          .startsWith(event.productName.toLowerCase()))
          .toList();

      emit(SearchLoaded(products: searchResults));
    } else {
      emit(const SearchLoaded());
    }
  }

  void _onUpdateResults(
      UpdateResults event,
      Emitter<SearchState> emit,
      ) {}

  @override
  Future<void> close() async {
    _productSubscription?.cancel();
    super.close();
  }
}