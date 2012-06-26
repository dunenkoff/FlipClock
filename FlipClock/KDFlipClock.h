//
//  KDFlipClock.h
//  FlipClock
//
//  Created by Kyr Dunenkoff on 6/24/12.
//  Copyright (c) 2012 Solid Applications LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KDFlipClockTypeClock,
    KDFlipClockTypeCountdown
} KDFlipClockType;

@interface KDFlipClock : UIView

- (id)initWithCountdownToTime:(NSDate *)time showsSeconds:(BOOL)showsSeconds showsLabels:(BOOL)showsLabels;
- (id)initClockWithLabels:(BOOL)showsLabels showsSeconds:(BOOL)showsSeconds;

@end
