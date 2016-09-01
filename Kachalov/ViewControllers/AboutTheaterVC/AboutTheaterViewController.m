//
//  AboutTheaterViewController.m
//  Kachalov
//
//  Created by User on 01.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "AboutTheaterViewController.h"

@implementation AboutTheaterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidLayoutSubviews
{
    self.aboutTextView.contentOffset = CGPointZero;
}

- (IBAction)sectionSegmentControlValueChanged:(id)sender {
//    NSLog(@"content offset = %@", NSStringFromCGPoint(self.aboutTextView.contentOffset));
//    NSLog(@"content inset = %@", NSStringFromUIEdgeInsets(self.aboutTextView.contentInset));
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    if (segmentControl.selectedSegmentIndex == 0){
        self.aboutTextView.hidden = NO;
        self.contactsTableView.hidden = YES;
    } else {
        self.aboutTextView.hidden = YES;
        self.contactsTableView.hidden = NO;
    }
}




@end
