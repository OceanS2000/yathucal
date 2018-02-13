# -*- coding: utf-8 -*-

import json
from uuid import uuid1
from datetime import date, time, datetime, timedelta, timezone
import icalendar

TERMWEEKS = 16

with open("class.json", 'r') as f:
    entry = json.load(f)

calendar = icalendar.Calendar()
calendar['version'] = '2.0'
calendar['prodid'] = '-//THU//Syllabus//CN'

for klass in entry:
    event = icalendar.Event()

    kl_start = 0
    kl_interval = 1
    if(klass['ClassWeeks'] == '全'):
        kl_count = TERMWEEKS
    elif(klass['ClassWeeks'] == '前八'):
        kl_count = TERMWEEKS // 2
    elif(klass['ClassWeeks'] == '后八'):
        kl_count = TERMWEEKS // 2
        kl_start = TERMWEEKS // 2
    elif(klass['ClassWeeks'] == '单'):
        kl_count = TERMWEEKS // 2
        kl_interval = 2
    elif(klass['ClassWeeks'] == '双'):
        kl_count = TERMWEEKS //2
        kl_interval = 2
        kl_start = 1
    else:
        (kl_start, kl_end) = klass['ClassWeeks'].split('-')
        kl_start = int(kl_start) - 1
        kl_count = int(kl_end) - kl_start

    event.add('uid', str(uuid1())+'@THU')
    event.add('summary', klass['Summary'])
    event.add('dtstart', datetime(*klass['TimeStart']) + timedelta(kl_start * 7))
    event.add('dtend',   datetime(*klass['TimeEnd']) + timedelta(kl_start * 7))
    event.add('dtstamp', datetime.today())
    event.add('location',klass['Location'])
    event.add('rrule', {'freq': 'weekly', 'interval': kl_interval, 'count': kl_count})
    calendar.add_component(event)

with open('classtable.ics', 'w+', encoding='utf-8') as ics:
    ics.write(calendar.to_ical().decode('utf-8'.replace('\r\n', '\n').strip()))


