//
//  JPVWordDetailViewController.m
//  JapaneseVerb
//
//  Created by BiXiaopeng on 14-6-1.
//  Copyright (c) 2014年 BiXiaopeng. All rights reserved.
//

#import "JPVWordDetailViewController.h"

@interface JPVWordDetailViewController ()

@end

@implementation JPVWordDetailViewController

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
    UITextView* text = [[UITextView alloc]init];
    text.frame = CGRectMake(10, 80, self.view.frame.size.width-20, self.view.frame.size.height-100);
    text.text = [self.word description];
    text.textAlignment = NSTextAlignmentLeft;
    text.editable=NO;
    
    UIButton *back = [[UIButton alloc]init];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    back.frame = CGRectMake(self.view.frame.size.width*0.7, self.view.frame.size.height*0.5, 66, 44);
    [back setTitleColor:[UIColor colorWithRed:((float) 24/ 255.0f)
                                       green:((float) 153/ 255.0f)
                                        blue:((float) 251/ 255.0f)
                                        alpha:1.0f] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backPushed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:text];
    [self.view addSubview:back];
}
-(void)backPushed{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
