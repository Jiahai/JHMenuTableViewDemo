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

extern const NSInteger      JHActionButtonWidth;
extern const BOOL           JHActionMoreButtonShow;