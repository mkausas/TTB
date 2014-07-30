//
//  ViewController.h
//  Toss the Ball
//
//  Created by Marty Kausas on 5/24/14.
//  Copyright (c) 2014 Marty Kausas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {

    UIImageView *ball;
    UIImageView *leftHand;
    UIImageView *rightHand;
    UIImageView *leftAI;
    UIImageView *rightAI;
    UIImageView *slider;
    UIImageView *timerSlider;
    UIImageView *grower;

    
    CGPoint ballVelocity;
    NSInteger gameState;
    NSInteger ballTarget;
    NSInteger currentBallHolder;

    BOOL ballPossesionHasChanged;
    BOOL humanHasBall;
    

}

@property (nonatomic) IBOutlet UIImageView *ball;
@property (nonatomic) IBOutlet UIImageView *leftHand;
@property (nonatomic) IBOutlet UIImageView *rightHand;
@property (nonatomic) IBOutlet UIImageView *leftAI;
@property (nonatomic) IBOutlet UIImageView *rightAI;
@property (nonatomic) IBOutlet UIImageView *slider;
@property (nonatomic) IBOutlet UIImageView *timerSlider;
@property (nonatomic) IBOutlet UIImageView *grower;


@property (nonatomic) CGPoint ballVelocity;
@property (nonatomic) NSInteger gameState;
@property (nonatomic) NSInteger ballTarget;
@property (nonatomic) NSInteger currentBallHolder;


@property (nonatomic, assign) BOOL ballPossesionHasChanged;
@property (nonatomic, assign) BOOL humanHasBall;


- (void) play;
- (void) setupNewGame;
- (int) chooseNewTarget: (int) ballHolder;


@end
