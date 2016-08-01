//
// SmallAfficheCell
//
//  Created by user on 01.07.16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SmallAfficheCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *premiereTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageRatingLabel;


@end