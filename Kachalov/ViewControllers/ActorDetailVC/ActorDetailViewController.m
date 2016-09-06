//
//  ActorDetailViewController.m
//  Kachalov
//
//  Created by User on 02.09.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "ActorDetailViewController.h"
#import "ActorDetailParser.h"
#import "ActorDetailElement.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ActorDetailViewController ()

@property (nonatomic) UIView *navigationBarLine;

@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic) ActorDetailElement *actorElement;

@end

@implementation ActorDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDetails];

}

- (void)loadDetails
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.baseURL, self.detailURL];
    

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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.actorElement = [ActorDetailParser parseActorDerailFromString:htmlCodeString];
                [self reloadData];
            });
            
        }
    }];
    [self.dataTask resume];
}

- (void)reloadData
{
    self.textView.attributedText = [self attributedString];

    
    NSString *baseURL = @"http://www.teatrkachalov.ru";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, self.actorElement.imageURL];
    NSURL *url = [NSURL URLWithString:urlString];
    [self.imageView sd_setImageWithURL:url];
}

- (NSAttributedString *)attributedString
{
    NSMutableAttributedString *result = [NSMutableAttributedString new];
    UIFont *nameFont = [UIFont fontWithName:@"EngraversGothicBold" size:22.0];
    NSMutableParagraphStyle *nameParagraphStyle = [NSMutableParagraphStyle new];
    [nameParagraphStyle setAlignment:NSTextAlignmentCenter];
    NSString *nameString = [NSString stringWithFormat:@"%@\n\n", self.actorElement.name];
    NSAttributedString *name = [[NSAttributedString alloc] initWithString:nameString
                                                               attributes:@{NSFontAttributeName : nameFont,
                                                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                            NSParagraphStyleAttributeName : nameParagraphStyle}];
    
    UIFont *positionFont = [UIFont fontWithName:@"EngraversGothicBold" size:18.0];
    NSString *positionString = [NSString stringWithFormat:@"%@\n\n", self.actorElement.position];
    NSAttributedString *position = [[NSAttributedString alloc] initWithString:positionString attributes:@{NSFontAttributeName : positionFont,
                                                                                                                      NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIFont *textFont = [UIFont fontWithName:@"EngraversGothicBold" size:14.0];
    NSString *textString = self.actorElement.text;
    NSAttributedString *text = [[NSAttributedString alloc]initWithString:textString attributes:@{NSFontAttributeName : textFont,
                                                                                                 NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [result appendAttributedString:name];
    [result appendAttributedString:position];
    [result appendAttributedString:text];
    return result;
}

- (void)viewWillLayoutSubviews {
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0.0, navigationBarFrame.size.height - 1.0, navigationBarFrame.size.width, 1.0)];
    myview.backgroundColor = [UIColor whiteColor];
    [self.navigationBarLine removeFromSuperview];
    self.navigationBarLine = myview;
    [self.navigationController.navigationBar addSubview:myview];
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
