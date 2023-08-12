part of 'app_cubit.dart';

class AppState extends Equatable {
  final Home? home;
  final Category? categorySelected;
  final bool isGrid;
  final String messageHome;
  final String messageImage;
  final String messageProducts;
  final String messageAdd;
  final List<Category> categories;
  final List<Product> products;
  final List<String> images;

// *** states
  final int categoryIndex;
  final RequestState getHomeState;
  final RequestState? addProductState;
  final RequestState? getProductsByIdState;
  final RequestState? uploadImagesState;

  const AppState(
      {this.home,
      this.isGrid = false,
      this.categoryIndex = 0,
      this.categories = const [],
      this.products = const [],
      this.categorySelected,
      this.images = const [],
      this.messageHome = "",
      this.messageImage = "",
      this.messageAdd = "",
      this.messageProducts = "",
      this.getHomeState = RequestState.loading,
      this.addProductState,
      this.uploadImagesState,
      this.getProductsByIdState});

  AppState copyWith({
    final Category? categorySelected,
    final int? categoryIndex,
    final Home? home,
    final bool? isGrid,
    final List<String>? images,
    final List<Category>? categories,
    final List<Product>? products,
    final RequestState? getHomeState,
    final RequestState? addProductState,
    final RequestState? getProductsByIdState,
    final RequestState? uploadImagesState,
    final String? messageHome,
    final String? messageAdd,
    final String? messageImage,
    final String? messageProducts,
  }) {
    return AppState(
      categoryIndex: categoryIndex ?? this.categoryIndex,
      categorySelected: categorySelected ?? this.categorySelected,
      home: home ?? this.home,
      isGrid: isGrid ?? this.isGrid,
      images: images ?? this.images,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      getHomeState: getHomeState ?? this.getHomeState,
      addProductState: addProductState ?? this.addProductState,
      getProductsByIdState: getProductsByIdState ?? this.getProductsByIdState,
      uploadImagesState: uploadImagesState ?? this.uploadImagesState,
      messageHome: messageHome ?? this.messageHome,
      messageAdd: messageAdd ?? this.messageAdd,
      messageImage: messageImage ?? this.messageImage,
      messageProducts: messageProducts ?? this.messageProducts,
    );
  }

  @override
  List<Object?> get props => [
        isGrid,
        images,
        categorySelected,
        categoryIndex,
        home,
        categories,
        products,
        addProductState,
        getProductsByIdState,
        getHomeState,
        uploadImagesState,
        messageHome,
        messageImage,
        messageProducts,
        messageAdd
      ];
}
