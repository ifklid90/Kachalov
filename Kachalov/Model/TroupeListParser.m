//
//  TroupeListParser.m
//  Kachalov
//
//  Created by User on 28.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "TroupeListParser.h"
#import "HTMLKit.h"
#import "ActorListElement.h"

@implementation TroupeListParser

+ (NSArray *)parseTroupeListFromString:(NSString *)htmlCode
{
    HTMLDocument *document = [HTMLDocument documentWithString:htmlCode];
    NSArray *actorHTMLElements = [document querySelectorAll:@".actor"];
    
    return  [TroupeListParser parseFromElementsList:actorHTMLElements];
}

+ (NSString *)parseNextPageLinkFromString:(NSString *)htmlCode
{
    HTMLDocument *document = [HTMLDocument documentWithString:htmlCode];
    HTMLElement *link = [document querySelector:@".ajax-pager-link"];
    NSString *result = link.attributes[@"href"];
    return result;
}

+ (NSArray *)parseFromElementsList:(NSArray *)elementsList
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[elementsList count]];
    for (HTMLElement *el in elementsList){
        ActorListElement *element = [ActorListElement new];
        element.actorName = [[[el querySelector:@".name"] textContent] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        element.actorImageURL = [el querySelectorAll:@"img"][1].attributes[@"src"];
        [result addObject:element];
    }
    return result;
}


@end
