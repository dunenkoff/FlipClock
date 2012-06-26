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
    KDFlipClock *_fc;
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
    
    if (_fc == nil) {
        _fc = [[KDFlipClock alloc] initWithCountdownToTime:[NSDate dateWithTimeIntervalSinceNow:60*60*24+10] showsSeconds:YES showsLabels:YES];
        [_fc setFrame:CGRectMake((self.view.frame.size.width - _fc.frame.size.width) / 2, (self.view.frame.size.height - _fc.frame.size.height) / 2, _fc.frame.size.width, _fc.frame.size.height)];
        [self.view addSubview:_fc];
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
