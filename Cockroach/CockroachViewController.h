//
//  CockroachViewController.h
//  Cockroach
//
//  Created by Angel Lee on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CockroachView.h"
#import "CockroachAppDelegate.h"

@interface CockroachViewController : UIViewController
{
@private
    NSTimer * countdownTimer;
    NSUInteger remainingTicks;
}
@property (strong, nonatomic) IBOutlet CockroachView *cockroachView;
@property (strong, nonatomic) NSArray *cockroachArray;
@property (strong, nonatomic) NSArray *subViewsArray;
@property (strong, nonatomic) UIImageView *ghostView, *tempView;
@property (strong, nonatomic) IBOutlet UIButton *restartButton;

@end
