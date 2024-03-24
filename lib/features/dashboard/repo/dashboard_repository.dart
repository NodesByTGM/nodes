// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:nodes/config/env.config.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'dashboard_repository.g.dart';

class DashboardApis {
  static const baseApi = API_ENDPOINT;

  // Events
  static const events = "$baseApi/events";
  static const singleEvent = "$events/{id}";
  static const saveEvent = "$events/save/{id}";

  // Jobs
  static const jobs = "$baseApi/jobs";
  static const singleJob = "$jobs/{id}";
  static const applyForJob = "$jobs/apply/{id}";
}

@RestApi()
abstract class DashboardRepository {
  factory DashboardRepository(Dio dio, {String? baseUrl}) =
      _DashboardRepository;

// Events

  @POST(DashboardApis.events)
  Future<ApiResponse> createEvent(@Body() payload);

  @GET(DashboardApis.events)
  Future<ApiResponse> fetchAllEvents();

  @GET(DashboardApis.singleEvent)
  Future<ApiResponse> fetchEvent(
    @Path('id') dynamic id,
  );

  @PUT(DashboardApis.singleEvent)
  Future<ApiResponse> updateEvent(
    @Path('id') dynamic id,
    @Body() payload,
  );

  @DELETE(DashboardApis.singleEvent)
  Future<ApiResponse> deleteEvent(
    @Path('id') dynamic id,
  );

  @POST(DashboardApis.saveEvent)
  Future<ApiResponse> saveEvent(
    @Path('id') dynamic id,
  );

// Jobs

  @POST(DashboardApis.jobs)
  Future<ApiResponse> createJob(@Body() payload);

  @GET(DashboardApis.jobs)
  Future<ApiResponse> fetchAllJobs();

  @GET(DashboardApis.singleJob)
  Future<ApiResponse> fetchJob(
    @Path('id') dynamic id,
  );

  @PUT(DashboardApis.singleJob)
  Future<ApiResponse> updateJob(
    @Path('id') dynamic id,
    @Body() payload,
  );

  @DELETE(DashboardApis.singleJob)
  Future<ApiResponse> deleteJob(
    @Path('id') dynamic id,
  );

  @POST(DashboardApis.applyForJob)
  Future<ApiResponse> applyForJob(
    @Path('id') dynamic id,
  );
}
