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

import 'api_service_test.mocks.dart';
import 'api_service_dummy_test.dart';

@GenerateMocks([http.Client])
void main() {
  final MockClient client = MockClient();
  final ApiServiceDummyTest apiService = ApiServiceDummyTest();
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

          expect(await apiService.fetchListRestaurants(client),
              isA<RestaurantListResponse>());
        },
      );
      test(
        "When error get list restaurant",
        () {
          when(client.get(Uri.parse("${baseUrl}list"))).thenAnswer(
            (_) async => http.Response("Not found", 404),
          );
          expect(apiService.fetchListRestaurants(client), throwsException);
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
            await apiService.searchRestaurant(client, dummyQuery),
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
              apiService.searchRestaurant(client, dummyQuery), throwsException);
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

          expect(await apiService.fetchDetailRestaurant(client, dummyId),
              isA<DetailRestaurantResponse>());
        },
      );
      test(
        "When error get detail restaurant",
        () {
          when(client.get(Uri.parse("${baseUrl}detail/$dummyId"))).thenAnswer(
            (_) async => http.Response("Not Found", 404),
          );
          expect(apiService.fetchDetailRestaurant(client, dummyId),
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
              await apiService.reviewRestuarant(
                  client, dummyId, dummyName, dummyReview),
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
              apiService.reviewRestuarant(
                  client, dummyId, dummyName, dummyReview),
              throwsException);
        },
      );
    },
  );
}
