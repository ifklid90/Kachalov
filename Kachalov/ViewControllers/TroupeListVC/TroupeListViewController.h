//
//  TroupeListViewController.h
//  Kachalov
//
//  Created by User on 27.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TroupeListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *navigationSegmentControl;

@end
