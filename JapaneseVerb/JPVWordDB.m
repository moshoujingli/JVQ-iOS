//
//  JPVWordDB.m
//  JapaneseVerb
//
//  Created by BiXiaopeng on 14-6-1.
//  Copyright (c) 2014年 BiXiaopeng. All rights reserved.
//

#define WORD_SHELL @"all_word_base"
#define PREFIX_SHEEL @"prefix"

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
        self.map = [[NSMutableDictionary alloc]initWithCapacity:1000];
        self.kanaList = [[NSMutableArray alloc]initWithCapacity:400];
        self.KanaKanjiMap = [[NSMutableDictionary alloc]initWithCapacity:440];
        NSString* wordFilePath = [[NSBundle mainBundle] pathForResource:WORD_SHELL ofType:@"csv"];
        FILE *file = fopen([wordFilePath UTF8String], "r");
        char buffer[512];
        NSString *type;
        while (fgets(buffer, 512, file) != NULL){
            NSString* result = [NSString stringWithUTF8String:buffer];
            if ([result length]<2) {
                continue;
            }
            if (![result hasPrefix:@","]) {
                type=[result substringToIndex:4];
                result = [result substringFromIndex:4];
            }else{
                [self insertToMap:result ofType:type];
            }
        }
        fclose(file);
        
        NSString* prefixFilePath = [[NSBundle mainBundle] pathForResource:PREFIX_SHEEL ofType:@"dat"];
        file = fopen([prefixFilePath UTF8String], "r");
        while (fgets(buffer, 512, file) != NULL){
            NSString* result = [NSString stringWithUTF8String:buffer];
            NSArray* pair = [result componentsSeparatedByString:@" "];
            NSString *kana = pair[0];
            [self.kanaList addObject:kana];
            if (![self.KanaKanjiMap objectForKey:kana]) {
                NSMutableArray *kanjiList = [[NSMutableArray alloc]initWithCapacity:10];
                NSArray *kanjiSet = [pair[1] componentsSeparatedByString:@","];
                for (NSString* kanji in kanjiSet) {
                    if ([kanji length]>0) {
                        [kanjiList addObject:kanji];
                    }
                }
                [self.KanaKanjiMap setObject:kanjiList forKey:kana];
            }
        }
        fclose(file);
    }
    return self;
}

-(void)insertToMap:(NSString *)line ofType: (NSString *)type{
    line = [line substringFromIndex:2];
    NSArray *elems = [line componentsSeparatedByString:@","];
    NSString *baseType = elems[0];
    [self.map setObject:[[JPVWord alloc]initWithElem:elems andType:type] forKey:baseType];
}

-(NSArray *)getMatchedArrayByPrefix:(NSString *)prefix{
    NSArray *kanjis=@[prefix];
    NSMutableArray *matchWord = [[NSMutableArray alloc]initWithCapacity:20];
    if ([prefix length]) {
        if ([prefix length]>1&&[[self class]allInKana:prefix]) {
            NSArray *transToKanjiResult = [self transToKanji:prefix];
            if (transToKanjiResult) {
                kanjis=transToKanjiResult;
            }
        }
        
        for (NSString *prefixItem in kanjis) {
            [matchWord addObjectsFromArray:[self getMatchedArrayByKanji:prefixItem]];
        }
    }
    return matchWord;
}

+(BOOL)allInKana:(NSString *)prefix{
    for (NSInteger i=[prefix length]-1; i>=0; i--) {
        int key = [prefix characterAtIndex:i];
        if (key<0x3040||key>0x30ff) {
            return NO;
        }
    }
    return YES;
}

-(NSArray *)getMatchedArrayByKanji:(NSString *)kanji{
    NSArray *baseType = [self.map allKeys];
    NSMutableArray *list = [[NSMutableArray alloc]initWithCapacity:10];
    for (NSString* key in baseType) {
        if ([key hasPrefix:kanji]) {
            [list addObject:key];
        }
    }
    if (self.needConcessionRecognize &&[list count]==0&&[kanji length]>1) {
        return [self getMatchedArrayByKanji:[kanji substringToIndex:1]];
    }
    return list;
}


@end
