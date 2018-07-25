//
//  Storage.h
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#ifndef Storage_h
#define Storage_h

@class DBManager;

@interface Storage :NSObject

@property NSArray *supplies;

@property (nonatomic, strong) DBManager *dbManager;

-(void)loadData;

-(void)saveData;

-(NSString *)buy:(NSString *) selectedItem;

-(NSString *)sell:(NSString *) selectedItem;

-(NSString *)useItem:(NSString *) selectedItem;

@end

#endif /* Storage_h */

