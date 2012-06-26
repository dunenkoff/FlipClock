//
//  KDFlipClockSegment.h
//  FlipClock
//
//  Created by Kyr Dunenkoff on 6/24/12.
//  Copyright (c) 2012 Solid Applications LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDFlipClockSegment : UIView

- (id)initWithDigits:(NSInteger)digits;
- (void)flipWithDigits:(NSInteger)digits;

@end
