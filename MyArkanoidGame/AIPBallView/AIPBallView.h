//
//  AIPBallView.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 06.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/**
 Класс для представления шарика для игры
 */
@interface AIPBallView : UIView


/**
  Создает и возвращает объект AIPBallView

 @param size Размер шарика, диаметр
 @return экземпляр AIPBallView
 */
+ (AIPBallView*) ballViewWithSize:(CGFloat)size;


/**
 Устанавливает размер шарика, помещает шар в центр экрана

 @param size Размер шарика, диаметр
 */
- (void) setBallSize:(CGFloat)size;


/**
 Возвращает текущий размер шарика

 @return Размер шарика, диаметр
 */
- (CGFloat) ballSize;


/**
 Устанавливает цвет шарика
 
 @param color Цвет шарика
 */
- (void) setBallColor:(UIColor*)color;


@end

NS_ASSUME_NONNULL_END
