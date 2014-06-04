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
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIButton *checkBox;
@property (strong,nonatomic)NSArray *matchedWord;
@property (assign)CGFloat tableHeight;
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
        [JPVWordDB shareWordDB];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.matchedWord = @[];
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor=[UIColor blackColor];
    
    self.checkBox = [[UIButton alloc]init];
    
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 键盘高度变化通知，ios5.0新增的
    #ifdef __IPHONE_5_0
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version >= 5.0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        }
    #endif
    
    CGFloat outPadding = 10.0;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat searchBarHeight = screenHeight/10;
    CGRect searchBarFrame =  CGRectMake(outPadding, 30+outPadding, screenWidth-2*outPadding, searchBarHeight);
    self.searchBar.frame = searchBarFrame;
    
    CGRect resultFrame = CGRectMake(outPadding,30+outPadding*2+searchBarHeight, screenWidth-2*outPadding, screenHeight-3*outPadding-searchBarHeight-30);
    self.tableHeight = resultFrame.size.height;
    self.tableView.frame = resultFrame;
}

-(void)checkBoxChanged:(UIButton *)sender{
    [JPVWordDB shareWordDB].needConcessionRecognize = sender.isSelected;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    NSLog(@"rela");

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.matchedWord = [[JPVWordDB shareWordDB] getMatchedArrayByPrefix:searchText];
    [self.tableView reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.matchedWord count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL_IDENTIFIER = @"cif";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_IDENTIFIER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [self.matchedWord objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [self moveTableviewWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveTableviewWithKeyboardHeight:0.0 withDuration:animationDuration];
}

-(void)moveTableviewWithKeyboardHeight:(CGFloat)height withDuration:(NSTimeInterval)duration{
    NSLog(@"dasd    ");
        CGRect curFrame =  self.tableView.frame;
        curFrame.size.height = self.tableHeight - height*1.5;
        [self.tableView setFrame:CGRectMake(curFrame.origin.x, curFrame.origin.y, curFrame.size.width, self.tableHeight - height*1.03)];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

