//
// SmallAfficheParser
//
//  Created by user on 26.06.16.
//

#import <Foundation/Foundation.h>

@interface SmallAfficheParser : NSObject
@property (nonatomic) NSArray *smallSceneMonths;
@property (nonatomic) NSArray *largeSceneMonths;
@property (nonatomic) NSArray *smallSceneElementsByMonths;
@property (nonatomic) NSArray *largeSceneElementsByMonths;

- (void)parseWithData:(NSData *)data;
- (void)parseWithString:(NSString *)string;
@end