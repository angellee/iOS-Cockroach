//
//  CockroachView.h
//  Cockroach
//
//  Created by Angel Lee on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CockroachView : UIView
@property (nonatomic, strong) NSArray *subViewsArray;

-(NSArray *) analyzeImage: (UIImage *) myImage;
-(UIImageView *) animateCockroach: (UIImageView *) view withArray: (NSArray *) arr;
-(UIImageView *) createCroachSubView: (UIImage *) cockroach withXpos: (int) xPosition withYpos: (int) yPosition;

@end
