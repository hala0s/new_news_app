part of 'news_bloc.dart';

enum NewsStatus { initial, success, failuer }

class NewsState {
  const NewsState(
      {this.status = NewsStatus.initial,
        this.allResults ,
        this.hasReachedMax = false,
      });
  final NewsStatus status;
  final AllResults? allResults;
  final bool hasReachedMax;

  NewsState copywith({
    NewsStatus? status,
    AllResults? allResults,
    bool? hasReachedMax,
  }) {
    return NewsState(
      status: status ?? this.status,
      allResults: allResults ?? this.allResults,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''NewsState { status: $status, hasReachedMax: $hasReachedMax, posts: $allResults }''';
  }


}
