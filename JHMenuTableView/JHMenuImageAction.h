//
//  JHMenuImageAction.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/7/13.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import "JHMenuAction.h"

@interface JHMenuImageAction : JHMenuAction

@property (nonatomic, assign)   BOOL        selected;
@property (nonatomic, copy)     NSString    *image_normal;
@property (nonatomic, copy)     NSString    *image_selected;

/**
 *  定义此Action为复选框，默认为YES，如无需使用，请自行设置为NO
 */
@property (nonatomic, assign)   BOOL        checkboxModel;

@end
