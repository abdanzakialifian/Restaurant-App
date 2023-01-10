import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/review_restaurant_response.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';
import 'package:restaurant_app/data/source/remote/api_service.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final MockClient client = MockClient();
  final ApiService apiService = ApiService();
  const String baseUrl = "https://restaurant-api.dicoding.dev/";
  const String headers = "Content-Type";
  const String bodyHeaders = "application/x-www-form-urlencoded";
  const String dummyId = "1";
  const String dummyQuery = "Melting Pot";
  const String dummyName = "Abdan Zaki Alifian";
  const String dummyReview = "Wenakkkk";
  const String id = "id";
  const String name = "name";
  const String review = "review";

  group(
    "Fetch List Restaurants",
    () {
      test(
        "When success get list restaurant",
        () async {
          final file = File("test_resources/list_restaurants.json");
          final fileJson = jsonDecode(await file.readAsString());

          when(client.get(Uri.parse("${baseUrl}list"))).thenAnswer(
            (_) async => http.Response(json.encode(fileJson), 200),
          );

          expect(await apiService.fetchListRestaurants(httpClient: client),
              isA<RestaurantListResponse>());
        },
      );
      test(
        "When error get list restaurant",
        () {
          when(client.get(Uri.parse("${baseUrl}list"))).thenAnswer(
            (_) async => http.Response("Not found", 404),
          );
          expect(apiService.fetchListRestaurants(httpClient: client), throwsException);
        },
      );
    },
  );

  group(
    "Search Restaurant",
    () {
      test(
        "When success search restaurant",
        () async {
          final file = File("test_resources/search_restaurant.json");
          final fileJson = jsonDecode(await file.readAsString());

          when(client.get(Uri.parse("${baseUrl}search?q=$dummyQuery")))
              .thenAnswer(
            (_) async => http.Response(json.encode(fileJson), 200),
          );

          expect(
            await apiService.searchRestaurant(dummyQuery, httpClient: client),
            isA<SearchRestaurantResponse>(),
          );
        },
      );
      test(
        "When error search restaurant",
        () {
          when(client.get(Uri.parse("${baseUrl}search?q=$dummyQuery")))
              .thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );
          expect(
              apiService.searchRestaurant(dummyQuery, httpClient: client), throwsException);
        },
      );
    },
  );

  group(
    "Fetch Detail Restaurant",
    () {
      test(
        "When success get detail restaurant",
        () async {
          final file = File("test_resources/detail_restaurants.json");
          final fileJson = jsonDecode(await file.readAsString());

          when(client.get(Uri.parse("${baseUrl}detail/$dummyId"))).thenAnswer(
            (_) async => http.Response(json.encode(fileJson), 200),
          );

          expect(await apiService.fetchDetailRestaurant(dummyId, httpClient: client),
              isA<DetailRestaurantResponse>());
        },
      );
      test(
        "When error get detail restaurant",
        () {
          when(client.get(Uri.parse("${baseUrl}detail/$dummyId"))).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );
          expect(apiService.fetchDetailRestaurant(dummyId, httpClient: client),
              throwsException);
        },
      );
    },
  );

  group(
    "Review Restaurant",
    () {
      test(
        "When success review restaurant",
        () async {
          final file = File("test_resources/review_restaurant.json");
          final fileJson = jsonDecode(await file.readAsString());

          when(
            client.post(
              Uri.parse("${baseUrl}review"),
              headers: <String, String>{
                headers: bodyHeaders,
              },
              body: <String, String>{
                id: dummyId,
                name: dummyName,
                review: dummyReview,
              },
            ),
          ).thenAnswer(
            (_) async => http.Response(json.encode(fileJson), 200),
          );
          expect(
              await apiService.reviewRestuarant(dummyId, dummyName, dummyReview, httpClient: client),
              isA<ReviewRestaurantResponse>());
        },
      );
      test(
        "When error review restaurant",
        () {
          when(
            client.post(
              Uri.parse("${baseUrl}review"),
              headers: <String, String>{
                headers: bodyHeaders,
              },
              body: <String, String>{
                id: dummyId,
                name: dummyName,
                review: dummyReview,
              },
            ),
          ).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );
          expect(
              apiService.reviewRestuarant(dummyId, dummyName, dummyReview, httpClient: client),
              throwsException);
        },
      );
    },
  );
}
