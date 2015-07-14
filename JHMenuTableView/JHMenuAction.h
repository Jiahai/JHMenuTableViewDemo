//
//  JHMenuAction.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHMenuTableViewCell;

typedef void (^JHActionBlock)(JHMenuTableViewCell *cell,NSIndexPath *indexPath);


@protocol JHMenuActionViewDelegate <NSObject>
@optional
- (void)leftActionViewEventHandler:(JHActionBlock)actionBlock;
- (void)leftMoreButtonEventHandler;

- (void)rightActionViewEventHandler:(JHActionBlock)actionBlock;
- (void)rightMoreButtonEventHandler;

@end

@interface JHMenuAction : NSObject

@property (nonatomic, copy)         JHActionBlock   actionBlock;
@end

