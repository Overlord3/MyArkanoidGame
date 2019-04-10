//
//  AIPBallView.m
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 06.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "AIPBallView.h"


@implementation AIPBallView

+ (AIPBallView*) ballViewWithSize:(CGFloat)size
{
	AIPBallView *ballView = [[AIPBallView alloc] initWithFrame:CGRectMake(50, 50, size, size)];
	
	ballView.backgroundColor = UIColor.redColor;
	
	ballView.layer.cornerRadius = size/2;
	ballView.layer.masksToBounds = YES;

	return ballView;
}

- (void)setBallSize:(CGFloat)size
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size, size);
	self.layer.cornerRadius = size/2;
	//поставим в центре супервью
	self.center = self.superview.center;
}

- (void)setBallColor:(UIColor*)color
{
	self.backgroundColor = color;
}

- (CGFloat)ballSize
{
	return self.frame.size.width;
}

@end
