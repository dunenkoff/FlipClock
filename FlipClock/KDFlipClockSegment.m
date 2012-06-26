//
//  KDFlipClockSegment.m
//  FlipClock
//
//  Created by Kyr Dunenkoff on 6/24/12.
//  Copyright (c) 2012 Solid Applications LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KDFlipClockSegment.h"

@implementation KDFlipClockSegment {
    UIImageView *_segment;
    UIImageView *_divider;
    UIImageView *_shine;
    UIImageView *_wheels;
    NSInteger _digits;
}

- (id)initWithDigits:(NSInteger)digits {
    self = [super initWithFrame:CGRectMake(0, 0, 74, 68)];
    if (self) {
        _digits = digits;
        _segment = [self createSegmentWithNumber:_digits];
        [self addSubview:_segment];
        _divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clockDivider.png"]];
        [_divider setFrame:CGRectMake((self.frame.size.width - _divider.frame.size.width) / 2, (self.frame.size.height - _divider.frame.size.height) / 2, _divider.frame.size.width, _divider.frame.size.height)];
        _divider.layer.zPosition = 2000;
        [self addSubview:_divider];
        _shine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clockShine.png"]];
        _shine.layer.zPosition = 3000;
        [self addSubview:_shine];
        _wheels =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clockWheel.png"]]; 
        _wheels.layer.zPosition = 3000;
        [self addSubview:_wheels];
    }
    return self;
}

- (UIImageView *)createSegmentWithNumber:(NSInteger)number {
    UIImageView *newSegment = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clockSegment.png"]];
    UILabel *l = [[UILabel alloc] initWithFrame:self.bounds];
    [l setBackgroundColor:[UIColor clearColor]];
    [l setTextAlignment:UITextAlignmentCenter];
    [l setText:[NSString stringWithFormat:@"%02i",number]];
    [l setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:self.frame.size.height - 12]];
    
//    [l setTextColor:[UIColor whiteColor]];
    [l setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"clockTextGradient.png"]]];
    
//    UIColor *highColor = [UIColor colorWithWhite:0. alpha:.7];
//    UIColor *midColor = [UIColor colorWithWhite:0. alpha:.2];
//    UIColor *lowColor = [UIColor colorWithWhite:0. alpha:.0];
//    
//    CAGradientLayer * gradient = [CAGradientLayer layer];
//    [gradient setFrame:l.bounds];
//    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[midColor CGColor], (id)[lowColor CGColor], nil]];
//    gradient.mask = [l.layer copy];
//    [l.layer addSublayer:gradient];
    
    [newSegment addSubview:l];
    newSegment.layer.doubleSided = NO;
    return newSegment;
}

- (void)flipWithDigits:(NSInteger)digits {
    if (_digits == digits) return;
    _digits = digits;
    CGContextRef ctx;
    
    // take old image and cut it into 2 segments
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(_segment.frame.size.width, _segment.frame.size.height / 2), NO, [UIScreen mainScreen].scale);
    ctx = UIGraphicsGetCurrentContext();
    [_segment.layer renderInContext:ctx];
    UIImage *oldSegmentTop = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(_segment.frame.size.width, _segment.frame.size.height / 2), NO, [UIScreen mainScreen].scale);
    ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, -_segment.frame.size.height / 2);
    [_segment.layer renderInContext:ctx];
    UIImage *oldSegmentBottom = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [_segment removeFromSuperview];
    
    UIImageView *oldTop = [[UIImageView alloc] initWithImage:oldSegmentTop];
    [oldTop setFrame:CGRectMake(0, 0, oldTop.frame.size.width, oldTop.frame.size.height)];
    oldTop.layer.doubleSided = NO;
    oldTop.layer.anchorPoint = CGPointMake(.5, 1.);
    oldTop.layer.position = CGPointMake(oldTop.frame.size.width / 2, oldTop.frame.size.height);
    CATransform3D ot = CATransform3DIdentity;
    ot.m34 = 1.0 / -1000.;
    oldTop.layer.transform = ot;
    
    UIImageView *oldBottom = [[UIImageView alloc] initWithImage:oldSegmentBottom];
    [oldBottom setFrame:CGRectMake(0, oldTop.frame.size.height, oldBottom.frame.size.width, oldBottom.frame.size.height)];
    oldBottom.layer.zPosition = -1000;
    
    UIImageView *newSegment = [self createSegmentWithNumber:_digits];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newSegment.frame.size.width, newSegment.frame.size.height / 2), NO, [UIScreen mainScreen].scale);
    ctx = UIGraphicsGetCurrentContext();
    [newSegment.layer renderInContext:ctx];
    UIImage *newSegmentTop = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newSegment.frame.size.width, newSegment.frame.size.height / 2), NO, [UIScreen mainScreen].scale);
    ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, -newSegment.frame.size.height / 2);
    [newSegment.layer renderInContext:ctx];
    UIImage *newSegmentBottom = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *newTop = [[UIImageView alloc] initWithImage:newSegmentTop];
    [newTop setFrame:CGRectMake(0, 0, newTop.frame.size.width, newTop.frame.size.height)];
    newTop.layer.zPosition = -1000;
    
    UIImageView *newBottom = [[UIImageView alloc] initWithImage:newSegmentBottom];
    [newBottom setFrame:CGRectMake(0, newTop.frame.size.height, newBottom.frame.size.width, newBottom.frame.size.height)];
    newBottom.layer.doubleSided = NO;
    newBottom.layer.anchorPoint = CGPointMake(.5, 0);
    newBottom.layer.position = CGPointMake(newTop.frame.size.width / 2, newTop.frame.size.height);
    CATransform3D nb = CATransform3DMakeRotation(M_PI, -1, 0, 0);
    nb.m34 = 1.0 / -1000.;
    newBottom.layer.transform = nb;
    
    [self insertSubview:oldBottom belowSubview:_divider];
    [self insertSubview:newTop belowSubview:_divider];
    [self insertSubview:oldTop belowSubview:_divider];
    [self insertSubview:newBottom belowSubview:_divider];
        
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationCurveEaseIn animations:^{
        oldTop.layer.transform = CATransform3DRotate(oldTop.layer.transform, M_PI, -1, 0, 0);
        newBottom.layer.transform = CATransform3DRotate(newBottom.layer.transform, M_PI, -1, 0, 0);
    } completion:^(BOOL finished) {
        [oldBottom removeFromSuperview];
        [newTop removeFromSuperview];
        [oldTop removeFromSuperview];
        [newBottom removeFromSuperview];
        _segment = newSegment;
        [self insertSubview:_segment belowSubview:_divider];
    }];
}

@end
