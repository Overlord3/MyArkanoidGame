//
//  ViewController.m
//  MyArkanoidGame
//
//  Created by Александр Плесовских on 26.03.2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "ViewController.h"


@interface ViewController()

@end


@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.whiteColor;
	self.playerScore = 0;
	self.computerScore = 0;
	
	//Подготовка UI
	[self prepareUI];
	//Запуск игры
	[self prepareTimer];
}

#pragma mark - UI

- (void) prepareUI
{
	CGFloat height = self.view.bounds.size.height;
	CGFloat width = self.view.bounds.size.width;
	
	//Кнопка вызова настроек
	CGFloat settingsButtonHeight = 50;
	CGFloat border = 8;
	self.settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(border, height - settingsButtonHeight - border, width - border*2, settingsButtonHeight)];
	[self.settingsButton addTarget:self action:@selector(settingsButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[self.settingsButton setTitle:@"Настройки" forState:UIControlStateNormal];
	[self.settingsButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
	
	[self.settingsButton setTitle:@"Продолжить" forState:UIControlStateSelected];
	[self.settingsButton setTitleColor:UIColor.blackColor forState:UIControlStateSelected];
	
	self.settingsButton.backgroundColor = UIColor.lightGrayColor;
	[self.view addSubview:self.settingsButton];
	
	//Игровое поле (без кнопки настроек)
	CGFloat topBorder = 20;
	CGFloat gameViewHeight = CGRectGetMinY(self.settingsButton.frame) - border - topBorder;
	CGFloat gameViewWidth = width;
	
	self.gameView = [[UIView alloc] initWithFrame: CGRectMake(0, topBorder, gameViewWidth, gameViewHeight)];
	self.gameView.backgroundColor = UIColor.whiteColor;
	[self.view addSubview:self.gameView];
	
	//Создаем шар на игровом поле
	CGFloat ballSize = 50;
	self.ballView = [AIPBallView ballViewWithSize:ballSize];
	self.ballView.center = self.gameView.center;
	[self.gameView addSubview:self.ballView];
	
	//Создаем ракетку для игрока на игровом поле
	CGFloat playerViewHeight = 15;
	CGFloat playerViewWidth = 70;
	self.playerView = [AIPPlayerView playerViewWithFrame:CGRectMake(border, gameViewHeight - playerViewHeight, playerViewWidth, playerViewHeight)];
	[self.gameView addSubview:self.playerView];
	
	//Создаем ракетку для компьютера на игровом поле
	self.compView = [AIPPlayerView playerViewWithFrame:CGRectMake(border, border, playerViewWidth, playerViewHeight)];
	[self.gameView addSubview:self.compView];
	
	//Создаем лейбл для счета
	CGFloat scoreLabelY = 50;
	CGFloat scoreLabelWidth = 100;
	CGFloat scoreLabelHeight = 30;
	self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(border, scoreLabelY, scoreLabelWidth, scoreLabelHeight)];
	self.scoreLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
	[self.gameView addSubview:self.scoreLabel];
	[self updateScoreLabel];
	
	//Создаем экран настроек с текущими настройками
	self.settingsView = [AIPSettingsView
						 settingsViewWithBallSize:self.ballView.ballSize
						 playerRocketWidth:self.playerView.rocketWidth
						 compRocketWidth:self.playerView.rocketWidth
						 gameSpeedMultiplier: currentTimeInverval/defaultTimeInterval];
	
	self.settingsView.delegate = self;
	[self.view addSubview:self.settingsView];
}


#pragma mark - UserAction

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	//Получаем точку, куда нажал пользователь
	CGPoint point = [self touchToPoint:touches];
	//Работа с перемещением view
	self.playerView.center = CGPointMake(point.x, self.playerView.center.y);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	//Получаем точку, куда нажал пользователь
	CGPoint point = [self touchToPoint:touches];
	//Работа с перемещением view
	self.playerView.center = CGPointMake(point.x, self.playerView.center.y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	//Получаем точку, куда нажал пользователь
	CGPoint point = [self touchToPoint:touches];
	//Работа с перемещением view
	self.playerView.center = CGPointMake(point.x, self.playerView.center.y);
}

-(CGPoint) touchToPoint:(NSSet<UITouch *> *)touches
{
	UITouch* touch = touches.anyObject;
	return [touch locationInView:self.view];
}


#pragma mark - SettingsView

- (void) settingsButtonAction
{
	if (self.settingsButton.isSelected)
	{
		[self prepareTimer];
	}
	else
	{
		[self stopTimer];
		[self.view bringSubviewToFront:self.settingsView];
		[self.settingsView showSettingsView];
	}
	//change state
	self.settingsButton.selected = !self.settingsButton.selected;
}

- (void)updateBallSize:(CGFloat)size
{
	[self.ballView setBallSize:size];
}

- (void)updateComputerRocketWidth:(CGFloat)width
{
	[self.compView setPlayerViewWidth:width];
}

- (void)updatePlayerRocketWidth:(CGFloat)width
{
	[self.playerView setPlayerViewWidth:width];
}

- (void)updateGameSpeed:(CGFloat)speedMultiplier
{
	currentTimeInverval = defaultTimeInterval/speedMultiplier;
}


#pragma mark - TimerAnimation

CGFloat defaultTimeInterval = 0.01;
CGFloat currentTimeInverval = 0.01;

-(void) prepareTimer
{
	self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:currentTimeInverval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

CGFloat dx = 1, dy = 1;

-(void) timerAction
{
	//Сначала изменение позиции ракетки компьютера
	[self compViewChangeLocation];
	//Теперь изменим положение шара
	[self ballChangeLocation];
	//Проверим на столкновение с ракеткой игрока
	[self checkIntersectWithPlayerView:self.playerView];
	//Проверим на столкновение с ракеткой компьютера
	[self checkIntersectWithPlayerView:self.compView];
	
	//Проверим на столкновение с краями
	CGFloat ballViewRadius = self.ballView.frame.size.width/2;
	
	//Движение "Вверх-вниз"
	
	//Если шар у нижней границы, то игрок проиграл раунд
	if (self.ballView.center.y + ballViewRadius >= self.gameView.frame.size.height)
	{
		[self roundFinishedWithVictory:NO];
	}
	//Если шар у верхней границы, то игрок выйграл раунд
	if (self.ballView.center.y - ballViewRadius < 0)
	{
		[self roundFinishedWithVictory:YES];
	}
	
	//Движение "Влево-вправо"
	
	//Если шар у правой границы, то меняет направление налево
	if (self.ballView.center.x + ballViewRadius >= self.gameView.frame.size.width)
	{
		dx *= -1;
	}
	//Если шар у левой границы, то меняет направление направо
	if (self.ballView.center.x - ballViewRadius <= 0)
	{
		dx *= -1;
	}
}

- (void) checkIntersectWithPlayerView:(AIPPlayerView*)playerView
{
	//Если пересечение есть, но шар уже прошел мимо ракетки, то она его не останавливает,
	//А иначе шар меняет направление, идет наверх
	if (CGRectIntersectsRect(playerView.frame, self.ballView.frame)
		&& CGRectIntersection(playerView.frame, self.ballView.frame).size.height < 2)
	{
		dy *= -1;
	}
}

- (void) ballChangeLocation
{
	CGPoint center = self.ballView.center;
	self.ballView.center = CGPointMake(center.x +  dx, center.y + dy);
}

- (void) compViewChangeLocation
{
	CGFloat compViewX = self.compView.center.x;
	CGFloat ballX = self.ballView.center.x;
	
	if (compViewX > ballX)
	{
		self.compView.center = CGPointMake(compViewX - 0.5, self.compView.center.y);
	}
	else
	{
		self.compView.center = CGPointMake(compViewX + 0.5, self.compView.center.y);
	}
}


-(void) stopTimer
{
	NSLog(@"timerStopped");
	[self.mainTimer invalidate];
	self.mainTimer = nil;
}


#pragma mark - GameOverHandler

- (void) roundFinishedWithVictory:(BOOL)playerWin
{
	[self stopTimer];
	if (playerWin)
	{
		self.playerScore += 1;
		[self showAlertWithTitle: @"Раунд выйгран!" message: @"Счет обновлен. Продолжить игру?" actionTitle: @"Продолжить"];
	}
	else
	{
		self.computerScore += 1;
		[self showAlertWithTitle: @"Раунд проигран!" message: @"Счет обновлен. Продолжить игру?" actionTitle: @"Продолжить"];
	}
	[self updateScoreLabel];
}

- (void) updateScoreLabel
{
	NSString *text = [NSString stringWithFormat:@"Счет: %ld:%ld", self.playerScore, self.computerScore];
	self.scoreLabel.text = text;
}

- (void) showAlertWithTitle:(NSString*)title message:(NSString*)message actionTitle:(NSString*)actionTitle
{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action)
							 {
								 [alert dismissViewControllerAnimated:true completion:nil];
								 //Шар на центр, и запуск
								 self.ballView.center = self.gameView.center;
								 [self prepareTimer];
							 }];
	
	[alert addAction:action];
	[self presentViewController: alert animated:true completion:nil];
}

@end
