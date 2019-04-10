//
//  AIPPlayerView.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 06.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/**
 Класс для представления ракетки игрока (или компьютера)
 */
@interface AIPPlayerView : UIView

/**
 Создает и возвращает объект AIPBallView
 
 @return экземпляр AIPBallView
 */
+ (AIPPlayerView*) playerViewWithFrame:(CGRect)frame;


/**
 Устанавливает ширину ракетки игрока

 @param width Ширина ракетки в поинтах
 */
- (void) setPlayerViewWidth:(CGFloat)width;


/**
 Возвращает текущую ширину ракетки

 @return Текущая ширина в поинтах
 */
- (CGFloat) rocketWidth;

@end

NS_ASSUME_NONNULL_END
