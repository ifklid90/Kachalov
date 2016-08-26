//
//  NewsShortCell.h
//  Kachalov
//
//  Created by User on 24.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsShortCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTextLabel;

@end
