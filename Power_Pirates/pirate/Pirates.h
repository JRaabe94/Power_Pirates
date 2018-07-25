//
//  Pirates.h
//  Power_Pirates
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#ifndef Pirates_h
#define Pirates_h

@interface Pirates : NSObject

@property NSString *name;

@property int lifes;

@property int level;

@property int alcoholLevel;

-(void)loadData;

-(void)saveData;

@end

#endif /* Pirates_h */
