//
//  FullAfficheTableViewController.h
//  Kachalov
//
//  Created by User on 19.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullAfficheTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sceneSegmentControl;

@end
