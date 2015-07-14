//
//  JHMenuTextAction.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/7/13.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuAction.h"
@class UIColor;

@interface JHMenuTextAction : JHMenuAction

@property (nonatomic, copy)         NSString        *title;
@property (nonatomic, strong)       UIColor         *titleColor;
@property (nonatomic, strong)       UIColor         *backgroundColor;
@end
