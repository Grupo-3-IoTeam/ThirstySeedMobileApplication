import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-detail/bloc/schedule_detail_bloc.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-detail/bloc/schedule_detail_event.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-detail/bloc/schedule_detail_state.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-detail/schedule_form_widget.dart';
import 'package:thirstyseed/injections.dart';

class ScheduleDetailScreen extends StatelessWidget {
  final String scheduleId;

  const ScheduleDetailScreen({super.key, required this.scheduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle de Riego Programado"),
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<ScheduleDetailBloc>()
          ..add(LoadScheduleDetailEvent(scheduleId)),
        child: BlocBuilder<ScheduleDetailBloc, ScheduleDetailState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ScheduleLoaded) {
              return ScheduleFormWidget(schedule: state.schedule);
            } else if (state is ScheduleError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No se pudo cargar el riego programado"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Evento para actualizar el riego programado si fuera necesario
          if (context.read<ScheduleDetailBloc>().state is ScheduleLoaded) {
            final schedule = (context.read<ScheduleDetailBloc>().state as ScheduleLoaded).schedule;
            context.read<ScheduleDetailBloc>().add(UpdateScheduleEvent(schedule));
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}