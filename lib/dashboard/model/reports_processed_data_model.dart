// To parse this JSON data, do
//
//     final reportsProcessedDataModel = reportsProcessedDataModelFromJson(jsonString);

import 'dart:convert';

ReportsProcessedDataModel reportsProcessedDataModelFromJson(String str) => ReportsProcessedDataModel.fromJson(json.decode(str));

String reportsProcessedDataModelToJson(ReportsProcessedDataModel data) => json.encode(data.toJson());

class ReportsProcessedDataModel {
  String? idThvm;
  String? mNumber;
  String? guid;
  String? dateOfEcgDerivation;
  String? Stringerval;
  String? ecgRecordingTimeRelative;
  String? ecgRecordingTimeAbsolute;
  String? project;
  String? Stringervention;
  String? category;
  String? age;
  String? sexM0;
  String? vlfMaxAmpl;
  String? vlfMaxAtFreq;
  String? vlfMaxInBin;
  String? lfMaxAmpl;
  String? lfMaxAtFreq;
  String? lfMaxInBin;
  String? hfMaxAmp;
  String? hfMaxAtFreq;
  String? hfMaxInBin;
  String? vlfPowerMs;
  String? lfPowerMs;
  String? hfPowerMs;
  String? vlfPowerPercent;
  String? lfPowerPercent;
  String? hfPowerPercent;
  String? lfPowerNu;
  String? hfPowerNu;
  String? totalPower;
  String? lFtoHf;
  String? lnLFtoHf;
  String? ari;
  String? entropy;
  String? hrcr;
  String? poincareSd1;
  String? poincareSd2;
  String? poincareSd1ToSd2;
  String? poincareArea;
  String? rrTotal;
  String? rrMean;
  String? bpmMean;
  String? rrMin;
  String? rrMax;
  String? corrCoef;
  String? sdrr;
  String? rmssdrr;
  String? rr50;
  String? prr50;
  String? variationCoefficient;
  String? absoluteSinusArrhythmia;
  String? tai;
  String? tinn;
  String? artifactCorrectionBypass;
  String? afToleranceAv5;
  String? afLoad;
  String? resamplingBypass;
  String? StringegrationWidthCalculated;
  String? StringegrationWidthDefault;
  String? StringegrationMethod;
  String? detrendingBypass;
  String? detrendingMethod;
  String? detrendingPolynomialDegree;
  String? detrendingSmoothingFactor;
  String? fftWindowFunction;
  String? dcSwitch;
  String? StringegrationArea;
  String? StringegrationNoOverlap;
  String? freqBandsVlf;
  String? freqBandsLf;
  String? freqBandsHf;
  String? ecgFirmware;
  String? ecgRecording;
  String? ecgDetection;
  String? hrvAnalysis;
  String? statisticalDatabase;
  String? calculationExportDate;
  String? calculationExportTime;
  String? ecgMeasurementDate;
  String? ecgMeasurementTime;
  String? nComparisonGroup;
  String? nDayOfTime24HRange;
  String? nAgeRange;
  String? nAgeMeanSd;
  String? nSexMPercent;
  String? nSexFPercent;
  String? percentileRankVlfPowerMs;
  String? percentileRankLfPowerMs;
  String? percentileRankHfPowerMs;
  String? percentileRankVlfPowerPercent;
  String? percentileRankLfPowerPercent;
  String? percentileRankHfPowerPercent;
  String? percentileRankLfPowerNu;
  String? percentileRankHfPowerNu;
  String? percentileRankTotalPower;
  String? percentileRankLFtoHf;
  String? percentileRankRrMean;
  String? percentileRankBpmMean;
  String? percentileRankSdrr;
  String? percentileRankRmssdrr;
  String? percentileRankLnLFtoHf;
  String? percentileRankAri;
  String? histogram50MsLess251MsGreater239Bpm;
  String? histogram50Ms275Ms218Bpm;
  String? histogram50Ms325Ms185Bpm;
  String? histogram50Ms375Ms160Bpm;
  String? histogram50Ms425Ms141Bpm;
  String? histogram50Ms475Ms126Bpm;
  String? histogram50Ms525Ms114Bpm;
  String? histogram50Ms575Ms104Bpm;
  String? histogram50Ms625Ms96Bpm;
  String? histogram50Ms675Ms89Bpm;
  String? histogram50Ms725Ms83Bpm;
  String? histogram50Ms775Ms77Bpm;
  String? histogram50Ms825Ms73Bpm;
  String? histogram50Ms875Ms67Bpm;
  String? histogram50Ms925Ms65Bpm;
  String? histogram50Ms975Ms62Bpm;
  String? histogram50Ms1025Ms58K5Bpm;
  String? histogram50Ms1075Ms55K8Bpm;
  String? histogram50Ms1125Ms53K3Bpm;
  String? histogram50Ms1175Ms51K1Bpm;
  String? histogram50Ms1225Ms48K9Bpm;
  String? histogram50Ms1275Ms47K1Bpm;
  String? histogram50Ms1325Ms45K3Bpm;
  String? histogram50Ms1375Ms43K6Bpm;
  String? histogram50Ms1425Ms42K1Bpm;
  String? histogram50Ms1475Ms40K6Bpm;
  String? histogram50MsGreater1499MsLess40Bpm;
  String? breathRateLess9Possible;
  String? statuspoStringXPercent;
  String? statuspoStringYPercent;
  String? statuspoStringXClip;
  String? statuspoStringYClip;
  String? statuspoStringCategory;
  String? statusAfWarning;
  String? statusAfThreshold;
  String? hrvHaspCredits;
  String? tachycardiaPossible;
  String? ageCorrectionYAxisMs;
  String? canBasedOnSampleEntropyPossible;
  String? canBasedOnPowerSpectrumPossible;
  String? cfsBasedOnPowerSpectrumPossible;
  String? result;

