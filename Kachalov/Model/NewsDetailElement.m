//
//  NewsDetailElement.m
//  Kachalov
//
//  Created by User on 07.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "NewsDetailElement.h"

@implementation NewsDetailElement

- (NSString *)description
{
    return [NSString stringWithFormat:@"\ntitle = %@;\nimageURLs = %@;\nannounce = %@;\ntext = %@\n",
            self.title,
            self.imageURLs,
            self.announce,
            self.text];
}

@end
