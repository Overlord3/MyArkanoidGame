//
//  AIPSettingsView.m
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 30.03.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "AIPSettingsView.h"
#import "AIPSliderGroupView/AIPSliderGroupView.h"
#import "EnumSettingType.h"

static const float minBallSize = 20;
static const float maxBallSize = 100;
static const float minRocketSize = 50;
static const float maxRocketSize = 300;
static const float minSpeedMultiplier = 0.5;
static const float maxSpeedMultiplier = 3;

static const float sliderGroupHeight = 106;

@implementation AIPSettingsView

CGFloat heightScreen = 0;
CGFloat widthScreen = 0;

+ (AIPSettingsView*) settingsViewWithBallSize: (CGFloat)ballSize playerRocketWidth:(CGFloat)playerWidth compRocketWidth: (CGFloat)compWidth gameSpeedMultiplier:(CGFloat)multiplier
{
	CGFloat width = [UIScreen mainScreen].bounds.size.width;
	CGFloat height = [UIScreen mainScreen].bounds.size.height;
	heightScreen = height;
	widthScreen = width;
	
	AIPSettingsView *settingsView = [[AIPSettingsView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
	
	settingsView.backgroundColor = UIColor.whiteColor;
	
	[settingsView prepareHideButton];
	[settingsView prepareBallSizeChangerWithSize:ballSize];
	[settingsView preparePlayerRocketChangerWithWidth:playerWidth];
	[settingsView prepareCompRocketChangerWithWidth:compWidth];
	[settingsView prepareSpeedChangerWithMultiplier:multiplier];
	//скрыто снизу
	settingsView.center = CGPointMake(settingsView.center.x, height + height/2);
	
	return settingsView;
}

- (void) ballSizeChanged:(UISlider*)sender
{
	CGFloat size = ceilf(sender.value);
	[self.delegate updateBallSize:size];
}

-(void) prepareBallSizeChangerWithSize:(CGFloat)size
{
	AIPSliderGroupView *sliderGroup = [AIPSliderGroupView sliderGroupView];
	sliderGroup.frame = CGRectMake(0, 0, widthScreen, sliderGroupHeight);
	[sliderGroup setMinValue:minBallSize];
	[sliderGroup setMaxValue:maxBallSize];
	
	[sliderGroup setCurrentValue:size];
	[sliderGroup setHeaderText:@"Размер шара"];
	sliderGroup.delegate = self;
	sliderGroup.type = BALL_SIZE;
	[self addSubview:sliderGroup];
}

-(void) preparePlayerRocketChangerWithWidth:(CGFloat)width
{
	AIPSliderGroupView *sliderGroup = [AIPSliderGroupView sliderGroupView];
	sliderGroup.frame = CGRectMake(0, sliderGroupHeight, widthScreen, sliderGroupHeight);
	[sliderGroup setMinValue:minRocketSize];
	[sliderGroup setMaxValue:maxRocketSize];
	
	[sliderGroup setCurrentValue:width];
	[sliderGroup setHeaderText:@"Размер ракетки игрока"];
	sliderGroup.delegate = self;
	sliderGroup.type = PLAYER_ROCKET_SIZE;
	[self addSubview:sliderGroup];
}

-(void) prepareCompRocketChangerWithWidth:(CGFloat)width
{
	AIPSliderGroupView *sliderGroup = [AIPSliderGroupView sliderGroupView];
	sliderGroup.frame = CGRectMake(0, sliderGroupHeight*2, widthScreen, sliderGroupHeight);
	[sliderGroup setMinValue:minRocketSize];
	[sliderGroup setMaxValue:maxRocketSize];
	
	[sliderGroup setCurrentValue:width];
	[sliderGroup setHeaderText:@"Размер ракетки компьютера"];
	sliderGroup.delegate = self;
	sliderGroup.type = COMPUTER_ROCKET_SIZE;
	[self addSubview:sliderGroup];
}

-(void) prepareSpeedChangerWithMultiplier:(CGFloat)multiplier
{
	AIPSliderGroupView *sliderGroup = [AIPSliderGroupView sliderGroupView];
	sliderGroup.frame = CGRectMake(0, sliderGroupHeight*3, widthScreen, sliderGroupHeight);
	[sliderGroup setMinValue:minSpeedMultiplier];
	[sliderGroup setMaxValue:maxSpeedMultiplier];
	
	[sliderGroup setCurrentValue:multiplier];
	[sliderGroup setHeaderText:@"Скорость игры"];
	sliderGroup.delegate = self;
	sliderGroup.type = SPEED_MULTIPLIER;
	[self addSubview:sliderGroup];
}


-(void) prepareHideButton
{
	CGFloat border = 8;
	CGFloat heightButton = 50;
	
	self.hideSettingsButton = [[UIButton alloc] initWithFrame:CGRectMake(border, heightScreen - heightButton - border, widthScreen - border*2, heightButton)];
	
	[self.hideSettingsButton addTarget:self action:@selector(hideSettingsView) forControlEvents:UIControlEventTouchUpInside];
	[self.hideSettingsButton setTitle:@"Назад к игре" forState:UIControlStateNormal];
	[self.hideSettingsButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
	self.hideSettingsButton.backgroundColor = UIColor.lightGrayColor;
	[self addSubview:self.hideSettingsButton];
}

- (void)showSettingsView
{
	//Проверка, чтобы вью не уехало наверх
	if (self.center.y == heightScreen/2)
	{
		return;
	}
	
	[UIView animateWithDuration:0.7 animations:^{
		self.center = CGPointMake(self.center.x, self.center.y - heightScreen);
	}];
}

- (void)hideSettingsView
{
	//Проверка, чтобы вью не уехало вниз
	if (self.center.y == heightScreen + heightScreen/2)
	{
		return;
	}
	
	[UIView animateWithDuration:0.7 animations:^{
		self.center = CGPointMake(self.center.x, self.center.y + heightScreen);
	}];
}

- (void)updateValue:(CGFloat)value inType:(SettingType)type
{
	switch (type)
	{
		case BALL_SIZE:
			[self.delegate updateBallSize:value];
			break;
		case PLAYER_ROCKET_SIZE:
			[self.delegate updatePlayerRocketWidth:value];
			break;
		case COMPUTER_ROCKET_SIZE:
			[self.delegate updateComputerRocketWidth:value];
			break;
		case SPEED_MULTIPLIER:
			[self.delegate updateGameSpeed:value];
			break;
	}
}

@end


