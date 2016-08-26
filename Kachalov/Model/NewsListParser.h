//
//  NewsListParser.h
//  Kachalov
//
//  Created by User on 25.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListParser : NSObject

+ (NSArray *)parseFullPageFromString:(NSString *)htmlCode;
+ (NSArray *)parsePaginationResponseFromString:(NSString *)htmlCode;
+ (NSString *)parseNextPageLinkFromString:(NSString *)htmlCode;
@end
