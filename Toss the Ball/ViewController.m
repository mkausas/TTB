//
//  ViewController.m
//  Toss the Ball
//
//  Created by Marty Kausas on 5/24/14.
//  Copyright (c) 2014 Marty Kausas. All rights reserved.
//

#import "ViewController.h"

#define kGameRunning 1
#define kBallAcceleration 0.005
#define kTimerSliderSpeed 0.05
#define kOriginalBallX 160
#define kOriginalBallY 356
#define kLeftAI 1
#define kRightAI 2
#define kHuman 3
#define growerDefaultXRight 215
#define growerDefaultYRight 151
#define growerDefaultXLeft 215
#define growerDefaultYLeft 215




@interface ViewController ()

@end

@implementation ViewController

@synthesize ball, leftHand, rightHand, leftAI, rightAI, slider, timerSlider, grower;
@synthesize ballVelocity, gameState;
@synthesize ballTarget, currentBallHolder;
@synthesize ballPossesionHasChanged, humanHasBall;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNewGame];
    
    // thread loop
    [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(run) userInfo:nil repeats:YES];
}

- (void)run {
    if (gameState == kGameRunning)
        [self play];
}

- (void)play {

    // grower prototype
//    grower.bounds = CGRectMake(grower.bounds.origin.x - 0.001, grower.bounds.origin.y - 0.003425, grower.frame.size.width + 0.001, grower.frame.size.height + 0.003425);



    
    switch (ballTarget) {
        case kHuman:
            [self setSetpoint:kOriginalBallX toY:kOriginalBallY];
            break;
        case kLeftAI:
            [self setSetpoint:leftAI.center.x toY:leftAI.center.y];
            break;
        case kRightAI:
            [self setSetpoint:rightAI.center.x toY:rightAI.center.y];
            break;
    }
    
    
    // ball possesion has changed is true when
    // previous balls target character == current ball holder
    ballPossesionHasChanged = ballTarget == currentBallHolder;
    
    // player catches ball
    if (CGRectIntersectsRect(ball.frame, leftHand.frame) ||
        CGRectIntersectsRect(ball.frame, rightHand.frame)) {
        currentBallHolder = kHuman;
        if (ballPossesionHasChanged) {
            humanHasBall = YES;
            
            int playerToThrowTo = [self chooseNewTarget:kHuman];
//            ballTarget = playerToThrowTo;
            if (playerToThrowTo == kLeftAI)
                timerSlider.center = CGPointMake(timerSlider.center.x + kTimerSliderSpeed, 274);
            else
                timerSlider.center = CGPointMake(timerSlider.center.x - kTimerSliderSpeed, 274);
//            panel.setSideTimer(playerToThrowTo);
        }
    } else {
        humanHasBall = false;
    }
    
    // left ai catches ball
    if (CGRectIntersectsRect(ball.frame, leftAI.frame)) {
        // if thrown to the wrong ai set game over to true...
        // TODO: implement here!
                
        currentBallHolder = kLeftAI;
        if (ballPossesionHasChanged) {
            int playerToThrowTo = [self chooseNewTarget:kLeftAI];
            ballTarget = playerToThrowTo;
        }
    
    // right ai catches ball
    } else if (CGRectIntersectsRect(ball.frame, rightAI.frame)) {
        // if thrown to the wrong ai set game over to true...
        // TODO: implement here!
        
        currentBallHolder = kRightAI;
        if (ballPossesionHasChanged) {
            int playerToThrowTo = [self chooseNewTarget:kRightAI];
            ballTarget = playerToThrowTo;
        }
     
    }
    
    
    // sample rectangle
//    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 800)];
//    test.backgroundColor = [UIColor redColor];
//    [self.view addSubview:test];

    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (gameState == kGameRunning) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:touch.view];
        if (humanHasBall) {
            ballTarget = location.x < self.view.bounds.size.width / 2 ? kLeftAI : kRightAI;
            timerSlider.center = CGPointMake(-320, 0);
        }
    }
}


- (void) setupNewGame {
    gameState = kGameRunning;
    ballTarget = kHuman;
    
    printf("ran setup");
}

- (int) chooseNewTarget: (int) ballHolder {
    int randomNum = arc4random_uniform(2);
    switch (ballHolder) {
        case kHuman:
            return randomNum == 0 ? kLeftAI : kRightAI;
        case kLeftAI:
            return randomNum == 0 ? kRightAI : kHuman;
        case kRightAI:
            return randomNum == 0 ? kHuman : kLeftAI;
    }
    return -1;
}



- (void)setSetpoint: (int)x toY:(int)y {
//    printf("new setpoint %i", x);
    double targetCenterX;
    double targetCenterY;
    
    switch (ballTarget) {
        case kHuman:
            targetCenterX = kOriginalBallX;
            targetCenterY = kOriginalBallY;
            break;
        case kLeftAI:
            targetCenterX = leftAI.center.x;
            targetCenterY = leftAI.center.y;
            break;
        case kRightAI:
            targetCenterX = rightAI.center.x;
            targetCenterY = rightAI.center.y;
            break;
    }
    double dx = (targetCenterX - ball.center.x) * kBallAcceleration;
    double dy = (targetCenterY - ball.center.y) * kBallAcceleration;

    ball.center = CGPointMake(ball.center.x + dx, ball.center.y + dy);
    slider.center = CGPointMake(ball.center.x - (slider.frame.size.width / 2), slider.center.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    printf("memory warning");

}

@end
