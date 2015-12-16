# General Guidelines

These are general guidelines intended for any language and/or project.
In cases where one rule does not apply make best reasonable efforts to 

## Guidelines For Dates/Times

These guidelines cover what to do when dealing with dates and times.

* Store and transmit all dates/times in UTC.
* Convert to local time as close to the client as possible. IE. When dealing with a web application transmit all dates to/from any api, middleware, or application servers in UTC and convert to/from UTC inside the frontend (browser/js).