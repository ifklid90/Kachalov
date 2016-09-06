//
//  ActorDetailElement.m
//  Kachalov
//
//  Created by User on 02.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "ActorDetailElement.h"

@implementation ActorDetailElement

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nname = %@;\nimageURl = %@;\nposition = %@;\ntext = %@\n",
            self.name,
            self.imageURL,
            self.position,
            self.text];
}

@end
