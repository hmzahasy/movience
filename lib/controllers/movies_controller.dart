import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/models/movie.dart';

class MoviesController extends GetxController {
  var isLoading = false.obs;
  var mainTopRatedMovies = <Movie>[].obs;
  var watchListMovies = <Movie>[].obs;
  @override
  void onInit() async {
    isLoading.value = true;
    mainTopRatedMovies.value = (await ApiService.getTopRatedMovies())!;
    isLoading.value = false;
    super.onInit();
  }

  bool isInWatchList(Movie movie) {
    return watchListMovies.any((m) => m.id == movie.id);
  }

  void addToWatchList(Movie movie) {
    if (watchListMovies.any((m) => m.id == movie.id)) {
      watchListMovies.remove(movie);
      Get.snackbar(
        'Success',
        'The movie has been removed from your watchlist',
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.white, // Set the background color to white
        colorText: Colors.black, // Set the text color to black
      );
    } else {
      watchListMovies.add(movie);
      Get.snackbar(
        'Success',
        'The movie has been added to your watchlist',
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.white, // Set the background color to white
        colorText: Colors.black, // Set the text color to black
      );
    }
  }
}
