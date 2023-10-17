// class SomeRepository {
//   Future<Data> fetchData() async {
//     try {
//       // Assume fetchDataFromAPI() is a function that fetches data from an API
//       final data = await fetchDataFromAPI();
//       return data;
//     } catch (error) {
//       // Handle or re-throw the error
//       throw SomeSpecificException('Failed to fetch data: $error');
//     }
//   }
// }/**/

// class SomeSpecificException implements Exception {
//   final String message;
//   SomeSpecificException(this.message);
// }

// class Result<T> {
//   final T? value;
//   final Object? error;
//   Result.success(this.value) : error = null;
//   Result.failure(this.error) : value = null;
// }
//
// class SomeRepository {
//   Future<Result<Data>> fetchData() async {
//     try {
//       final data = await fetchDataFromAPI();
//       return Result.success(data);
//     } catch (error) {
//       return Result.failure(error);
//     }
//   }
// }

