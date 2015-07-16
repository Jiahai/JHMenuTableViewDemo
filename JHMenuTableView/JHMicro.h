//
//  JHMicro.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//



#pragma mark - 通用
#ifdef DEBUG
#define JHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JHLog(fmt, ...)
#endif

#pragma mark  颜色配置
#define JHRGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]



#pragma mark -
#pragma mark - JHMenuTableView参数配置

/**
 *  支持横屏模式
 */
extern const BOOL           kJHMenuSupportLandspaceOrientation;
/**
 *  JHTextActionButton文本的字体
 */
extern const NSInteger      JHTextActionButtonTextFontSize;
/**
 *  Menu展开/收缩的动画持续时间，单位为秒
 */
extern const float          JHMenuExpandAnimationDuration;

#pragma mark - 左侧菜单参数配置
/**
 *  左侧JHActionButton的宽度
 */
extern const NSInteger      JHActionLeftButtonWidth;
/**
 *  展开左侧Menu时，是否显示更多按钮
 */
extern const BOOL           JHActionLeftMoreButtonShow;
/**
 *  左侧菜单更多按钮出现的index，从左向右，从0开始
 */
extern const NSInteger      JHActionLeftMoreButtonIndex;
/**
 *  全部左侧菜单联动
 */
extern const BOOL           kJHMenuMoveAllLeftCells;


#pragma mark - 右侧菜单参数配置
/**
 *  右侧侧JHActionButton的宽度
 */
extern const NSInteger      JHActionRightButtonWidth;
/**
 *  展开右侧Menu时，是否显示更多按钮
 */
extern const BOOL           JHActionRightMoreButtonShow;
/**
 *  右侧菜单更多按钮出现的index，从右向左，从0开始
 */
extern const NSInteger      JHActionRightMoreButtonIndex;
/**
 *  全部右侧菜单联动
 */
extern const BOOL           kJHMenuMoveAllRightCells;

#pragma mark - 通知名
#define JHNOTIFICATION_MoveAllCells_Began           @"JHNOTIFICATION_MoveAllCells_Began"
#define JHNOTIFICATION_MoveAllCells_Changed         @"JHNOTIFICATION_MoveAllCells_Changed"
#define JHNOTIFICATION_MoveAllCells_Ended           @"JHNOTIFICATION_MoveAllCells_Ended"
#define JHNOTIFICATION_MoveAllCells_SetMenuState    @"JHNOTIFICATION_MoveAllCells_SetMenuState"

