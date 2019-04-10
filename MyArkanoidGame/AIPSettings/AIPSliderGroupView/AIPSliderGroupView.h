//
//  AIPSliderGroupView.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 07.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AIPSliderGroupViewProtocol.h"


NS_ASSUME_NONNULL_BEGIN

/**
 Класс представляющий одну настройку со слайдером
 */
@interface AIPSliderGroupView : UIView

/**
 Создает и возвращает объект AIPSliderGroupView
 
 @return экземпляр AIPSliderGroupView
 */
+ (AIPSliderGroupView*) sliderGroupView;


/**
 Устанавливает минимальное значение для настройки, для слайдера

 @param value Значение настройки
 */
- (void) setMinValue:(CGFloat)value;

/**
 Устанавливает максимальное значение для настройки, для слайдера
 
 @param value Значение настройки
 */
- (void) setMaxValue:(CGFloat)value;

/**
 Устанавливает текущее значение для настройки, для слайдера
 
 @param value Значение настройки
 */
- (void) setCurrentValue:(CGFloat)value;

/**
 Устанавливает описание настройки, текст над слайдером
 
 @param value Текст
 */
- (void) setHeaderText:(NSString*)text;


@property (nonatomic, assign) SettingType type; /**< Тип настройки, за которую отвечает данная группа */
@property (nonatomic, weak) id<AIPSliderGroupViewProtocol> delegate; /**< Делегат для обновления значения */

@end

NS_ASSUME_NONNULL_END
