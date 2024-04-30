// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:nodes/config/env.config.dart';
import 'package:nodes/core/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'dashboard_repository.g.dart';

class DashboardApis {
  static const baseApi = API_ENDPOINT;

  // Projects
  static const projectApi = "$baseApi/projects";
  static const myProjects = "$projectApi/mine";

  // Events
  static const events = "$baseApi/events";
  static const singleEvent = "$events/{id}";
  static const saveEvent = "$events/save/{id}";
  static const unSaveEvent = "$events/unsave/{id}";
  static const allSavedEvents = "$events/saved/";
  static const myCreatedEvents = "$events/mine";

  // Jobs
  static const jobs = "$baseApi/jobs";
  static const singleJob = "$jobs/{id}";
  static const applyForJob = "$jobs/apply/{id}";
  static const saveJob = "$jobs/save/{id}";
  static const unSaveJob = "$jobs/unsave/{id}";
  static const allSavedJobs = "$jobs/saved";
  static const allAppliedJobs = "$jobs/applied";
  static const myCreatedJobs = "$jobs/mine";

  // Trending
  static const trendingNews = "$baseApi/trending";

  // Trending
  static const movieShows = "$baseApi/movies-and-shows";

}

@RestApi()
abstract class DashboardRepository {
  factory DashboardRepository(Dio dio, {String? baseUrl}) =
      _DashboardRepository;

  // Projects
  @POST(DashboardApis.projectApi)
  Future<ApiResponse> createProject(@Body() payload);

  @GET(DashboardApis.projectApi)
  Future<ApiResponse> fetchAllProjects(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

  @GET(DashboardApis.myProjects)
  Future<ApiResponse> fetchMyProjects(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

// Events
  @POST(DashboardApis.events)
  Future<ApiResponse> createEvent(@Body() payload);

  @GET(DashboardApis.events)
  Future<ApiResponse> fetchAllEvents(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

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

  @POST(DashboardApis.unSaveEvent)
  Future<ApiResponse> unSaveEvent(
    @Path('id') dynamic id,
  );

  @GET(DashboardApis.allSavedEvents)
  Future<ApiResponse> fetchAllSavedEvents(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

  @GET(DashboardApis.myCreatedEvents)
  Future<ApiResponse> fetchAllAllMyCreatedEvents(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

// Jobs

  @POST(DashboardApis.jobs)
  Future<ApiResponse> createJob(@Body() payload);

  @GET(DashboardApis.jobs)
  Future<ApiResponse> fetchAllJobs(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

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

  @POST(DashboardApis.saveJob)
  Future<ApiResponse> saveJob(
    @Path('id') dynamic id,
  );

  @POST(DashboardApis.unSaveJob)
  Future<ApiResponse> unSaveJob(
    @Path('id') dynamic id,
  );

  @GET(DashboardApis.allSavedJobs)
  Future<ApiResponse> fetchAllSavedJobs(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

  @GET(DashboardApis.allAppliedJobs)
  Future<ApiResponse> fetchAllAppliedJobs(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

  @GET(DashboardApis.myCreatedJobs)
  Future<ApiResponse> fetchAllMyCreatedJobs(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

  @GET(DashboardApis.trendingNews)
  Future<ApiResponse> fetchTrendingNews();

  @GET(DashboardApis.movieShows)
  Future<ApiResponse> fetchMovieShows();

}
