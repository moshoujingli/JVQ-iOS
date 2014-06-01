//
//  JPVSearchViewController.m
//  JapaneseVerb
//
//  Created by BiXiaopeng on 14-6-1.
//  Copyright (c) 2014年 BiXiaopeng. All rights reserved.
//

#import "JPVSearchViewController.h"

@interface JPVSearchViewController ()

@property (strong,nonatomic)UISearchBar *searchBar;
@property (strong,nonatomic)UITableView *tableVIew;
@end

@implementation JPVSearchViewController

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    
    self.tableVIew = [[UITableView alloc]init];
    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableVIew];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    CGFloat outPadding = 10.0;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat searchBarHeight = screenHeight/10;
    CGRect searchBarFrame =  CGRectMake(outPadding, outPadding, screenHeight-2*outPadding, searchBarHeight);
    self.searchBar.frame = searchBarFrame;
    
    CGRect resultFrame = CGRectMake(outPadding*2+searchBarHeight, outPadding, screenWidth-2*outPadding, screenHeight-3*outPadding-searchBarHeight);
    self.tableVIew.frame = resultFrame;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
