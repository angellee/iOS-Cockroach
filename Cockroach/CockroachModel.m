//
//  CockroachModel.m
//  Cockroach
//
//  Created by Angel Lee on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CockroachModel.h"

@implementation CockroachModel

@synthesize xDirection = _xDirection;
@synthesize yDirection = _yDirection;
@synthesize velocity = _velocity;
@synthesize xPosition = _xPosition;
@synthesize yPosition = _yPosition;
@synthesize counter = _counter;


-(void) setCounter:(int)counter{
    _counter = counter;
}


-(void) setXDirection: (int) xDirection{
    _xDirection = xDirection;
    
}

-(void) setYDirection: (int) yDirection{
    _yDirection = yDirection;
}

-(void) setVelocity:(CGPoint)velocity{
    _velocity = velocity;
}

-(void) setXPosition:(int)xPosition{
    _xPosition = xPosition;
}


-(void) setYPosition:(int)yPosition{
    _yPosition = yPosition;
}


@end
