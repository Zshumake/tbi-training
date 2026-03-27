/// Data model for branching clinical decision scenarios.
///
/// Each [ClinicalScenario] contains a sequence of [ScenarioStep]s that
/// branch based on the learner's [ScenarioChoice] selections.
class ClinicalScenario {
  final String id;
  final String title;
  final String patientSummary;
  final List<ScenarioStep> steps;

  const ClinicalScenario({
    required this.id,
    required this.title,
    required this.patientSummary,
    required this.steps,
  });

  /// Look up a step by its id. Returns null if not found.
  ScenarioStep? stepById(String stepId) {
    for (final step in steps) {
      if (step.id == stepId) return step;
    }
    return null;
  }
}

class ScenarioStep {
  final String id;
  final String narrative;
  final VitalSigns vitals;
  final String? imagingFinding;
  final int? timeLimit; // seconds to decide (null = untimed)
  final List<ScenarioChoice> choices;

  const ScenarioStep({
    required this.id,
    required this.narrative,
    required this.vitals,
    this.imagingFinding,
    this.timeLimit,
    required this.choices,
  });
}

class VitalSigns {
  final int hr;
  final int sbp;
  final int dbp;
  final int rr;
  final int spo2;
  final int? icp;
  final int? cpp;
  final double? temp;
  final int? gcs;

  const VitalSigns({
    required this.hr,
    required this.sbp,
    required this.dbp,
    required this.rr,
    required this.spo2,
    this.icp,
    this.cpp,
    this.temp,
    this.gcs,
  });
}

class ScenarioChoice {
  final String text;
  final bool isCorrect;
  final String consequence;
  final String explanation;
  final String? nextStepId;
  final VitalSigns? updatedVitals;

  const ScenarioChoice({
    required this.text,
    required this.isCorrect,
    required this.consequence,
    required this.explanation,
    this.nextStepId,
    this.updatedVitals,
  });
}
