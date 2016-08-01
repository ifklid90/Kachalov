//
//  ViewController.m
//  Kachalov
//
//  Created by User on 17.06.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "ViewController.h"
#import "SmallAfficheElement.h"
#import "SmallAfficheParser.h"

@interface ViewController ()
@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) NSArray *smallSceneMonths;
@property (nonatomic) NSArray *largeSceneMonths;

@property (nonatomic) NSArray *smallSceneElementsByMonths;
@property (nonatomic) NSArray *largeSceneElementsByMonths;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    if (self.dataTask != nil) {
//        [self.dataTask cancel];
//    }
    
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.teatrkachalov.ru"];
    
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"%@", [error localizedDescription]);
        } else {

            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            SmallAfficheParser *parser = [SmallAfficheParser new];
            [parser parseWithString:htmlCodeString];
//            HTMLDocument *document = [HTMLDocument documentWithString:htmlCodeString];
//            NSArray *affiches =  [document querySelectorAll:@".affiche"];
//            if ([affiches count] == 2){
//                NSLog(@"evrything is ok. there is only 2 affiches");
//            } else{
//                NSLog(@"something is wrong. there is not 2 affiches (more ore less)");
//            }
//            HTMLElement *bigSceneAffiche = affiches[0];
//            HTMLElement *smallSceneAffiche = affiches[1];
//            NSArray *bigSceneMonths = [bigSceneAffiche querySelectorAll:@".aff_month"];
//            for (HTMLElement *month in bigSceneMonths){
//                NSLog(@"========================================%@========================================", [month objectForKeyedSubscript:@"data-month-name"]);
//                NSArray *bigSceneElements = [month querySelectorAll:@".aff_el"];
//                for (HTMLElement *el in bigSceneElements){
//                    SmallAfficheElement *afficheElement = [SmallAfficheElement new];
//
//                    afficheElement.date = [[el querySelector:@".date"] textContent];
//                    afficheElement.day = [[el querySelector:@".day"] textContent];
//                    afficheElement.premiere = [[el querySelector:@".premiere"] textContent];
//                    afficheElement.author = [[el querySelector:@".author"] textContent];
//                    afficheElement.name = [[el querySelector:@".name"] textContent];
//                    afficheElement.genre = [[el querySelector:@".genre"] textContent];
//                    afficheElement.ageRaiting = [[el querySelector:@".age_rating"] textContent];
//
//                    NSLog(@"%@", afficheElement);
//                }
//            }

        }
    }];
    [self.dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDataWithParser:(SmallAfficheParser *)parser
{
    self.smallSceneMonths = parser.smallSceneMonths;
    self.largeSceneMonths = parser.largeSceneMonths;

    self.smallSceneElementsByMonths = parser.smallSceneElementsByMonths;
    self.largeSceneElementsByMonths = parser.largeSceneElementsByMonths;
}

@end
