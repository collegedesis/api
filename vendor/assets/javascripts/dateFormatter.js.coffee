# https://gist.github.com/765200

window.strftime = (->
  zeropad = (n) ->
    (if n > 9 then n else "0" + n)

  shortDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  shortMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  callbacks =
    
    # Short day name (Sun-Sat)
    a: (t) ->
      shortDays[t.getDay()]

    
    # Long day name (Sunday-Saturday)
    A: (t) ->
      days[t.getDay()]

    
    # Short month name (Jan-Dec)
    b: (t) ->
      shortMonths[t.getMonth()]

    
    # Long month name (January-December)
    B: (t) ->
      months[t.getMonth()]

    
    # String representation (Thu Dec 23 2010 11:48:54 GMT-0800 (PST))
    c: (t) ->
      t.toString()

    
    # Two-digit day of the month (01-31)
    d: (t) ->
      zeropad t.getDate()

    
    # Day of the month (1-31)
    D: (t) ->
      t.getDate()

    
    # Two digit hour in 24-hour format (00-23)
    H: (t) ->
      zeropad t.getHours()

    
    # Hour in 24-hour format (0-23)
    i: (t) ->
      t.getHours()

    
    # Two digit hour in 12-hour format (01-12)
    I: (t) ->
      zeropad callbacks.l(t)

    
    # Hour in 12-hour format (1-12)
    l: (t) ->
      hour = t.getHours() % 12
      (if hour is 0 then 12 else hour)

    
    # Two digit month (01-12)
    m: (t) ->
      zeropad t.getMonth() + 1

    
    # Two digit minutes (00-59)
    M: (t) ->
      zeropad t.getMinutes()

    
    # am or pm
    p: (t) ->
      (if callbacks.H(t) < 12 then "am" else "pm")

    
    # AM or PM
    P: (t) ->
      (if callbacks.H(t) < 12 then "AM" else "PM")

    
    # Two digit seconds (00-61)
    S: (t) ->
      zeropad t.getSeconds()

    
    # Zero-based day of the week (0-6)
    w: (t) ->
      t.getDay()

    
    # Locale-specific date representation
    x: (t) ->
      t.toLocaleDateString()

    
    # Locale-specific time representation
    X: (t) ->
      t.toLocaleTimeString()

    
    # Year without century (00-99)
    y: (t) ->
      zeropad callbacks.Y(t) % 100

    
    # Year with century
    Y: (t) ->
      t.getFullYear()

    
    # Timezone offset (+0000)
    Z: (t) ->
      if t.getTimezoneOffset() > 0
        "-" + zeropad(t.getTimezoneOffset() / 60) + "00"
      else
        "+" + zeropad(Math.abs(t.getTimezoneOffset()) / 60) + "00"

    
    # A percent sign
    "%": (t) ->
      "%"

  
  ###
  Returns a string of this date in the given +format+.
  ###
  (date, format) ->
    regexp = undefined
    date = date or new Date()
    for key of callbacks
      regexp = new RegExp("%" + key, "g")
      format = format.replace(regexp, callbacks[key](date))
    format
)()