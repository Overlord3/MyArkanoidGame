//
//  AIPSliderGroupView.m
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 07.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "AIPSliderGroupView.h"
#import <UIKit/UIKit.h>


@interface AIPSliderGroupView ()

@property (nonatomic, strong) UILabel* headerLabel;
@property (nonatomic, strong) UILabel* leftValueLabel;
@property (nonatomic, strong) UISlider* slider;
@property (nonatomic, strong) UILabel* rightValueLabel;
@property (nonatomic, strong) UILabel* currentValueLabel;

@end

@implementation AIPSliderGroupView

CGFloat width = 0;
CGFloat height = 80;

+ (AIPSliderGroupView*) sliderGroupView
{
	width = [UIScreen mainScreen].bounds.size.width;
	
	AIPSliderGroupView *sliderGroupView = [[AIPSliderGroupView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
	
	sliderGroupView.backgroundColor = UIColor.whiteColor;
	
	[sliderGroupView prepareUI];
	
	return sliderGroupView;
}

- (void) prepareUI
{
	//Общая высота : 30 + 20 + 8 + 20 + 8 + 20 = 106
	CGFloat topBorder = 30;
	CGFloat labelHeigth = 20;
	CGFloat labelWidth = 50;
	CGFloat border = 8;
	
	self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(border, topBorder, width - border*2, labelHeigth)];
	[self addSubview:self.headerLabel];
	
	CGFloat leftLabelY = CGRectGetMaxY(self.headerLabel.frame) + border;
	self.leftValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(border, leftLabelY, labelWidth, labelHeigth)];
	[self addSubview:self.leftValueLabel];
	
	self.rightValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(width - labelWidth - border, leftLabelY, labelWidth, labelHeigth)];
	[self addSubview:self.rightValueLabel];
	
	self.slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftValueLabel.frame) + border, leftLabelY, width - 2*labelWidth - 4*border, labelHeigth)];
	[self.slider addTarget:self action:@selector(updateCurrentValueLabel) forControlEvents:UIControlEventValueChanged];
	[self addSubview:self.slider];
	
	CGFloat currentLabelY = CGRectGetMaxY(self.leftValueLabel.frame) + border;
	self.currentValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(border, currentLabelY, width - 2*border, labelHeigth)];
	[self addSubview:self.currentValueLabel];
}


- (void)setMinValue:(CGFloat)value
{
	self.slider.minimumValue = value;
	self.leftValueLabel.text = [NSString stringWithFormat:@"%.1f", value];
}

- (void)setMaxValue:(CGFloat)value
{
	self.slider.maximumValue = value;
	self.rightValueLabel.text = [NSString stringWithFormat:@"%.1f", value];
}

- (void)setCurrentValue:(CGFloat)value
{
	self.slider.value = value;
	[self updateCurrentValueLabel];
}

- (void)setHeaderText:(NSString *)text
{
	self.headerLabel.text = text;
}

- (void) updateCurrentValueLabel
{
	self.currentValueLabel.text = [NSString stringWithFormat:@"Текущее значение: %.1f", self.slider.value];
	[self.delegate updateValue:self.slider.value inType:self.type];
}

@end
