//
//  CockroachView.m
//  Cockroach
//
//  Created by Angel Lee on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CockroachView.h"

@implementation CockroachView
@synthesize subViewsArray;

#define COLUMNS 5

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            }
    return self;
}

-(UIImageView *) createCroachSubView: (UIImage *) cockroach withXpos: (int) xPosition withYpos: (int) yPosition{
    
    int cockroachWidth = cockroach.size.width / COLUMNS;
    int cockroachHeight = cockroach.size.height;

    UIImageView *theView = [[UIImageView alloc]initWithFrame:CGRectMake(xPosition, yPosition,cockroachWidth, cockroachHeight)];  
   
    return theView;
}

-(NSArray *) analyzeImage: (UIImage *) myImage{
    
    int cockroachWidth = myImage.size.width / COLUMNS;
    int cockroachHeight = myImage.size.height;
    CGImageRef CGImage = [myImage CGImage];
    NSMutableArray *myArray = [[NSMutableArray alloc]init];
    
    for(int column = 0; column < COLUMNS; column++){
        CGImageRef tempImage = 
        CGImageCreateWithImageInRect(CGImage, 
                                     CGRectMake(column * cockroachWidth, 
                                                0, 
                                                cockroachWidth, 
                                                cockroachHeight));
        
        [myArray addObject: [UIImage imageWithCGImage:tempImage]];
    }
    
    NSArray *arrOfCockroach = [NSArray arrayWithArray:myArray];
    return arrOfCockroach;    
}


-(UIImageView *) animateCockroach: (UIImageView *) view withArray: (NSArray *) arr{
    
    view.animationImages = arr;
    [view setAnimationDuration:0.5];
    [view startAnimating];
    

    return view;
    
}





@end