  ReportsProcessedDataModel({
    this.idThvm,
    this.mNumber,
    this.guid,
    this.dateOfEcgDerivation,
    this.Stringerval,
    this.ecgRecordingTimeRelative,
    this.ecgRecordingTimeAbsolute,
    this.project,
    this.Stringervention,
    this.category,
    this.age,
    this.sexM0,
    this.vlfMaxAmpl,
    this.vlfMaxAtFreq,
    this.vlfMaxInBin,
    this.lfMaxAmpl,
    this.lfMaxAtFreq,
    this.lfMaxInBin,
    this.hfMaxAmp,
    this.hfMaxAtFreq,
    this.hfMaxInBin,
    this.vlfPowerMs,
    this.lfPowerMs,
    this.hfPowerMs,
    this.vlfPowerPercent,
    this.lfPowerPercent,
    this.hfPowerPercent,
    this.lfPowerNu,
    this.hfPowerNu,
    this.totalPower,
    this.lFtoHf,
    this.lnLFtoHf,
    this.ari,
    this.entropy,
    this.hrcr,
    this.poincareSd1,
    this.poincareSd2,
    this.poincareSd1ToSd2,
    this.poincareArea,
    this.rrTotal,
    this.rrMean,
    this.bpmMean,
    this.rrMin,
    this.rrMax,
    this.corrCoef,
    this.sdrr,
    this.rmssdrr,
    this.rr50,
    this.prr50,
    this.variationCoefficient,
    this.absoluteSinusArrhythmia,
    this.tai,
    this.tinn,
    this.artifactCorrectionBypass,
    this.afToleranceAv5,
    this.afLoad,
    this.resamplingBypass,
    this.StringegrationWidthCalculated,
    this.StringegrationWidthDefault,
    this.StringegrationMethod,
    this.detrendingBypass,
    this.detrendingMethod,
    this.detrendingPolynomialDegree,
    this.detrendingSmoothingFactor,
    this.fftWindowFunction,
    this.dcSwitch,
    this.StringegrationArea,
    this.StringegrationNoOverlap,
    this.freqBandsVlf,
    this.freqBandsLf,
    this.freqBandsHf,
    this.ecgFirmware,
    this.ecgRecording,
    this.ecgDetection,
    this.hrvAnalysis,
    this.statisticalDatabase,
    this.calculationExportDate,
    this.calculationExportTime,
    this.ecgMeasurementDate,
    this.ecgMeasurementTime,
    this.nComparisonGroup,
    this.nDayOfTime24HRange,
    this.nAgeRange,
    this.nAgeMeanSd,
    this.nSexMPercent,
    this.nSexFPercent,
    this.percentileRankVlfPowerMs,
    this.percentileRankLfPowerMs,
    this.percentileRankHfPowerMs,
    this.percentileRankVlfPowerPercent,
    this.percentileRankLfPowerPercent,
    this.percentileRankHfPowerPercent,
    this.percentileRankLfPowerNu,
    this.percentileRankHfPowerNu,
    this.percentileRankTotalPower,
    this.percentileRankLFtoHf,
    this.percentileRankRrMean,
    this.percentileRankBpmMean,
    this.percentileRankSdrr,
    this.percentileRankRmssdrr,
    this.percentileRankLnLFtoHf,
    this.percentileRankAri,
    this.histogram50MsLess251MsGreater239Bpm,
    this.histogram50Ms275Ms218Bpm,
    this.histogram50Ms325Ms185Bpm,
    this.histogram50Ms375Ms160Bpm,
    this.histogram50Ms425Ms141Bpm,
    this.histogram50Ms475Ms126Bpm,
    this.histogram50Ms525Ms114Bpm,
    this.histogram50Ms575Ms104Bpm,
    this.histogram50Ms625Ms96Bpm,
    this.histogram50Ms675Ms89Bpm,
    this.histogram50Ms725Ms83Bpm,
    this.histogram50Ms775Ms77Bpm,
    this.histogram50Ms825Ms73Bpm,
    this.histogram50Ms875Ms67Bpm,
    this.histogram50Ms925Ms65Bpm,
    this.histogram50Ms975Ms62Bpm,
    this.histogram50Ms1025Ms58K5Bpm,
    this.histogram50Ms1075Ms55K8Bpm,
    this.histogram50Ms1125Ms53K3Bpm,
    this.histogram50Ms1175Ms51K1Bpm,
    this.histogram50Ms1225Ms48K9Bpm,
    this.histogram50Ms1275Ms47K1Bpm,
    this.histogram50Ms1325Ms45K3Bpm,
    this.histogram50Ms1375Ms43K6Bpm,
    this.histogram50Ms1425Ms42K1Bpm,
    this.histogram50Ms1475Ms40K6Bpm,
    this.histogram50MsGreater1499MsLess40Bpm,
    this.breathRateLess9Possible,
    this.statuspoStringXPercent,
    this.statuspoStringYPercent,
    this.statuspoStringXClip,
    this.statuspoStringYClip,
    this.statuspoStringCategory,
    this.statusAfWarning,
    this.statusAfThreshold,
    this.hrvHaspCredits,
    this.tachycardiaPossible,
    this.ageCorrectionYAxisMs,
    this.canBasedOnSampleEntropyPossible,
    this.canBasedOnPowerSpectrumPossible,
    this.cfsBasedOnPowerSpectrumPossible,
    this.result,
  });

