//
//  NewsDetailParser.h
//  Kachalov
//
//  Created by User on 07.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailElement.h"

@interface NewsDetailParser : NSObject

+ (NewsDetailElement *)parseNewsDetailFromString:(NSString *)htmlCode;

@end
