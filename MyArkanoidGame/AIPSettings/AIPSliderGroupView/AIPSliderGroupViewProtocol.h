//
//  AIPSliderGroupViewProtocol.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 07.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#ifndef AIPSliderGroupViewProtocol_h
#define AIPSliderGroupViewProtocol_h


#import "../EnumSettingType.h"


/**
 Протокол отвечающий за передачу данных из группы слайдера на вью настроек
 */
@protocol AIPSliderGroupViewProtocol <NSObject>


/**
 Функция для обновления измененного значения в настройках

 @param value Новое значение параметра
 @param type Тип параметра, какой именно изменился
 */
- (void) updateValue:(CGFloat)value inType:(SettingType)type;

@end

#endif /* AIPSliderGroupViewProtocol_h */
