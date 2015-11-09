//
//  TestModel.m
//  
//
//  Created by Maciej Matuszewski on 09.11.2015.
//
//

#import "TestModel.h"

@implementation TestModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description": @"descriptionString"}];
}

@end
