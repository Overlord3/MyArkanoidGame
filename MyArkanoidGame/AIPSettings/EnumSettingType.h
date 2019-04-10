//
//  EnumSettingType.h
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 07.04.2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#ifndef EnumSettingType_h
#define EnumSettingType_h

/**
 Enum для определени какая именно настройка изменилась

 - BALL_SIZE: Размер шарика
 - PLAYER_ROCKET_SIZE: Ширина ракетки игрока
 - COMPUTER_ROCKET_SIZE: Ширина ракетки компьютера
 - SPEED_MULTIPLIER: Скорость игры
 */
typedef NS_ENUM(NSUInteger, SettingType)
{
		BALL_SIZE = 0,
		PLAYER_ROCKET_SIZE = 1,
		COMPUTER_ROCKET_SIZE = 2,
		SPEED_MULTIPLIER = 3
};

#endif /* EnumSettingType_h */
