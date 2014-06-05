//
//  JPVWordDetailViewController.h
//  JapaneseVerb
//
//  Created by BiXiaopeng on 14-6-1.
//  Copyright (c) 2014年 BiXiaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPVWordDB.h"
#import <iAd/iAd.h>


@interface JPVWordDetailViewController : UIViewController <ADBannerViewDelegate>
@property (strong,nonatomic)JPVWord* word;
@end
