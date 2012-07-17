//
//  SettingViewController.h
//  WaktuSolat
//
//  Created by MSi on 7/16/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    UIWindow *window;
    NSMutableArray *items;
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;

@end