  factory ReportsProcessedDataModel.fromJson(Map<String, dynamic> json) => ReportsProcessedDataModel(
    idThvm: json["idTHVM"],
    mNumber: json["MNumber"],
    guid: json["GUID"],
    dateOfEcgDerivation: json["Date_of_ECG_derivation"],
    Stringerval: json["Stringerval_"],
    ecgRecordingTimeRelative: json["ECG_Recording_Time_Relative"],
    ecgRecordingTimeAbsolute: json["ECG_Recording_Time_Absolute"],
    project: json["Project"],
    Stringervention: json["Stringervention"],
    category: json["Category"],
    age: json["Age"],
    sexM0: json["Sex_M_0"],
    vlfMaxAmpl: json["VLF_MaxAmpl"]?.toString(),
    vlfMaxAtFreq: json["VLF_MaxAtFreq"]?.toString(),
    vlfMaxInBin: json["VLF_MaxInBin"],
    lfMaxAmpl: json["LF_MaxAmpl"]?.toString(),
    lfMaxAtFreq: json["LF_MaxAtFreq"]?.toString(),
    lfMaxInBin: json["LF_MaxInBin"],
    hfMaxAmp: json["HF_MaxAmp"]?.toString(),
    hfMaxAtFreq: json["HF_MaxAtFreq"]?.toString(),
    hfMaxInBin: json["HF_MaxInBin"],
    vlfPowerMs: json["VLF_Power_ms"]?.toString(),
    lfPowerMs: json["LF_Power_ms"]?.toString(),
    hfPowerMs: json["HF_Power_ms"]?.toString(),
    vlfPowerPercent: json["VLF_Power_Percent"],
    lfPowerPercent: json["LF_Power_Percent"]?.toString(),
    hfPowerPercent: json["HF_Power_Percent"]?.toString(),
    lfPowerNu: json["LF_Power_nu"],
    hfPowerNu: json["HF_Power_nu"]?.toString(),
    totalPower: json["Total_Power"]?.toString(),
    lFtoHf: json["LFtoHF"]?.toString(),
    lnLFtoHf: json["LnLFtoHF"]?.toString(),
    ari: json["ARI"]?.toString(),
    entropy: json["Entropy"]?.toString(),
    hrcr: json["HRCR"]?.toString(),
    poincareSd1: json["Poincare_SD1"]?.toString(),
    poincareSd2: json["Poincare_SD2"]?.toString(),
    poincareSd1ToSd2: json["Poincare_SD1toSD2"]?.toString(),
    poincareArea: json["Poincare_Area"]?.toString(),
    rrTotal: json["RR_Total"],
    rrMean: json["RR_Mean"]?.toString(),
    bpmMean: json["BPM_Mean"]?.toString(),
    rrMin: json["RR_Min"],
    rrMax: json["RR_Max"],
    corrCoef: json["Corr_Coef"]?.toString(),
    sdrr: json["SDRR"]?.toString(),
    rmssdrr: json["RMSSDRR"]?.toString(),
    rr50: json["RR50"],
    prr50: json["PRR50"]?.toString(),
    variationCoefficient: json["Variation_Coefficient"]?.toString(),
    absoluteSinusArrhythmia: json["Absolute_Sinus_Arrhythmia"]?.toString(),
    tai: json["TAI"]?.toString(),
    tinn: json["TINN"]?.toString(),
    artifactCorrectionBypass: json["Artifact_Correction_Bypass"],
    afToleranceAv5: json["AF_Tolerance_AV5"],
    afLoad: json["AF_Load"]?.toString(),
    resamplingBypass: json["Resampling_Bypass"],
    StringegrationWidthCalculated: json["Stringegration_Width_Calculated"],
    StringegrationWidthDefault: json["Stringegration_Width_Default"],
    StringegrationMethod: json["Stringegration_Method"],
    detrendingBypass: json["Detrending_Bypass"],
    detrendingMethod: json["Detrending_Method"],
    detrendingPolynomialDegree: json["Detrending_Polynomial_Degree"],
    detrendingSmoothingFactor: json["Detrending_Smoothing_Factor"],
    fftWindowFunction: json["FFT_Window_Function"],
    dcSwitch: json["DC_Switch"],
    StringegrationArea: json["Stringegration_Area"],
    StringegrationNoOverlap: json["Stringegration_No_Overlap"],
    freqBandsVlf: json["Freq_Bands_VLF"],
    freqBandsLf: json["Freq_Bands_LF"],
    freqBandsHf: json["Freq_Bands_HF"],
    ecgFirmware: json["ECG_Firmware"],
    ecgRecording: json["ECG_Recording"],
    ecgDetection: json["ECG_Detection"],
    hrvAnalysis: json["HRV_Analysis"],
    statisticalDatabase: json["Statistical_Database"],
    calculationExportDate: json["Calculation_Export_Date"],
    calculationExportTime: json["Calculation_Export_Time"],
    ecgMeasurementDate: json["ECG_Measurement_Date"],
    ecgMeasurementTime: json["ECG_Measurement_Time"],
    nComparisonGroup: json["n_Comparison_Group"],
    nDayOfTime24HRange: json["n_Day_Of_Time_24h_Range"],
    nAgeRange: json["n_Age_Range"],
    nAgeMeanSd: json["n_Age_Mean_SD"],
    nSexMPercent: json["n_Sex_M_Percent"]?.toString(),
    nSexFPercent: json["n_Sex_F_Percent"]?.toString(),
    percentileRankVlfPowerMs: json["Percentile_Rank_VLF_Power_ms"]?.toString(),
    percentileRankLfPowerMs: json["Percentile_Rank_LF_Power_ms"]?.toString(),
    percentileRankHfPowerMs: json["Percentile_Rank_HF_Power_ms"]?.toString(),
    percentileRankVlfPowerPercent: json["Percentile_Rank_VLF_Power_Percent"]?.toString(),
    percentileRankLfPowerPercent: json["Percentile_Rank_LF_Power_Percent"]?.toString(),
    percentileRankHfPowerPercent: json["Percentile_Rank_HF_Power_Percent"]?.toString(),
    percentileRankLfPowerNu: json["Percentile_Rank_LF_Power_nu"]?.toString(),
    percentileRankHfPowerNu: json["Percentile_Rank_HF_Power_nu"]?.toString(),
    percentileRankTotalPower: json["Percentile_Rank_Total_Power"]?.toString(),
    percentileRankLFtoHf: json["Percentile_Rank_LFtoHF"]?.toString(),
    percentileRankRrMean: json["Percentile_Rank_RR_Mean"]?.toString(),
    percentileRankBpmMean: json["Percentile_Rank_BPM_Mean"]?.toString(),
    percentileRankSdrr: json["Percentile_Rank_SDRR"]?.toString(),
    percentileRankRmssdrr: json["Percentile_Rank_RMSSDRR"]?.toString(),
    percentileRankLnLFtoHf: json["Percentile_Rank_LnLFtoHF"]?.toString(),
    percentileRankAri: json["Percentile_Rank_ARI"]?.toString(),
    histogram50MsLess251MsGreater239Bpm: json["Histogram50ms_Less251ms_Greater239bpm"],
    histogram50Ms275Ms218Bpm: json["Histogram50ms_275ms218bpm"],
    histogram50Ms325Ms185Bpm: json["Histogram50ms_325ms185bpm"],
    histogram50Ms375Ms160Bpm: json["Histogram50ms_375ms160bpm"],
    histogram50Ms425Ms141Bpm: json["Histogram50ms_425ms141bpm"],
    histogram50Ms475Ms126Bpm: json["Histogram50ms_475ms126bpm"],
    histogram50Ms525Ms114Bpm: json["Histogram50ms_525ms114bpm"],
    histogram50Ms575Ms104Bpm: json["Histogram50ms_575ms104bpm"],
    histogram50Ms625Ms96Bpm: json["Histogram50ms_625ms96bpm"],
    histogram50Ms675Ms89Bpm: json["Histogram50ms_675ms89bpm"],
    histogram50Ms725Ms83Bpm: json["Histogram50ms_725ms83bpm"],
    histogram50Ms775Ms77Bpm: json["Histogram50ms_775ms77bpm"],
    histogram50Ms825Ms73Bpm: json["Histogram50ms_825ms73bpm"],
    histogram50Ms875Ms67Bpm: json["Histogram50ms_875ms67bpm"],
    histogram50Ms925Ms65Bpm: json["Histogram50ms_925ms65bpm"],
    histogram50Ms975Ms62Bpm: json["Histogram50ms_975ms62bpm"],
    histogram50Ms1025Ms58K5Bpm: json["Histogram50ms_1025ms58k5bpm"],
    histogram50Ms1075Ms55K8Bpm: json["Histogram50ms_1075ms55k8bpm"],
    histogram50Ms1125Ms53K3Bpm: json["Histogram50ms_1125ms53k3bpm"],
    histogram50Ms1175Ms51K1Bpm: json["Histogram50ms_1175ms51k1bpm"],
    histogram50Ms1225Ms48K9Bpm: json["Histogram50ms_1225ms48k9bpm"],
    histogram50Ms1275Ms47K1Bpm: json["Histogram50ms_1275ms47k1bpm"],
    histogram50Ms1325Ms45K3Bpm: json["Histogram50ms_1325ms45k3bpm"],
    histogram50Ms1375Ms43K6Bpm: json["Histogram50ms_1375ms43k6bpm"],
    histogram50Ms1425Ms42K1Bpm: json["Histogram50ms_1425ms42k1bpm"],
    histogram50Ms1475Ms40K6Bpm: json["Histogram50ms_1475ms40k6bpm"],
    histogram50MsGreater1499MsLess40Bpm: json["Histogram50ms_Greater1499ms_Less40bpm"],
    breathRateLess9Possible: json["Breath_Rate_Less_9_Possible"],
    statuspoStringXPercent: json["StatuspoString_X_Percent"]?.toString(),
    statuspoStringYPercent: json["StatuspoString_Y_Percent"]?.toString(),
    statuspoStringXClip: json["StatuspoString_X_Clip"],
    statuspoStringYClip: json["StatuspoString_Y_Clip"],
    statuspoStringCategory: json["StatuspoString_Category"],
    statusAfWarning: json["Status_AF_Warning"],
    statusAfThreshold: json["Status_AF_Threshold"],
    hrvHaspCredits: json["HRV_HASP_Credits"],
    tachycardiaPossible: json["Tachycardia_Possible"],
    ageCorrectionYAxisMs: json["Age_Correction_YAxis_ms"],
    canBasedOnSampleEntropyPossible: json["CAN_Based_On_Sample_Entropy_possible"],
    canBasedOnPowerSpectrumPossible: json["CAN_Based_On_Power_Spectrum_possible"],
    cfsBasedOnPowerSpectrumPossible: json["CFS_Based_On_Power_Spectrum_possible"],
    result: json["Result"],
  );

