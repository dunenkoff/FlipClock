//
//  KDViewController.m
//  FlipClock
//
//  Created by Kyr Dunenkoff on 6/24/12.
//  Copyright (c) 2012 Solid Applications LLC. All rights reserved.
//

#import "KDViewController.h"
#import "KDFlipClock.h"

@interface KDViewController ()

@end

@implementation KDViewController {
    KDFlipClock *_clock;
    KDFlipClock *_countdown;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    if (_clock == nil) {
        _clock = [[KDFlipClock alloc] initClockWithLabels:YES showsSeconds:YES];
        [_clock setFrame:CGRectMake((self.view.frame.size.width - _clock.frame.size.width) / 2, (self.view.frame.size.height - _clock.frame.size.height) / 3, _clock.frame.size.width, _clock.frame.size.height)];
        [self.view addSubview:_clock];
        
        _countdown = [[KDFlipClock alloc] initWithCountdownToTime:[NSDate dateWithTimeIntervalSinceNow:60*60*24] showsSeconds:YES showsLabels:YES];
        [_countdown setFrame:CGRectMake((self.view.frame.size.width - _countdown.frame.size.width) / 2, (self.view.frame.size.height - _countdown.frame.size.height) / 1.5, _countdown.frame.size.width, _countdown.frame.size.height)];
        [self.view addSubview:_countdown];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
