#!/usr/bin/python3
import csv
from datetime import datetime, timezone, timedelta
import sys

days = []
idx = -1
with open(sys.argv[1], "rt") as f:
    DATA = csv.reader(f)
    for row in DATA:
        author = row[0]
        datetime_unix = row[1]
        dt = datetime.fromtimestamp(int(datetime_unix) / 1000, timezone.utc)
        content = row[2]
        rest = row[3:]
        
        if dt.hour > 12:
            dt = dt + timedelta(days=1)

        year = dt.year
        month = dt.month
        day = dt.day
        hour = dt.hour
        print("%" + str(hour))
    
        identifier = str(year) + "-" + str(month) + "-" + str(day)
        if idx == -1:
            days.append((identifier, 1))
            idx += 1
        else:
            if days[idx][0] == identifier:
                days[idx] = (identifier, days[idx][1] + 1)
            else:
                days.append((identifier, 1))
                idx += 1

for day in days:
    print(str(day[0]) + "," + str(day[1]))
