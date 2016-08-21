//
//  FullAfficheParser.h
//  Kachalov
//
//  Created by User on 20.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FullAfficheParser : NSObject

@property (nonatomic) NSArray *largeSceneElements;
@property (nonatomic) NSArray *smallSceneElements;

- (void)parseWithData:(NSData *)data;
- (void)parseWithString:(NSString *)string;

@end
