//
//  WaktuSolatViewController.h
//  WaktuSolat
//
//  Created by Muhammad Syahmi Ismail on 3/2/12.
//  Copyright (c) 2012 Wutmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JakimSolatParser.h"

@interface WaktuSolatViewController : UITableViewController <JakimSolatDelegate> {
    NSMutableArray *waktuSolat;
    NSMutableArray *waktuSolatLabel;
}

@end
