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
 *  JHActionButton的宽度
 */
extern const NSInteger      JHActionButtonWidth;

/**
 *  JHTextActionButton文本的字体
 */
extern const NSInteger      JHTextActionButtonTextFontSize;

/**
 *  展开Menu时，是否显示更多按钮，暂只支持RightActionView
 */
extern const BOOL           JHActionMoreButtonShow;

/**
 *  更多按钮出现的index，从右向左，从0开始
 */
extern const NSInteger      JHActionMoreButtonIndex;

/**
 *  Menu展开/收缩的动画持续时间，单位为秒
 */
extern const float          JHMenuExpandAnimationDuration;