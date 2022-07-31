// @dart=2.9
// 38/41 03

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max_admin/bloc/planner/bloc.dart';
import 'package:finpro_max_admin/models/planner_detail.dart';
import 'package:finpro_max_admin/repositories/planner_repository.dart';
import 'package:meta/meta.dart';

class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  PlannerRepository _plannerRepository;

  PlannerBloc({@required PlannerRepository plannerRepository})
      : assert(plannerRepository != null),
        _plannerRepository = plannerRepository;

  @override
  PlannerState get initialState => PlannerInitialState();

  @override
  Stream<PlannerState> mapEventToState(PlannerEvent event) async* {
    if (event is UploadPlannerEvent) {
      yield* _mapUploadPlanner(plannerDetail: event.plannerDetail);
    } else if (event is PlannerStreamEvent) {
      yield* _mapStreamPlanner();
    }
  }

  Stream<PlannerState> _mapUploadPlanner({PlannerDetail plannerDetail}) async* {
    await _plannerRepository.uploadPlanner(plannerDetail: plannerDetail);
  }

  Stream<PlannerState> _mapStreamPlanner() async* {
    yield PlannerLoadingState();
    Stream<QuerySnapshot> plannerStream = _plannerRepository.getPlanners();
    yield PlannerLoadedState(plannerStream: plannerStream);
  }
}
