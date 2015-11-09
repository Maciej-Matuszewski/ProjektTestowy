//
//  TestModel.h
//  
//
//  Created by Maciej Matuszewski on 09.11.2015.
//
//

#import <JSONModel/JSONModel.h>

@interface TestModel : JSONModel

@property (assign, nonatomic) BOOL activated;

@property (assign, nonatomic) BOOL deleted;

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* descriptionString;

@property (strong, nonatomic) NSNumber* id;

@property (strong, nonatomic) NSString* main_photo;

@property (strong, nonatomic) NSNumber* order;

@property (strong, nonatomic) NSString* path_color;

@end
