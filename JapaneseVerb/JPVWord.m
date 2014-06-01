//
//  JPVWord.m
//  JapaneseVerb
//
//  Created by BiXiaopeng on 14-6-1.
//  Copyright (c) 2014年 BiXiaopeng. All rights reserved.
//

#import "JPVWord.h"

@interface JPVWord()

@property (nonatomic)NSString *desc;

@property (nonatomic)NSArray *elements;
@property (nonatomic)NSString *type;

@end

@implementation JPVWord

-(id)initWithElem:(NSArray *)elements andType:(NSString *)type{
    if (self=[super init]) {
        self.elements = elements;
        self.type = type;
    }
    return self;
}

-(NSString *)desc{
    if (_desc==nil) {
        NSString *format = @"类型:%@\n中文:%@\n基本形:%@\nます形:%@\nて　形:%@\nない形:%@\nた　形:%@\n命令形:%@\n意志形:%@\nば　形:%1@\n可能形:%@\n被动形:%@\n使役形:%@";
        _desc = [NSString stringWithFormat:format, self.type,
                 self.elements[1], self.elements[0], self.elements[2], self.elements[3],
                 self.elements[4], self.elements[5], self.elements[6], self.elements[7],
                 self.elements[8], self.elements[9], self.elements[10], self.elements[11]];
    }
    return  _desc;
}

-(NSString *)description{
    
    return self.desc;
}
@end
