//
//  JHMenuAction.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIColor;
@class JHMenuTableViewCell;

typedef void (^JHActionBlock)(JHMenuTableViewCell *cell,NSIndexPath *indexPath);

@interface JHMenuAction : NSObject

@property (nonatomic, copy)         NSString        *title;
@property (nonatomic, strong)       UIColor         *titleColor;
@property (nonatomic, strong)       UIColor         *backgroundColor;

@property (nonatomic, copy)         JHActionBlock   actionBlock;
@end
