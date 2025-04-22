import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/habit_model.dart';
import '../../data/models/habit_completion_model.dart';
import '../../data/models/achievement_model.dart';
import '../constants/app_constants.dart';

/// Initialize Hive for local storage
class HiveInit {
  /// Initialize Hive and register adapters
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(HabitModelAdapter());
    Hive.registerAdapter(HabitCompletionModelAdapter());
    Hive.registerAdapter(AchievementModelAdapter());
    
    // Open boxes
    await Hive.openBox<HabitModel>(AppConstants.habitsBoxName);
    await Hive.openBox<HabitCompletionModel>(AppConstants.completionsBoxName);
    await Hive.openBox<AchievementModel>(AppConstants.achievementsBoxName);
    await Hive.openBox(AppConstants.userDataBoxName);
  }
}

/// Adapter for HabitModel
class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 0;

  @override
  HabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      frequencyIndex: fields[3] as int,
      goalTypeIndex: fields[4] as int,
      specificDays: (fields[5] as List).cast<int>(),
      timesPerWeek: fields[6] as int,
      targetDuration: fields[7] as int,
      targetQuantity: fields[8] as int,
      reminderTime: fields[9] as String,
      colorTag: fields[10] as String,
      icon: fields[11] as String,
      isArchived: fields[12] as bool,
      createdAt: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.frequencyIndex)
      ..writeByte(4)
      ..write(obj.goalTypeIndex)
      ..writeByte(5)
      ..write(obj.specificDays)
      ..writeByte(6)
      ..write(obj.timesPerWeek)
      ..writeByte(7)
      ..write(obj.targetDuration)
      ..writeByte(8)
      ..write(obj.targetQuantity)
      ..writeByte(9)
      ..write(obj.reminderTime)
      ..writeByte(10)
      ..write(obj.colorTag)
      ..writeByte(11)
      ..write(obj.icon)
      ..writeByte(12)
      ..write(obj.isArchived)
      ..writeByte(13)
      ..write(obj.createdAt);
  }
}

/// Adapter for HabitCompletionModel
class HabitCompletionModelAdapter extends TypeAdapter<HabitCompletionModel> {
  @override
  final int typeId = 1;

  @override
  HabitCompletionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitCompletionModel(
      id: fields[0] as String,
      habitId: fields[1] as String,
      completedAt: fields[2] as DateTime,
      durationMinutes: fields[3] as int,
      quantity: fields[4] as int,
      notes: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HabitCompletionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.habitId)
      ..writeByte(2)
      ..write(obj.completedAt)
      ..writeByte(3)
      ..write(obj.durationMinutes)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.notes);
  }
}

/// Adapter for AchievementModel
class AchievementModelAdapter extends TypeAdapter<AchievementModel> {
  @override
  final int typeId = 2;

  @override
  AchievementModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AchievementModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      pointsValue: fields[3] as int,
      iconName: fields[4] as String,
      isUnlocked: fields[5] as bool,
      unlockedAt: fields[6] as DateTime?,
      category: fields[7] as String,
      level: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AchievementModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.pointsValue)
      ..writeByte(4)
      ..write(obj.iconName)
      ..writeByte(5)
      ..write(obj.isUnlocked)
      ..writeByte(6)
      ..write(obj.unlockedAt)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.level);
  }
}
