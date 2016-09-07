//
//  NewsDetailViewController.h
//  Kachalov
//
//  Created by User on 07.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property (nonatomic) NSString *detailURL;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
