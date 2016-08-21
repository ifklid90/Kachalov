//
//  FullAfficheParser.m
//  Kachalov
//
//  Created by User on 20.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "FullAfficheParser.h"
#import "HTMLKit.h"
#import "SmallAfficheElement.h"


@implementation FullAfficheParser

- (void)parseWithData:(NSData *)data
{
    NSString *htmlCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self parseWithString:htmlCode];
}

- (void)parseWithString:(NSString *)string {
    HTMLDocument *document = [HTMLDocument documentWithString:string];

    HTMLElement *affiche = [document querySelector:@".affiche"];
    
    __block NSUInteger headerCount = 0;
    NSMutableArray *largeSceneElements = [NSMutableArray new];
    NSMutableArray *smallSceneElements = [NSMutableArray new];
    
    [affiche enumerateChildElementsUsingBlock:^(HTMLElement * _Nonnull element, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([element.tagName isEqualToString:@"h2"]) {
            headerCount++;
            return;
        }
        
        if (headerCount <= 1) {
            [largeSceneElements addObject:element];
        } else {
            [smallSceneElements addObject:element];
        }
    }];
    
    self.largeSceneElements = [self parseAfficheEntitys:largeSceneElements];
    self.smallSceneElements = [self parseAfficheEntitys:smallSceneElements];

}

- (NSArray *)parseAfficheEntitys:(NSArray *)elements
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[elements count]];
    for (HTMLElement *el in elements){
        SmallAfficheElement *afficheElement = [SmallAfficheElement new];

        afficheElement.author = [[el querySelector:@".author"] textContent];
        afficheElement.name = [[el querySelector:@".name"] textContent];
        afficheElement.genre = [[el querySelector:@".genre"] textContent];
        afficheElement.ageRaiting = [[el querySelector:@".age_rating"] textContent];
        
        [result addObject:afficheElement];
    }
    
    return result;
}

@end
