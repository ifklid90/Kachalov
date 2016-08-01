//
// SmallAfficheParser
//
//  Created by user on 26.06.16.
//
#import "SmallAfficheParser.h"
#import "HTMLKit.h"
#import "SmallAfficheElement.h"

@interface SmallAfficheParser ()
@end

@implementation SmallAfficheParser

- (void)parseWithData:(NSData *)data
{
    NSString *htmlCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self parseWithString:htmlCode];
}

- (void)parseWithString:(NSString *)string
{
    HTMLDocument *document = [HTMLDocument documentWithString:string];
    NSArray *affiches =  [document querySelectorAll:@".affiche"];

//    if ([affiches count] == 2){
//        NSLog(@"evrything is ok. there is only 2 affiches");
//    } else{
//        NSLog(@"something is wrong. there is not 2 affiches (more ore less)");
//    }

    HTMLElement *largeSceneAffiche = affiches[0];
    HTMLElement *smallSceneAffiche = affiches[1];
//    NSArray *largeSceneMonths = [largeSceneAffiche querySelectorAll:@".aff_month"];
    NSArray *smallSceneMonths = [self parseMonthsFromAffiche:smallSceneAffiche];
    NSArray *largeSceneMonths = [self parseMonthsFromAffiche:largeSceneAffiche];

    self.smallSceneMonths = [self parseMonthStringsFromElements:smallSceneMonths];
    self.largeSceneMonths = [self parseMonthStringsFromElements:largeSceneMonths];
//
//    NSLog(@"small scene months = %@", self.smallSceneMonths);
//    for (NSString *el in self.smallSceneMonths){
//        NSLog(@"%@", el);
//    }
//    NSLog(@"large scene months = %@", self.largeSceneMonths);
//    for (NSString *el in self.largeSceneMonths){
//        NSLog(@"%@", el);
//    }

    self.smallSceneElementsByMonths = [self parseAfficheEntitysByMonthsFromElements:smallSceneMonths];
//    NSLog(@"Small Eements By Months");
//    [self logList:self.smallSceneElementsByMonths withMonthsList:self.smallSceneMonths];
    self.largeSceneElementsByMonths = [self parseAfficheEntitysByMonthsFromElements:largeSceneMonths];
//    NSLog(@"Large Elements By Months");
//    [self logList:self.largeSceneElementsByMonths withMonthsList:self.largeSceneMonths];

}

- (NSArray *)parseMonthsFromAffiche:(HTMLElement *)element
{
    return [element querySelectorAll:@".aff_month"];
}

- (NSArray *)parseMonthStringsFromElements:(NSArray *)elements
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[elements count]];
    for (HTMLElement *el in elements) {
        [result addObject:[el objectForKeyedSubscript:@"data-month-name"]];
    }
    return result;
}

- (NSArray *)parseAfficheEntitysByMonthsFromElements:(NSArray *)elements
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[elements count]];
    for (HTMLElement *month in elements){
        NSArray *monthElements = [month querySelectorAll:@".aff_el"];
        NSMutableArray *monthResult = [NSMutableArray arrayWithCapacity:[monthElements count]];
        for (HTMLElement *el in monthElements){
            SmallAfficheElement *afficheElement = [SmallAfficheElement new];

            afficheElement.date = [[el querySelector:@".date"] textContent];
            afficheElement.day = [[el querySelector:@".day"] textContent];
            afficheElement.premiere = [[el querySelector:@".premiere"] textContent];
            afficheElement.author = [[el querySelector:@".author"] textContent];
            afficheElement.name = [[el querySelector:@".name"] textContent];
            afficheElement.genre = [[el querySelector:@".genre"] textContent];
            afficheElement.ageRaiting = [[el querySelector:@".age_rating"] textContent];

            [monthResult addObject:afficheElement];
        }

        [result addObject:monthResult];
    }

    return result;
}

- (void)logList:(NSArray *)array withMonthsList:(NSArray *)monts{
    if ([array count] == [monts count]){
        NSLog(@"OK there is equal number of months on both lists");
    } else {
        NSLog(@"ERR there is NOT equal number of months on lists");
    }

    for (NSUInteger i = 0; i < [monts count]; i++){
        NSLog(@"%@", monts[i]);
        for (NSUInteger j = 0; j < [array[i] count]; j++){
            NSLog(@"%@ %@", monts[i], array[i][j]);
        }
    }
}

@end