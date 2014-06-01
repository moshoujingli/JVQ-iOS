//
//  JPVWordDB.m
//  JapaneseVerb
//
//  Created by BiXiaopeng on 14-6-1.
//  Copyright (c) 2014年 BiXiaopeng. All rights reserved.
//

#define WORD_SHELL @"all_word_base.csv"
#define PREFIX_SHEEL @"prefix.dat"

#import "JPVWordDB.h"

@interface JPVWordDB()

@property (nonatomic,strong)NSMutableDictionary* map;
@property (nonatomic,strong)NSMutableArray* kanaList;
@property (nonatomic,strong)NSMutableDictionary *KanaKanjiMap;

@end

@implementation JPVWordDB

+(instancetype)shareWordDB{
    static id _shareWordDB=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(){
        _shareWordDB = [[self alloc]init];
    });
    return _shareWordDB;
}

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}


@end
