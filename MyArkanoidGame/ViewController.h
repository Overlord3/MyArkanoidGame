//
//  ViewController.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 26.03.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AIPSettings/AIPSettingsView.h"
#import "AIPBallView/AIPBallView.h"
#import "AIPPlayerView/AIPPlayerView.h"


@interface ViewController : UIViewController <CAAnimationDelegate, AIPSettingsViewProtocol>

@property (nonatomic, strong) NSTimer *mainTimer;

@property (nonatomic, strong) UIView *gameView;
@property (nonatomic, strong) AIPBallView *ballView;
@property (nonatomic, strong) AIPPlayerView *playerView;
@property (nonatomic, strong) AIPPlayerView *compView;

@property (nonatomic, strong) AIPSettingsView *settingsView;
@property (nonatomic, strong) UIButton *settingsButton;

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, assign) NSInteger playerScore;
@property (nonatomic, assign) NSInteger computerScore;

@end
