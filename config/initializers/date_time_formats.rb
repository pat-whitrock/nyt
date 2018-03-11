# ex. January 2nd, 2007
Time::DATE_FORMATS[:default] = ->(date) { date.strftime("%B #{date.day.ordinalize}, %Y") }
