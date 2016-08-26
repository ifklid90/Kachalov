//
//  FullAfficheTableViewController.m
//  Kachalov
//
//  Created by User on 19.08.16.
//  Copyright © 2016 Ayrat. All rights reserved.
//

#import "FullAfficheTableViewController.h"
#import "SmallAfficheCell.h"
#import "SmallAfficheElement.h"
#import "FullAfficheParser.h"

@interface FullAfficheTableViewController ()

@property (nonatomic) NSURLSession *defaultSession;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) NSArray *smallSceneElements;
@property (nonatomic) NSArray *largeSceneElements;

@property (nonatomic) NSArray *elementsSource;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;


@end

@implementation FullAfficheTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.estimatedRowHeight = 50;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:config];
    
    NSURL *url = [NSURL URLWithString:@"http://www.teatrkachalov.ru/spectacle/"];
    
    [self showActivityIndicator];
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator startAnimating];
            });
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSString *htmlCodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            FullAfficheParser *parser = [FullAfficheParser new];
            [parser parseWithString:htmlCodeString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
                [self showDataWithParser:parser];
            });
        }
    }];
    [self.dataTask resume];
}

- (void)showDataWithParser:(FullAfficheParser *)parser
{
    self.largeSceneElements = parser.largeSceneElements;
    self.smallSceneElements = parser.smallSceneElements;
    
    self.elementsSource = self.largeSceneElements;
    
    [self.table reloadData];
}

#pragma mark Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.elementsSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"SmallAfficheTableViewCell";
    SmallAfficheCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    SmallAfficheElement *element;

    element = self.elementsSource[indexPath.row];
    
    cell.authorTextLabel.text   = element.author;
    cell.nameTextLabel.text     = element.name;
    cell.genreTextLabel.text    = element.genre;
    cell.ageRatingLabel.text    = element.ageRaiting;
    
    return cell;
}
- (IBAction)sceneSegmentControlValueChanged:(id)sender {
    NSInteger sceneIndex = [sender selectedSegmentIndex];
    if (sceneIndex == 0){
        self.elementsSource = self.largeSceneElements;
    } else {
        self.elementsSource = self.smallSceneElements;
    }
    
    [self.table reloadData];
}

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
