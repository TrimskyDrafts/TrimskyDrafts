/// Just good way to check is numeric
extension Numeric on String {
  bool get isNumeric => int.tryParse(this) != null ? true : false;
}

enum DateFormatType {
  monthDayYear,
  dayMonthYear,
  yearMonthDay,
}

class Date {
  static final List<String> englishAlphabet = List.unmodifiable(<String>['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']);
  static final List<String> months = List.unmodifiable(<String>["January", "February", "March",  "April", "May", "June", "July", "August", "September", "October", "November", "December"]);
  static final List<int> daysPerMonth = List.unmodifiable(<int>[31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]);

  final DateTime rawTime;
  final DateFormatType formatType;
  final bool showNamed;

  Date(DateTime time, {required this.formatType, required this.showNamed}) : rawTime = time;
  
  @override
  String toString() {
    String delimiter = '/';
    if(showNamed) delimiter = ' ';
    
    switch (formatType) {
      case DateFormatType.dayMonthYear:
        return '${rawTime.day}$delimiter${getMonth()}$delimiter${rawTime.year} ${getHours()}:${getMinutes()}:${getSeconds()}';
      case DateFormatType.monthDayYear:
        return '${getMonth()}$delimiter${rawTime.day}$delimiter${rawTime.year} ${getHours()}:${getMinutes()}:${getSeconds()}';
      case DateFormatType.yearMonthDay:
        return '${rawTime.year}$delimiter${getMonth()}$delimiter${rawTime.day} ${getHours()}:${getMinutes()}:${getSeconds()}';
    }
  }

  String getMinutes() {
    if(rawTime.minute < 10) {
      return '0${rawTime.minute}';
    } else {
      return rawTime.minute.toString();
    }
  }

  String getSeconds() {
    if(rawTime.second < 10) {
      return '0${rawTime.second}';
    } else {
      return rawTime.second.toString();
    }
  }

  String getHours() {
    if(rawTime.hour < 10) {
      return '0${rawTime.hour}';
    } else {
      return rawTime.hour.toString();
    }
  }

  String getMonth() {
    if(showNamed) {
      return months[rawTime.month - 1];
    } else {
      return rawTime.month.toString();
    }
  }

  /// Return null if date is invalid
  /// Parse date from readability date format YYYY?MM?DD HH:MM:SS
  static Date? parse(String formattedString, DateFormatType type, bool showNamed) {
    final Date? parsedDate;
    var time = DateTime.now();
    int currentIndex = 0;
    String currentToken = "";

    /// Nested function for code reduce.
    /// Starts from current index and writing result to currentToken(which erases before parseNextOfDate call)
    /// And then skip delimiter between tokens
    void parseNextPartOfDate() {
      currentToken = "";
      while(currentIndex < formattedString.length && formattedString[currentIndex].isNumeric) {
        currentToken += formattedString[currentIndex];
        ++currentIndex;
      }
      ++currentIndex;
    }

    // Parse year token. Can be YYYY format or YY format
    // Returns year if year token is valid, otherwise returns null 
    int? getYearToken() {
      final int year;
      parseNextPartOfDate();

      if(currentToken.length == 4) {
        year = int.parse(currentToken);
      } else if(currentToken.length == 2) {
        year = int.parse(time.year.toString().substring(0, 2) + currentToken);
      } else {
        return null;
      }

      if(year < time.year) return null;
      return year;
    }

    // Parse month token. Can be MM or M format
    // Returns month if year token is valid, otherwise returns null
    int? getMonthToken() {
      final int month;

      if(currentIndex >= formattedString.length) {
        return null;
      }
      else if(englishAlphabet.contains(formattedString[currentIndex].toLowerCase())) {
        currentToken = "";
        formattedString = formattedString.toLowerCase();
        while(englishAlphabet.contains(formattedString[currentIndex])) {
          currentToken += formattedString[currentIndex];
          ++currentIndex;
        }
        ++currentIndex;
        currentToken = currentToken.toLowerCase();
        for (int i = 0; i < 12; i++) {
          if(months[i].toLowerCase() == currentToken) {
            return i + 1;
          }
        }
        return null;
      }
      parseNextPartOfDate();
      if(currentToken.length == 2 || currentToken.length == 1) {
        month = int.parse(currentToken);
        if(month > 12 || month == 0) return null;
      } else {
        return null;
      }

      return month;
    }

    // Parse day token. Can be DD or D format
    // Returns month if year token is valid, otherwise returns null
    int? getDayToken(int? month) {
      final int day;

      parseNextPartOfDate();
      if(currentToken.length == 1 || currentToken.length == 2) {
        day = int.parse(currentToken);
        if(month != null && day > daysPerMonth[month - 1]) return null;
      } else {
        return null;
      }
      return day;
    }

    // Parse hour token. Can be HH or H format
    // Returns month if year token is valid, otherwise returns null
    int? getHourToken() {
      final int hour;

      parseNextPartOfDate();
      if(currentToken.length == 1 || currentToken.length == 2) {
        hour = int.parse(currentToken);
        if(hour > 23) return null;
      } else {
        return null;
      }
      return hour;
    }

    // Parse minute token. Can be MM or M format
    // Returns month if year token is valid, otherwise returns null
    int? getMinuteToken() {
      final int minute;

      parseNextPartOfDate();
      if(currentToken.length == 1 || currentToken.length == 2) {
        minute = int.parse(currentToken);
        if(minute > 59) return null;
      } else {
        return null;
      }
      return minute;
    }

    // Parse second token. Can be SS or S format
    // Returns month if year token is valid, otherwise returns null
    int? getSecondToken() {
      final int second;

      parseNextPartOfDate();
      if(currentToken.length == 1 || currentToken.length == 2) {
        second = int.parse(currentToken);
        if(second > 59) return null;
      } else {
        return null;
      }
      return second;
    }

    int? year, month, day, hour, minute, second;
    if(type == DateFormatType.dayMonthYear) {
      // Because of first day token, we will check bounds of month day later ourselves.
      if((day = getDayToken(null)) == null || (month = getMonthToken()) == null) {
        return null;
      }
      // Check is day is out of month bounds
      if(day! > daysPerMonth[month! - 1]) return null;
      // Finish other conditions
      if((year = getYearToken()) == null || (hour = getHourToken()) == null || (minute = getMinuteToken()) == null || (second = getSecondToken()) == null) return null;
    } else if(type == DateFormatType.monthDayYear) {
      if((month = getMonthToken()) == null || (day = getDayToken(null)) == null || (year = getYearToken()) == null || (hour = getHourToken()) == null || (minute = getMinuteToken()) == null || (second = getSecondToken()) == null) return null;
    } else if(type == DateFormatType.yearMonthDay) {
      if((year = getYearToken()) == null || (month = getMonthToken()) == null || (day = getDayToken(null)) == null || (hour = getHourToken()) == null || (minute = getMinuteToken()) == null || (second = getSecondToken()) == null) return null;
    }

    parsedDate = Date(DateTime(year!, month!, day!, hour!, minute!, second!), formatType: type, showNamed: showNamed);
    return parsedDate;
  }
}