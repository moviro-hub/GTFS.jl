# using Dates: Dates
# using TimeZones: TimeZones
# using Colors: Colors


# function convert_color(value::String)
#     if length(value) != 6
#         throw(ArgumentError("Color must be 6 characters long"))
#     end
#     if !all(isdigit(c) for c in value)
#         throw(ArgumentError("Color must be a hexadecimal number"))
#     end
#     return Colors.colorant"#$(value)"
# end
# convert_color(value::Missing) = missing

# function convert_date(value::String)
#     if length(value) != 8
#         throw(ArgumentError("Date must be in YYYYMMDD format"))
#     end
#     if !all(isdigit(c) for c in value)
#         throw(ArgumentError("Date must be a numeric string"))
#     end
#     return Date(value, "YYYYMMDD")
# end
# convert_date(value::Missing) = missing

# convert_enum(value::Int8) = value
# convert_enum(value::Missing) = missing
# convert_enum(value::Missing, default::Int8) = default

# function convert_time(value::String)
#     if !match(r"^(\d{1,2}):(\d{2}):(\d{2})$", value) !== nothing
#         throw(ArgumentError("Time must be in HH:MM:SS format"))
#     end
#     split_time = split(value, ":")
#     hours = parse(Int, split_time[1])
#     minutes = parse(Int, split_time[2])
#     seconds = parse(Int, split_time[3])
#     return Second(hours * 3600 + minutes * 60 + seconds)
# end
# convert_time(value::Missing) = missing

# function convert_timezone(value::String)
#     if !match(r"^[A-Za-z0–9/_+-]+$", value) !== nothing
#         throw(ArgumentError("Timezone must be a valid timezone string"))
#     end
#     return TimeZones.TimeZone(value)
# end
# convert_timezone(value::Missing) = missing

# # merge fields into a single type
# struct LatLon
#     latitude::Float32
#     longitude::Float32
# end
# as_latlon(latitude::Float32, longitude::Float32) = LatLon(latitude, longitude)
# as_latlon(latitude::Missing, longitude::Missing) = missing
# as_latlon(latitude::Missing, longitude::Float32) = missing
# as_latlon(latitude::Float32, longitude::Missing) = missing

# function as_datetime(date::Dates.Dates, time::Dates.Second, timezone::TimeZones.TimeZone)
#     basedatetime = TimeZones.ZonedDateTime(date, Dates.Time(12, 0, 0), timezone) - Dates.Hour(12)
#     return basedatetime + time
# end
# as_datetime(date::Missing, time, timezone) = missing
# as_datetime(date, time::Missing, timezone) = missing
# as_datetime(date, time, timezone::Missing) = missing
