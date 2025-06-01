// lib/screens/map/widgets/reports/bloc/report_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../../../models/report.dart';
import '../../../../../repositories/report_repository.dart';

@injectable
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository _reportRepository;

  ReportBloc(this._reportRepository) : super(ReportInitial()) {
    on<SubmitReport>(_onSubmitReport);
    on<LoadUserReports>(_onLoadUserReports);
    on<LoadPOIReports>(_onLoadPOIReports);
    on<UpdateReportStatus>(_onUpdateReportStatus);
  }

  Future<void> _onSubmitReport(
      SubmitReport event,
      Emitter<ReportState> emit,
      ) async {
    emit(ReportSubmitting());

    try {
      final submittedReport = await _reportRepository.submitReport(event.report);
      emit(ReportSubmitted(report: submittedReport));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  Future<void> _onLoadUserReports(
      LoadUserReports event,
      Emitter<ReportState> emit,
      ) async {
    emit(ReportsLoading());

    try {
      final reports = await _reportRepository.getUserReports();
      emit(ReportsLoaded(reports: reports));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  Future<void> _onLoadPOIReports(
      LoadPOIReports event,
      Emitter<ReportState> emit,
      ) async {
    emit(ReportsLoading());

    try {
      final reports = await _reportRepository.getPOIReports(event.poiId);
      emit(ReportsLoaded(reports: reports));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  Future<void> _onUpdateReportStatus(
      UpdateReportStatus event,
      Emitter<ReportState> emit,
      ) async {
    try {
      await _reportRepository.updateReportStatus(event.reportId, event.status);
      emit(ReportStatusUpdated());
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }
}

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class SubmitReport extends ReportEvent {
  final Report report;

  const SubmitReport({required this.report});

  @override
  List<Object?> get props => [report];
}

class LoadUserReports extends ReportEvent {}

class LoadPOIReports extends ReportEvent {
  final String poiId;

  const LoadPOIReports({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

class UpdateReportStatus extends ReportEvent {
  final String reportId;
  final ReportStatus status;

  const UpdateReportStatus({
    required this.reportId,
    required this.status,
  });

  @override
  List<Object?> get props => [reportId, status];
}

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportSubmitting extends ReportState {}

class ReportSubmitted extends ReportState {
  final Report report;

  const ReportSubmitted({required this.report});

  @override
  List<Object?> get props => [report];
}

class ReportsLoading extends ReportState {}

class ReportsLoaded extends ReportState {
  final List<Report> reports;

  const ReportsLoaded({required this.reports});

  @override
  List<Object?> get props => [reports];
}

class ReportStatusUpdated extends ReportState {}

class ReportError extends ReportState {
  final String message;

  const ReportError({required this.message});

  @override
  List<Object?> get props => [message];
}