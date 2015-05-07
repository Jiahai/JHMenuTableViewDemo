//
//  ViewController.h
//  JHMenuTableViewDemo
//
//  Created by Jiahai on 15/4/21.
//  Copyright (c) 2015年 Jiahai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

