//
//  CockroachModel.h
//  Cockroach
//
//  Created by Angel Lee on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CockroachModel: NSObject

@property (nonatomic) int xDirection, yDirection;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) int xPosition, yPosition;
@property (nonatomic) int counter;

@end
