//
//  ActorDetailParser.h
//  Kachalov
//
//  Created by User on 02.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActorDetailElement.h"

@interface ActorDetailParser : NSObject

+ (ActorDetailElement *)parseActorDerailFromString:(NSString *)htmlCode;

@end
