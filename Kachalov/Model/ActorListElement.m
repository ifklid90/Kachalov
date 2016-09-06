//
//  ActorListElement.m
//  Kachalov
//
//  Created by User on 28.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "ActorListElement.h"

@implementation ActorListElement

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nname = %@;\nimageURl = %@;\ndetailURL = %@;\n",
            self.actorName,
            self.actorImageURL,
            self.detailURL];
}


@end