  Map<String, dynamic> toJson() => {
    "idTHVM": idThvm,
    "MNumber": mNumber,
    "GUID": guid,
    "Date_of_ECG_derivation": dateOfEcgDerivation,
    "Stringerval_": Stringerval,
    "ECG_Recording_Time_Relative": ecgRecordingTimeRelative,
    "ECG_Recording_Time_Absolute": ecgRecordingTimeAbsolute,
    "Project": project,
    "Stringervention": Stringervention,
    "Category": category,
    "Age": age,
    "Sex_M_0": sexM0,
    "VLF_MaxAmpl": vlfMaxAmpl,
    "VLF_MaxAtFreq": vlfMaxAtFreq,
    "VLF_MaxInBin": vlfMaxInBin,
    "LF_MaxAmpl": lfMaxAmpl,
    "LF_MaxAtFreq": lfMaxAtFreq,
    "LF_MaxInBin": lfMaxInBin,
    "HF_MaxAmp": hfMaxAmp,
    "HF_MaxAtFreq": hfMaxAtFreq,
    "HF_MaxInBin": hfMaxInBin,
    "VLF_Power_ms": vlfPowerMs,
    "LF_Power_ms": lfPowerMs,
    "HF_Power_ms": hfPowerMs,
    "VLF_Power_Percent": vlfPowerPercent,
    "LF_Power_Percent": lfPowerPercent,
    "HF_Power_Percent": hfPowerPercent,
    "LF_Power_nu": lfPowerNu,
    "HF_Power_nu": hfPowerNu,
    "Total_Power": totalPower,
    "LFtoHF": lFtoHf,
    "LnLFtoHF": lnLFtoHf,
    "ARI": ari,
    "Entropy": entropy,
    "HRCR": hrcr,
    "Poincare_SD1": poincareSd1,
    "Poincare_SD2": poincareSd2,
    "Poincare_SD1toSD2": poincareSd1ToSd2,
    "Poincare_Area": poincareArea,
    "RR_Total": rrTotal,
    "RR_Mean": rrMean,
    "BPM_Mean": bpmMean,
    "RR_Min": rrMin,
    "RR_Max": rrMax,
    "Corr_Coef": corrCoef,
    "SDRR": sdrr,
    "RMSSDRR": rmssdrr,
    "RR50": rr50,
    "PRR50": prr50,
    "Variation_Coefficient": variationCoefficient,
    "Absolute_Sinus_Arrhythmia": absoluteSinusArrhythmia,
    "TAI": tai,
    "TINN": tinn,
    "Artifact_Correction_Bypass": artifactCorrectionBypass,
    "AF_Tolerance_AV5": afToleranceAv5,
    "AF_Load": afLoad,
    "Resampling_Bypass": resamplingBypass,
    "Stringegration_Width_Calculated": StringegrationWidthCalculated,
    "Stringegration_Width_Default": StringegrationWidthDefault,
    "Stringegration_Method": StringegrationMethod,
    "Detrending_Bypass": detrendingBypass,
    "Detrending_Method": detrendingMethod,
    "Detrending_Polynomial_Degree": detrendingPolynomialDegree,
    "Detrending_Smoothing_Factor": detrendingSmoothingFactor,
    "FFT_Window_Function": fftWindowFunction,
    "DC_Switch": dcSwitch,
    "Stringegration_Area": StringegrationArea,
    "Stringegration_No_Overlap": StringegrationNoOverlap,
    "Freq_Bands_VLF": freqBandsVlf,
    "Freq_Bands_LF": freqBandsLf,
    "Freq_Bands_HF": freqBandsHf,
    "ECG_Firmware": ecgFirmware,
    "ECG_Recording": ecgRecording,
    "ECG_Detection": ecgDetection,
    "HRV_Analysis": hrvAnalysis,
    "Statistical_Database": statisticalDatabase,
    "Calculation_Export_Date": calculationExportDate,
    "Calculation_Export_Time": calculationExportTime,
    "ECG_Measurement_Date": ecgMeasurementDate,
    "ECG_Measurement_Time": ecgMeasurementTime,
    "n_Comparison_Group": nComparisonGroup,
    "n_Day_Of_Time_24h_Range": nDayOfTime24HRange,
    "n_Age_Range": nAgeRange,
    "n_Age_Mean_SD": nAgeMeanSd,
    "n_Sex_M_Percent": nSexMPercent,
    "n_Sex_F_Percent": nSexFPercent,
    "Percentile_Rank_VLF_Power_ms": percentileRankVlfPowerMs,
    "Percentile_Rank_LF_Power_ms": percentileRankLfPowerMs,
    "Percentile_Rank_HF_Power_ms": percentileRankHfPowerMs,
    "Percentile_Rank_VLF_Power_Percent": percentileRankVlfPowerPercent,
    "Percentile_Rank_LF_Power_Percent": percentileRankLfPowerPercent,
    "Percentile_Rank_HF_Power_Percent": percentileRankHfPowerPercent,
    "Percentile_Rank_LF_Power_nu": percentileRankLfPowerNu,
    "Percentile_Rank_HF_Power_nu": percentileRankHfPowerNu,
    "Percentile_Rank_Total_Power": percentileRankTotalPower,
    "Percentile_Rank_LFtoHF": percentileRankLFtoHf,
    "Percentile_Rank_RR_Mean": percentileRankRrMean,
    "Percentile_Rank_BPM_Mean": percentileRankBpmMean,
    "Percentile_Rank_SDRR": percentileRankSdrr,
    "Percentile_Rank_RMSSDRR": percentileRankRmssdrr,
    "Percentile_Rank_LnLFtoHF": percentileRankLnLFtoHf,
    "Percentile_Rank_ARI": percentileRankAri,
    "Histogram50ms_Less251ms_Greater239bpm": histogram50MsLess251MsGreater239Bpm,
    "Histogram50ms_275ms218bpm": histogram50Ms275Ms218Bpm,
    "Histogram50ms_325ms185bpm": histogram50Ms325Ms185Bpm,
    "Histogram50ms_375ms160bpm": histogram50Ms375Ms160Bpm,
    "Histogram50ms_425ms141bpm": histogram50Ms425Ms141Bpm,
    "Histogram50ms_475ms126bpm": histogram50Ms475Ms126Bpm,
    "Histogram50ms_525ms114bpm": histogram50Ms525Ms114Bpm,
    "Histogram50ms_575ms104bpm": histogram50Ms575Ms104Bpm,
    "Histogram50ms_625ms96bpm": histogram50Ms625Ms96Bpm,
    "Histogram50ms_675ms89bpm": histogram50Ms675Ms89Bpm,
    "Histogram50ms_725ms83bpm": histogram50Ms725Ms83Bpm,
    "Histogram50ms_775ms77bpm": histogram50Ms775Ms77Bpm,
    "Histogram50ms_825ms73bpm": histogram50Ms825Ms73Bpm,
    "Histogram50ms_875ms67bpm": histogram50Ms875Ms67Bpm,
    "Histogram50ms_925ms65bpm": histogram50Ms925Ms65Bpm,
    "Histogram50ms_975ms62bpm": histogram50Ms975Ms62Bpm,
    "Histogram50ms_1025ms58k5bpm": histogram50Ms1025Ms58K5Bpm,
    "Histogram50ms_1075ms55k8bpm": histogram50Ms1075Ms55K8Bpm,
    "Histogram50ms_1125ms53k3bpm": histogram50Ms1125Ms53K3Bpm,
    "Histogram50ms_1175ms51k1bpm": histogram50Ms1175Ms51K1Bpm,
    "Histogram50ms_1225ms48k9bpm": histogram50Ms1225Ms48K9Bpm,
    "Histogram50ms_1275ms47k1bpm": histogram50Ms1275Ms47K1Bpm,
    "Histogram50ms_1325ms45k3bpm": histogram50Ms1325Ms45K3Bpm,
    "Histogram50ms_1375ms43k6bpm": histogram50Ms1375Ms43K6Bpm,
    "Histogram50ms_1425ms42k1bpm": histogram50Ms1425Ms42K1Bpm,
    "Histogram50ms_1475ms40k6bpm": histogram50Ms1475Ms40K6Bpm,
    "Histogram50ms_Greater1499ms_Less40bpm": histogram50MsGreater1499MsLess40Bpm,
    "Breath_Rate_Less_9_Possible": breathRateLess9Possible,
    "StatuspoString_X_Percent": statuspoStringXPercent,
    "StatuspoString_Y_Percent": statuspoStringYPercent,
    "StatuspoString_X_Clip": statuspoStringXClip,
    "StatuspoString_Y_Clip": statuspoStringYClip,
    "StatuspoString_Category": statuspoStringCategory,
    "Status_AF_Warning": statusAfWarning,
    "Status_AF_Threshold": statusAfThreshold,
    "HRV_HASP_Credits": hrvHaspCredits,
    "Tachycardia_Possible": tachycardiaPossible,
    "Age_Correction_YAxis_ms": ageCorrectionYAxisMs,
    "CAN_Based_On_Sample_Entropy_possible": canBasedOnSampleEntropyPossible,
    "CAN_Based_On_Power_Spectrum_possible": canBasedOnPowerSpectrumPossible,
    "CFS_Based_On_Power_Spectrum_possible": cfsBasedOnPowerSpectrumPossible,
    "Result": result,
  };
}
