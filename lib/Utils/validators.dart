bool validateSameDays(DateTime A, DateTime B){
  return A.year == B.year && A.month == B.month && A.day == B.day;
}