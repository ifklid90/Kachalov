//
//  AboutTheaterViewController.h
//  Kachalov
//
//  Created by User on 01.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutTheaterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *sectionSegmentControl;
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;
@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;

@end
