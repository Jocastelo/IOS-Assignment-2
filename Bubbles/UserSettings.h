//
//  UserSettings.h
//  Bubbles
//
//  Created by Joao Victor Castelo on 7/05/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettings : NSObject

+(int)getTimesegment:(NSString*)time;
-(void)initSettings;
@end
