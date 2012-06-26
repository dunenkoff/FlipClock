FlipClock
===========

Simple configurable countdown/clock component, Siri-style. Uses QuartzCore, so don't forget to include that in your projects.

Usage
-------
For countdown, do this: 

	KDFlipClock *countdown = [[KDFlipClock alloc] initWithCountdownToTime:[NSDate dateWithTimeIntervalSinceNow:60*60*24] showsSeconds:YES showsLabels:YES];

Days will be automatically shown/hidden depending on supplied date.

For clock, current time will be used, so no date required:

	KDFlipClock *clock = [[KDFlipClock alloc] initClockWithLabels:YES showsSeconds:YES];


License
-------
 
Copyright &copy; 2012 Kyr Dunenkoff for Solid Software Solutions. Art by Diego Monzon - http://dmonzon.com/freebies/siri-freebie/. Licensed under WTFPL.