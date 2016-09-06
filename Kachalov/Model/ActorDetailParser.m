//
//  ActorDetailParser.m
//  Kachalov
//
//  Created by User on 02.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "ActorDetailParser.h"
#import "HTMLKit.h"

@implementation ActorDetailParser

+ (ActorDetailElement *)parseActorDerailFromString:(NSString *)htmlCode
{
    ActorDetailElement *result = [ActorDetailElement new];
    
    HTMLDocument *document = [HTMLDocument documentWithString:htmlCode];
    HTMLElement *element = [document querySelector:@".persona"];
    result.imageURL = [element querySelector:@"img"].attributes[@"src"];
    HTMLElement *text = [element querySelector:@".text"];
    HTMLElement *name = [text querySelector:@".name"];
    HTMLElement *big = [text querySelector:@"big"];
    result.name = name.textContent;
    result.position = big.textContent;
    
    [name removeFromParentNode];
    [big removeFromParentNode];
    
    NSString *textContent = [[text textContent] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    result.text = textContent;
    return result;
}

@end
