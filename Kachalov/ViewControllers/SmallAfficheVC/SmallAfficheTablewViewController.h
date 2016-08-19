//
//  SmallAfficheTablewViewController.h
//  Kachalov
//
//  Created by User on 29.06.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallAfficheTablewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end
