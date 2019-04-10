//
//  AIPSettingsViewProtocol.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 07.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#ifndef AIPSettingsViewProtocol_h
#define AIPSettingsViewProtocol_h


/**
 Протокол, отвечающий за передачу данных из вью настроек на основной вью контроллер
 */
@protocol AIPSettingsViewProtocol <NSObject>


/**
 Обновить размер шарика

 @param size Размер шарика, диаметр
 */
- (void) updateBallSize:(CGFloat)size;

/**
 Обновить скорость игры, через множитель
 
 @param speedMultiplier Скорость игры, множитель от базовой скорости
 */
- (void) updateGameSpeed:(CGFloat)speedMultiplier;

/**
 Обновить ширину ракетки игрока
 
 @param width Ширина ракетки
 */
- (void) updatePlayerRocketWidth:(CGFloat)width;

/**
 Обновить ширину ракетки компьютера
 
 @param width Ширина ракетки
 */
- (void) updateComputerRocketWidth:(CGFloat)width;

@end

#endif /* AIPSettingsViewProtocol_h */
