//
//  JHMenuActionView.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/3/27.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMenuAction.h"

@protocol JHMenuActionViewDelegate <NSObject>

- (void)actionViewEventHandler:(JHActionBlock)actionBlock;

@end

@interface JHMenuActionView : UIView
{
    
}

@property (nonatomic, assign)       id<JHMenuActionViewDelegate>   delegate;

- (void)setActions:(NSArray *)actions;

//- (instancetype)initWithFrame:(CGRect)rect actions:(NSArray *)actions;
@end
