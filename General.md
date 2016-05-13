# General Guidelines

These are general guidelines intended for any language and/or project.
In cases where one rule does not apply make best reasonable efforts to continue following all other applicable rules.

## Guidelines For Comments

1. Err on the side of too-many inline comments rather than too few. Documentation can never be to verbose.
2. Commented-out code should not be committed into source control without an explanation as to why to the code was not simply deleted. This usually takes the form of describing when or under what conditions the code is to be un-commented. If a change request or ticketing system is available the commented out code should be preceded with a link (or ticket/case identifier) to a case in this system to un-comment this code.

## Guidelines For Dates/Times

These guidelines cover what to do when dealing with dates and times.

1. Always preserve the offset in date-time objects.
    1. When processing all date-time objects use an object that maintains the offset. Ie: C#'s `DateTimeOffset` class, SQL's `datetimeoffset` type, or JavaScript's `Date` object.
    2. When serializing these to strings (for any kind of storage including text files, xml, and json; or to transmit them) always use [ISO 8601 format](https://en.wikipedia.org/wiki/ISO_8601) including the offset. Ie: '2016-05-13T10:48:00-04:00' or '2016-05-13T14:48:00Z'.
3. Store and transmit all date-time objects in UTC.
2. Convert to local time as close to the client as possible. IE. When dealing with a web application transmit all dates to/from any api, middleware, or application servers in UTC and convert to/from UTC inside the frontend (browser/js).