//
//  NewsListParser.m
//  Kachalov
//
//  Created by User on 25.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "NewsListParser.h"
#import "NewsListElement.h"
#import "HTMLKit.h"

@implementation NewsListParser

+ (NSArray *)parseFullPageFromString:(NSString *)htmlCode
{
    HTMLDocument *document = [HTMLDocument documentWithString:htmlCode];
    NSArray *newsHTMLElements = [document querySelectorAll:@".news_v1"];
    
    
    return [NewsListParser parseFromElementsList:newsHTMLElements];
}

+ (NSArray *)parsePaginationResponseFromString:(NSString *)htmlCode
{
    HTMLDocument *document = [HTMLDocument documentWithString:htmlCode];
    NSArray *newsHTMLElements = [document querySelectorAll:@".news_v1"];
    
    
    return [NewsListParser parseFromElementsList:newsHTMLElements];
}

+ (NSArray *)parseFromElementsList:(NSArray *)elementsList
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[elementsList count]];
    for (HTMLElement *el in elementsList){
        NewsListElement *element = [NewsListElement new];
        element.date = [[el querySelector:@".date"] textContent];
        NSString *text = [[el querySelector:@".text"] textContent];
        element.text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        element.imageURL = [el querySelectorAll:@"img"][1].attributes[@"src"];
        element.detailURL = [el querySelector:@"a"].attributes[@"href"];
        [result addObject:element];
    }
    return result;
}

+ (NSString *)parseNextPageLinkFromString:(NSString *)htmlCode
{
    HTMLDocument *document = [HTMLDocument documentWithString:htmlCode];
    HTMLElement *link = [document querySelector:@".ajax-pager-link"];
    NSString *result = link.attributes[@"href"];
    return result;
}
@end
