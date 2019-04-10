//
//  AIPPlayerView.m
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 06.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "AIPPlayerView.h"


@implementation AIPPlayerView

+ (AIPPlayerView*) playerViewWithFrame:(CGRect)frame
{
	AIPPlayerView *playerView = [[AIPPlayerView alloc] initWithFrame:frame];
	
	playerView.backgroundColor = UIColor.redColor;
	return playerView;
}

- (void)setPlayerViewWidth:(CGFloat)width
{
	CGPoint center = self.center;
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
	//сохраним центровку
	self.center = center;
}

- (CGFloat)rocketWidth
{
	return self.frame.size.width;
}

@end
