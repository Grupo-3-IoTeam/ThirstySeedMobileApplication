import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thirstyseed/irrigation/application/schedule_facade_service.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-detail/schedule_form_widget.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-list/bloc/schedule_list_bloc.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-list/bloc/schedule_list_event.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-list/bloc/schedule_list_state.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-list/schedule_item_widget.dart';
import 'package:thirstyseed/injections.dart';

class ScheduleListScreen extends StatelessWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scheduled Irrigations"),
      ),
      body: BlocProvider(
        create: (context) => ScheduleListBloc(scheduleService: serviceLocator<ScheduleFacadeService>())
          ..add(LoadScheduleListEvent()),
        child: BlocBuilder<ScheduleListBloc, ScheduleListState>(
          builder: (context, state) {
            if (state is ScheduleListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ScheduleListLoaded) {
              return ListView.builder(
                itemCount: state.schedules.length,
                itemBuilder: (context, index) {
                  return ScheduleItemWidget(schedule: state.schedules[index]);
                },
              );
            } else if (state is ScheduleListError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(child: Text("No data available."));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text("Crear Riego Programado"),
                ),
                body: const SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: ScheduleFormWidget(
                    schedule: ScheduleModel(
                      id: 0,
                      plotId: 0,
                      waterAmount: 0,
                      pressure: 0,
                      sprinklerRadius: 0,
                      expectedMoisture: 0,
                      estimatedTimeHours: 0,
                      setTime: '',
                      angle: 0,
                      isAutomatic: false,
                    ),
                  ),
                ),
              ),
            ),
          );
          if (result == true && context.mounted) {
            context.read<ScheduleListBloc>().add(LoadScheduleListEvent());
          }
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}