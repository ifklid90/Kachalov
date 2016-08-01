//
//  SmallAfficheElement.m
//  Kachalov
//
//  Created by User on 23.06.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "SmallAfficheElement.h"

@implementation SmallAfficheElement
- (NSString *)description
{
    return [NSString stringWithFormat:@"\ndate = %@;\nday = %@;\npremiere = %@;\nautor = %@;\nname = %@;\ngenre = %@;\nage_raiting = %@\n",
            self.date,
            self.day,
            self.premiere,
            self.author,
            self.name,
            self.genre,
            self.ageRaiting];
}
@end
