//
//  AIPSettingsView.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 30.03.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AIPSettingsViewProtocol.h"
#import "AIPSliderGroupView/AIPSliderGroupViewProtocol.h"


NS_ASSUME_NONNULL_BEGIN

/**
 создать такой комментарий - это через комманд+опшн+слеш
 */
@interface AIPSettingsView : UIView<AIPSliderGroupViewProtocol>

/**
 Создает и возвращает объект AIPSettingsView

 @return экземпляр AIPSettingsView
 */
+ (AIPSettingsView*) settingsViewWithBallSize:(CGFloat)ballSize
							playerRocketWidth:(CGFloat)playerWidth
							  compRocketWidth: (CGFloat)compWidth
						  gameSpeedMultiplier:(CGFloat)multiplier;

/**
 Показывает окно настроек на экране, анимированно
 */
- (void)showSettingsView;

/**
 Скрывает окно настроек на экране, анимированно
 */
- (void)hideSettingsView;

@property (nonatomic, strong) UIImage *image;	/**< Изображение для заднего фона */
@property (nonatomic, strong) UIButton *hideSettingsButton;	/**< Кнопка, скрывающая настройки */
@property (nonatomic, weak) id<AIPSettingsViewProtocol> delegate; /**< Делегат для протокола настроек */

@end

NS_ASSUME_NONNULL_END
