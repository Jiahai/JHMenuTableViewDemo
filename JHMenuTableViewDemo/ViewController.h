//
//  ViewController.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/21.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMenuTableView.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,JHMenuTableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

