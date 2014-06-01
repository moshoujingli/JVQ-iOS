//
//  JPVWordDB.h
//  JapaneseVerb
//
//  Created by BiXiaopeng on 14-6-1.
//  Copyright (c) 2014年 BiXiaopeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPVWord.h"

@interface JPVWordDB : NSObject
@property (assign,nonatomic)BOOL needConcessionRecognize;


-(NSArray *)getMatchedArrayByPrefix:(NSString *)prefix;
-(JPVWord *)getWordDetail:(NSString *)wordName;
-(NSArray *)transToKanji:(NSString *)prefix;

+(BOOL)allInKana:(NSString *)prefix;
+(instancetype)shareWordDB;
@end
