import 'package:transactions_app/core/responses.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';

import 'package:dartz/dartz.dart';

typedef FutureEitherTransactions
    = Future<Either<ErrorResponse, List<Transaction>>>;
