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

-(NSString *)buy:(int) selectedItem;

-(NSString *)sell:(int) selectedItem;

-(NSString *)useItem:(int) selectedItem;

-(void)update:(int)selectedItem amount:(int)amount;

@end

#endif /* Storage_h */

