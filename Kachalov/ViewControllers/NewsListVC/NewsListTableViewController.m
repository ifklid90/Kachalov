//
//  NewsListTableViewController.m
//  Kachalov
//
//  Created by User on 24.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "NewsListTableViewController.h"
#import "NewsShortCell.h"
#import "NewsListParser.h"
#import "NewsListElement.h"
#import "LoadingCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsListTableViewController ()

@property (nonatomic) UIView *navigationBarLine;

@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) NSMutableArray *newsList;
@property (nonatomic) NSString *nextPageURL;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation NewsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor blackColor];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.teatrkachalov.ru/news"];
    [self showActivityIndicator];
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
            });
            NSLog(@"%@", [error localizedDescription]);
        } else {
            
            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *elements = [NewsListParser parseFullPageFromString:htmlCodeString];
            NSString *nextLink = [NewsListParser parseNextPageLinkFromString:htmlCodeString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                self.nextPageURL = nextLink;
                self.newsList = [elements mutableCopy];
                

                [self.tableView reloadData];
            });
            
        }
    }];
    [self.dataTask resume];
}

- (void)viewWillLayoutSubviews {
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0.0, navigationBarFrame.size.height - 1.0, navigationBarFrame.size.width, 1.0)];
    myview.backgroundColor = [UIColor whiteColor];
    [self.navigationBarLine removeFromSuperview];
    self.navigationBarLine = myview;
    [self.navigationController.navigationBar addSubview:myview];
}

#pragma mark Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.nextPageURL){
        return [self.newsList count] + 1;
    } else {
        return [self.newsList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.newsList.count){
        return [self tableView:tableView newsElementCellForIndexPath:indexPath];
    } else {
        return [self loadingCell];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView newsElementCellForIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"ShortNewsCell";
    NewsShortCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NewsListElement *element = self.newsList[indexPath.row];
    
    cell.dateLabel.text = element.date;
    cell.newsTextLabel.text = element.text;
    
    NSMutableString *URLstring = [NSMutableString stringWithString: @"http://www.teatrkachalov.ru"];
    [URLstring appendString:element.imageURL];
    NSURL *url = [NSURL URLWithString:URLstring];
    [cell.newsImage sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone){
            cell.newsImage.alpha = 0.0;
            [UIView animateWithDuration:1.0
                             animations:^{
                                 cell.newsImage.alpha = 1.0;
                             }];
        }
    }];
    return cell;
}

- (UITableViewCell *)loadingCell {
    
    NSString *cellId = @"LoadingCell";
    LoadingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    [cell.activityIndicator startAnimating];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.newsList.count){
        return 155.0;
    } else {
        return 44.0;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == [self.newsList count] - 2 && self.nextPageURL) {
        NSString *next = [NSString stringWithFormat:@"http://www.teatrkachalov.ru%@", self.nextPageURL];
        NSURL *url = [NSURL URLWithString:next];
        [self.dataTask cancel];
        self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", [error localizedDescription]);
            } else {
                NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSArray *result = [NewsListParser parsePaginationResponseFromString:htmlCodeString];
                NSString *parsedNextLink = [NewsListParser parseNextPageLinkFromString:htmlCodeString];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.newsList addObjectsFromArray:result];
                    self.nextPageURL = parsedNextLink;
                    [self.tableView reloadData];
                });
                
            }
        }];
        [self.dataTask resume];
    }
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


