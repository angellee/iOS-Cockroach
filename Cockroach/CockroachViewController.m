//
//  CockroachViewController.m
//  Cockroach
//
//  Created by Angel Lee on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CockroachViewController.h"
#import "CockroachView.h"
#import "CockroachModel.h"


@implementation CockroachViewController

@synthesize cockroachView = _cockroachView;
@synthesize cockroachArray;
@synthesize subViewsArray;
@synthesize ghostView;
@synthesize tempView;
@synthesize restartButton;


-(CockroachView *) cockroachView{
    if(!_cockroachView) _cockroachView = [[CockroachView alloc]init];
    
    return _cockroachView;
}

//value == 1, assign -1; value == 2, assign 1.
-(int) generateDirection{
    int value = (arc4random() % 2) + 1;
    return value;
}

-(int) generateXPosition{
    int width = self.cockroachView.frame.size.width - 70;
    int value = (arc4random() % width);
    value += 35;
    return value;
}

-(int) generateYPosition{
    int height = self.cockroachView.frame.size.height - 70;
    int value = (arc4random() % height);
    value += 35;
    return value;
}


-(float) generateRandomNumber{
    float value = (arc4random() % 2) + 1;
    return value;
}


- (IBAction)restartPressed:(UIButton *)sender {
   
    for (UIImageView *subView in self.subViewsArray) {
        [subView removeFromSuperview];
    }
    self.subViewsArray = nil;
    self.cockroachArray = nil;
    
    [self generateCockroaches:10];
  }



-(void) handleTouchEvent:(UITapGestureRecognizer *)sender{
    
    UIImageView *view = [self.subViewsArray objectAtIndex:sender.view.tag]; 
    CockroachModel *croach = [self.cockroachArray objectAtIndex:sender.view.tag];
     UIImage *tempImg;
     
    if(croach.xDirection ==1 && croach.yDirection== 1)
    {
        tempImg = [UIImage imageNamed:@"cock_fly_down_right.png"];
    }
    else if(croach.xDirection ==-1 &&croach.yDirection == 1)    
    {
        tempImg = [UIImage imageNamed:@"cock_fly_down_left.png"];
    }
    else if(croach.xDirection ==1 && croach.yDirection == -1)
    {
        tempImg = [UIImage imageNamed:@"cock_fly_up_right.png"];
    }
    else{
        tempImg =  [UIImage imageNamed:@"cock_fly_up_left.png"];
    }

    [self.cockroachView animateCockroach:view withArray:[self.cockroachView analyzeImage:tempImg]];
  
}

-(void) handlePressEvent: (UILongPressGestureRecognizer *) sender{
    
    UIImageView *view = [self.subViewsArray objectAtIndex:sender.view.tag]; 
    int xPos = view.center.x;
    int yPos = view.center.y;

    UIImage *tempImg = [UIImage imageNamed:@"ghost_cock.png"];
    UIImageView *tempGhostView = [[UIImageView alloc]initWithFrame:CGRectMake(xPos, yPos,tempImg.size.width, tempImg.size.height)];  
    tempGhostView.image = tempImg;
    
    [view removeFromSuperview];
        
    self.ghostView = tempGhostView;
    remainingTicks = 10;
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(displayGhostView) userInfo:nil repeats:YES];
  
}

-(void) displayGhostView{
    
    UIImageView *tmpView = [[UIImageView alloc] init];
    tmpView = self.ghostView;
    [self.cockroachView addSubview:tmpView];
    int x = self.ghostView.center.x;
    int y = self.ghostView.center.y;
    y -= 2.0;
    tmpView.center = CGPointMake(x, y);
    remainingTicks--;

    if(remainingTicks<=0){
      
        [tmpView removeFromSuperview];
        tmpView = nil;
        [countdownTimer invalidate];
        countdownTimer = nil;
    }
}

