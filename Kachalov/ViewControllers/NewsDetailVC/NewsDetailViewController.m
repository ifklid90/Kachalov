//
//  NewsDetailViewController.m
//  Kachalov
//
//  Created by User on 07.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailParser.h"
#import "NewsDetailElement.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsDetailViewController ()

@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NewsDetailElement *newsElement;


@end

@implementation NewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData
{
    NSString *baseURL = @"http://www.teatrkachalov.ru";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, self.detailURL];
    NSLog(@"url = %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];
    [self.dataTask cancel];
    
    [self showActivityIndicator];
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
            });
            NSLog(@"%@", [error localizedDescription]);
        } else {
            
            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NewsDetailElement *element = [NewsDetailParser parseNewsDetailFromString:htmlCodeString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.newsElement = element;
                [self reloadData];
            });
            
        }
    }];
    [self.dataTask resume];
}

- (void)reloadData
{
    self.textView.attributedText = [self attributedString];
    if ([self.newsElement.imageURLs count] > 0){
        NSString *baseURL = @"http://www.teatrkachalov.ru";
        NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, self.newsElement.imageURLs[0]];
        NSURL *url = [NSURL URLWithString:urlString];
        [self.imageView sd_setImageWithURL:url];
    } else{
        self.imageView.hidden = YES;
    }
    
    
}

- (NSAttributedString *)attributedString
{
    NSMutableAttributedString *result = [NSMutableAttributedString new];
    UIFont *announceFont = [UIFont fontWithName:@"EngraversGothicBold" size:22.0];
//    NSMutableParagraphStyle *nameParagraphStyle = [NSMutableParagraphStyle new];
//    [nameParagraphStyle setAlignment:NSTextAlignmentCenter];
    NSString *announceString = [NSString stringWithFormat:@"%@\n\n", self.newsElement.announce];
    NSAttributedString *name = [[NSAttributedString alloc] initWithString:announceString
                                                               attributes:@{NSFontAttributeName : announceFont,
                                                                            NSForegroundColorAttributeName : [UIColor whiteColor]/*,
                                                                            NSParagraphStyleAttributeName : nameParagraphStyle*/}];
    
    UIFont *textFont = [UIFont fontWithName:@"EngraversGothicBold" size:14.0];
    NSString *textString = self.newsElement.text;
    NSAttributedString *position = [[NSAttributedString alloc] initWithString:textString attributes:@{NSFontAttributeName : textFont,
                                                                                                          NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    [result appendAttributedString:name];
    [result appendAttributedString:position];
    return result;
}

#pragma mark Activity Indicator
- (void)showActivityIndicator
{
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    self.activityIndicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    self.activityIndicator.center = self.view.center;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
}

@end
