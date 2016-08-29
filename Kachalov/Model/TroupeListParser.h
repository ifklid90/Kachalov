//
//  TroupeListParser.h
//  Kachalov
//
//  Created by User on 28.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TroupeListParser : NSObject

+ (NSArray *)parseTroupeListFromString:(NSString *)htmlCode;
+ (NSString *)parseNextPageLinkFromString:(NSString *)htmlCode;

@end
