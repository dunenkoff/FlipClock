//
//  KDFlipClock.m
//  FlipClock
//
//  Created by Kyr Dunenkoff on 6/24/12.
//  Copyright (c) 2012 Solid Applications LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KDFlipClock.h"
#import "KDFlipClockSegment.h"

static CGSize segmentSize = {74,68};

@implementation KDFlipClock {
    NSTimer *_timer;
    NSDate *_countdown;
    KDFlipClockSegment *_day;
    KDFlipClockSegment *_hour;
    KDFlipClockSegment *_min;
    KDFlipClockSegment *_sec;
    BOOL _showsDays;
    BOOL _showsSeconds;
}

- (id)initWithCountdownToTime:(NSDate *)time showsSeconds:(BOOL)showsSeconds showsLabels:(BOOL)showsLabels {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _showsSeconds = showsSeconds;
        _countdown = time;
        NSInteger seconds = (int)[time timeIntervalSinceNow];
        if (seconds > 60 * 60 * 24) _showsDays = YES;
        
        NSInteger days;
        NSInteger hour;
        NSInteger min;
        NSInteger sec;
        
        days = seconds / (60 * 60 * 24);
        hour = (seconds - (days * 60 * 60 * 24)) / (60 * 60);
        min = (seconds - (days * 60 * 60 * 24) - (hour * 60 * 60)) / 60;
        sec = (seconds - (days * 60 * 60 * 24) - (hour * 60 * 60) - min * 60);
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:_showsSeconds ? 1 : 60 target:self selector:@selector(flip) userInfo:nil repeats:YES];
        if (!_showsSeconds) {
            [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:sec]];
        }
        
        if (_showsDays) {
            _day = [[KDFlipClockSegment alloc] initWithDigits:days];
            [_day setFrame:CGRectMake(5, 2, segmentSize.width, segmentSize.height)];
            [self addSubview:_day];
        }
        _hour = [[KDFlipClockSegment alloc] initWithDigits:hour];
        [_hour setFrame:CGRectMake(_showsDays ? CGRectGetMaxX([(UIView *)[self.subviews lastObject] frame]) : 5, 2, segmentSize.width, segmentSize.height)];
        [self addSubview:_hour];
        _min = [[KDFlipClockSegment alloc] initWithDigits:min];
        [_min setFrame:CGRectMake(CGRectGetMaxX([(UIView *)[self.subviews lastObject] frame]), 2, segmentSize.width, segmentSize.height)];
        [self addSubview:_min];
        if (_showsSeconds) {
            _sec = [[KDFlipClockSegment alloc] initWithDigits:sec];
            [_sec setFrame:CGRectMake(CGRectGetMaxX([(UIView *)[self.subviews lastObject] frame]), 2, segmentSize.width, segmentSize.height)];
            [self addSubview:_sec];
        }
        [self setFrame:CGRectMake(0, 2, CGRectGetMaxX([(UIView *)[self.subviews lastObject] frame]) + 5, segmentSize.height)];
        
        UIImageView *inset = [[UIImageView alloc] initWithFrame:CGRectMake(3, 2, self.bounds.size.width - 6, self.bounds.size.height)];
        [inset setImage:[[UIImage imageNamed:@"clockInset.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 50, 50, 50)]];
        [self insertSubview:inset atIndex:0];
        
        CGMutablePathRef p = CGPathCreateMutable();
        CGPathMoveToPoint(p, NULL, inset.frame.origin.x + 7, inset.frame.origin.y + 2);
        CGPathAddLineToPoint(p, NULL, inset.frame.size.width - 8, inset.frame.origin.y + 2);
        CGPathAddLineToPoint(p, NULL, inset.frame.origin.x + 8, inset.frame.size.height);
        CGPathAddArc(p, NULL, inset.frame.origin.x + 8, inset.frame.size.height - 7, 7, 90 * M_PI/180, 180 * M_PI/180, FALSE);
        CGPathAddLineToPoint(p, NULL, inset.frame.origin.x + 1, inset.frame.origin.y + 8);
        CGPathAddArc(p, NULL, inset.frame.origin.x + 7, inset.frame.origin.y + 8, 6, 180 * M_PI/180, 270 * M_PI/180, FALSE);
        CGPathCloseSubpath(p);
        
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path = p;
        mask.fillColor = [UIColor colorWithWhite:1. alpha:.15].CGColor;
        mask.fillRule = kCAFillRuleEvenOdd;
        mask.fillMode = kCAFillModeBoth;
        
        [self.layer addSublayer:mask];
        
        UIImageView *base;
        UIFont *f = [UIFont fontWithName:@"HelveticaNeue" size:12.];
        if (showsLabels) {
            base = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + 18)];
            [base setImage:[[UIImage imageNamed:@"clockBase.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)]];
            [self insertSubview:base atIndex:0];
            
            if (_showsDays) {
                UILabel *days = [[UILabel alloc] initWithFrame:CGRectMake(_day.frame.origin.x, CGRectGetMaxY(_day.frame), _day.frame.size.width, 12)];
                [days setText:@"дней"];
                [days setFont:f];
                [days setTextAlignment:UITextAlignmentCenter];
                [days setBackgroundColor:[UIColor clearColor]];
                [days setShadowColor:[UIColor whiteColor]];
                [days setShadowOffset:CGSizeMake(0, 1)];
                [self addSubview:days];
            }
            
            UILabel *hours = [[UILabel alloc] initWithFrame:CGRectMake(_hour.frame.origin.x, CGRectGetMaxY(_hour.frame), _hour.frame.size.width, 12)];
            [hours setText:@"часов"];
            [hours setFont:f];
            [hours setTextAlignment:UITextAlignmentCenter];
            [hours setBackgroundColor:[UIColor clearColor]];
            [hours setShadowColor:[UIColor whiteColor]];
            [hours setShadowOffset:CGSizeMake(0, 1)];
            [self addSubview:hours];
            
            UILabel *mins = [[UILabel alloc] initWithFrame:CGRectMake(_min.frame.origin.x, CGRectGetMaxY(_min.frame), _min.frame.size.width, 12)];
            [mins setText:@"минут"];
            [mins setFont:f];
            [mins setTextAlignment:UITextAlignmentCenter];
            [mins setBackgroundColor:[UIColor clearColor]];
            [mins setShadowColor:[UIColor whiteColor]];
            [mins setShadowOffset:CGSizeMake(0, 1)];
            [self addSubview:mins];
                        
            if (_showsSeconds) {
                UILabel *sec = [[UILabel alloc] initWithFrame:CGRectMake(_sec.frame.origin.x, CGRectGetMaxY(_sec.frame), _sec.frame.size.width, 12)];
                [sec setText:@"секунд"];
                [sec setFont:f];
                [sec setTextAlignment:UITextAlignmentCenter];
                [sec setBackgroundColor:[UIColor clearColor]];
                [sec setShadowColor:[UIColor whiteColor]];
                [sec setShadowOffset:CGSizeMake(0, 1)];
                [self addSubview:sec];
            }
            
        } else {
            base = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + 4)];
            [base setImage:[[UIImage imageNamed:@"clockBase.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)]];
            [self insertSubview:base atIndex:0];
        }
        
        [self setBounds:base.bounds];
        
    }
    return self;
}

- (void)flip {
    NSInteger seconds = (int)[_countdown timeIntervalSinceNow];
    
    NSInteger days;
    NSInteger hour;
    NSInteger min;
    NSInteger sec;
    
    days = seconds / (60 * 60 * 24);
    [_day flipWithDigits:days];
    hour = (seconds - (days * 60 * 60 * 24)) / (60 * 60);
    [_hour flipWithDigits:hour];
    min = (seconds - (days * 60 * 60 * 24) - (hour * 60 * 60)) / 60;
    [_min flipWithDigits:min];
    sec = (seconds - (days * 60 * 60 * 24) - (hour * 60 * 60) - min * 60);
    [_sec flipWithDigits:sec];
    
    if (seconds == 0) [_timer invalidate];
    
}

@end
