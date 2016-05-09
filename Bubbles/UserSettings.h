//
//  UserSettings.h
//  Bubbles
//
//  Created by Joao Victor Castelo on 7/05/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettings : NSObject


-(void)initSettings;
-(int)getTimesegment:(NSString*)time;
-(NSString*) getTimeSettings;
-(NSString*) getBubbluesSettings;
-(void) setBubbluesSettings: (NSString*) new_settings;
-(void) setTimeSettings: (NSString*) new_settings;


@end
