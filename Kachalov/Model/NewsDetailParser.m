//
//  NewsDetailParser.m
//  Kachalov
//
//  Created by User on 07.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "NewsDetailParser.h"
#import "HTMLKit.h"

@implementation NewsDetailParser

+ (NewsDetailElement *)parseNewsDetailFromString:(NSString *)htmlCode
{
//    NSLog(@"%@", htmlCode);
    NewsDetailElement *result = [NewsDetailElement new];
    
    HTMLDocument *document = [HTMLDocument documentWithString:htmlCode];
    
    result.title = [[document querySelector:@"title"] textContent];
    
    HTMLElement *announce = [document querySelector:@".new_announce"];
    NSString *announceString = [announce textContent];
    announceString = [announceString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    result.announce = announceString;
    
    [announce removeFromParentNode];
    
    NSString *textString = [[document querySelector:@".new_text"] textContent];
    textString = [textString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    result.text = textString;
    
    result.imageURLs = [NewsDetailParser parseImageURLsFromDocument:document];
    
    NSLog(@"%@", result);
    return result;
}

+ (NSArray *)parseImageURLsFromDocument:(HTMLDocument *)document
{
    
    NSMutableArray *result = [NSMutableArray new];
    
    HTMLElement *gallary = [document querySelector:@".news_gallary"];
    if (!gallary){
        return result;
    }
    
    HTMLElement *images = [gallary querySelector:@".images"];
    if (!images){
        [result addObject:[gallary querySelector:@"img"].attributes[@"src"]];
        return result;
    }
    
    NSArray *imagesList = [images querySelectorAll:@"img"];
    for (HTMLElement *el in imagesList){
        [result addObject:el.attributes[@"src"]];
    }
    
    return result;
}

@end