-(void) update{
       
    for(int i=[self.cockroachArray count]-1; i>=0;i--){
        CockroachModel *model = [self.cockroachArray objectAtIndex:i];
        UIImage *tempImg;
        
        model.xPosition += (model.velocity.x *model.xDirection);
        model.yPosition += (model.velocity.y * model.yDirection);
        UIImageView *view = [self.subViewsArray objectAtIndex:i];
        view.center = CGPointMake(model.xPosition, model.yPosition);
        
        // check croach boundary; change direction if necessary
        if((model.xPosition > self.cockroachView.frame.size.width-35 ) || (model.xPosition < 35))
        {
            model.xDirection *= -1;
            
            if(model.xDirection ==1 && model.yDirection== 1)
            {
                tempImg = [UIImage imageNamed:@"cock_walk_down_right.png"];
            }
            else if(model.xDirection ==-1 && model.yDirection == 1)
            {
                tempImg = [UIImage imageNamed:@"cock_walk_down_left.png"];
            }
            else if(model.xDirection ==1 && model.yDirection == -1)
            {
                tempImg = [UIImage imageNamed:@"cock_walk_up_right.png"];
            }
            else{
                tempImg =  [UIImage imageNamed:@"cock_walk_up_left.png"];
            }
             
            [self.cockroachView animateCockroach:view withArray:[self.cockroachView analyzeImage:tempImg]];
        }

        if((model.yPosition > self.cockroachView.frame.size.height-35) || model.yPosition<35)
        {
            model.yDirection *= -1;

            if(model.xDirection ==1 && model.yDirection== 1)
            {
                tempImg = [UIImage imageNamed:@"cock_walk_down_right.png"];
            
            }
            else if(model.xDirection ==-1 && model.yDirection == 1)
            {
                tempImg = [UIImage imageNamed:@"cock_walk_down_left.png"];
          
            }
            else if(model.xDirection ==1 && model.yDirection == -1)
            {
                tempImg = [UIImage imageNamed:@"cock_walk_up_right.png"];
               
            }
            else{
                tempImg =  [UIImage imageNamed:@"cock_walk_up_left.png"];
            }
            
            [self.cockroachView animateCockroach:view withArray:[self.cockroachView analyzeImage:tempImg]];
        }
    }
}

-(void) generateCockroaches:(int) numberOfCockroaches{
  
    NSMutableArray *tempCroachArray = [[NSMutableArray alloc]init]; 
    NSMutableArray *tempViewsArray = [[NSMutableArray alloc]init]; 
    
    int tempXDir = 0, tempYDir = 0;
    float rand = 0.0;
    UIImageView *mySubView;
    UIImage *tempImg;
    NSArray *tempAnimationArray;   
    
    for(int i=0; i<numberOfCockroaches;i++){
  
        UITapGestureRecognizer *touched = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouchEvent:)];
        
        UILongPressGestureRecognizer *pressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePressEvent:)];

        CockroachModel *myCockroach = [[CockroachModel alloc]init];
        
        tempXDir = [self generateDirection];
        tempYDir = [self generateDirection];
        rand = [self generateRandomNumber];
            
        myCockroach.counter = 0;
        myCockroach.xPosition = [self generateXPosition];
        myCockroach.yPosition = [self generateYPosition];
        myCockroach.velocity =  CGPointMake(2.0,2.0);
    
        
        //value == 1, assign -1; value == 2, assign 1.
        if(tempXDir == 1 && tempYDir == 1){
            myCockroach.xDirection = -1;
            myCockroach.yDirection = -1;
            tempImg =  [UIImage imageNamed:@"cock_walk_up_left.png"];
     
        }   
        else if(tempXDir == 1 && tempYDir == 2){
            myCockroach.xDirection = -1;
            myCockroach.yDirection = 1;  
            tempImg = [UIImage imageNamed:@"cock_walk_down_left.png"];
 
        }
        else if(tempXDir == 2 && tempYDir == 1){
            myCockroach.xDirection = 1;
            myCockroach.yDirection = -1;  
            tempImg = [UIImage imageNamed:@"cock_walk_up_right.png"];
        }
        else {
            myCockroach.xDirection = 1;
            myCockroach.yDirection = 1;
            tempImg = [UIImage imageNamed:@"cock_walk_down_right.png"];
        }
        
        [tempCroachArray addObject:myCockroach];
        tempAnimationArray = [self.cockroachView analyzeImage:tempImg];
             
        mySubView = [self.cockroachView createCroachSubView:tempImg withXpos:myCockroach.xPosition withYpos:myCockroach.yPosition];
         
         mySubView.tag = i;
         mySubView.userInteractionEnabled = YES;
         
        [mySubView addGestureRecognizer:touched];
        [mySubView addGestureRecognizer:pressed];

        [self.cockroachView animateCockroach:mySubView withArray:tempAnimationArray];
        [self.cockroachView addSubview:mySubView];
        [tempViewsArray addObject:mySubView];
    }
    self.cockroachArray = [NSArray arrayWithArray:tempCroachArray];
    self.subViewsArray = [NSArray arrayWithArray:tempViewsArray];
    
  }

-(void) viewDidLoad{

    [super viewDidLoad];
      [self.cockroachView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"croachBackground.png"]]];
    
    [self generateCockroaches:10];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(update) userInfo:nil repeats:YES];

    restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restartButton setImage:[UIImage imageNamed:@"restart.png"] forState:UIControlStateNormal];
    restartButton.frame = CGRectMake(3, 3, 60, 60); 
    [self.cockroachView addSubview:restartButton];
    
    [restartButton addTarget:self action:@selector(restartPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidUnload {
    [self setCockroachView:nil];
    [self setRestartButton:nil];
 
    [self setRestartButton:nil];
    [super viewDidUnload];
    
}
@end
