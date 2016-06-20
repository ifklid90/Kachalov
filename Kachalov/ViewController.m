//
//  ViewController.m
//  Kachalov
//
//  Created by User on 17.06.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

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
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            });
            
        }
    }];
    [self.dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
