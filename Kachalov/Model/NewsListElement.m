//
//  NewsListElement.m
//  Kachalov
//
//  Created by User on 25.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "NewsListElement.h"

@implementation NewsListElement
- (NSString *)description
{
    return [NSString stringWithFormat:@"\ndate = %@;\ntext = %@;\nimageURL = %@;\ndetailURL = %@",
            self.date,
            self.text,
            self.imageURL,
            self.detailURL];
}
@end
