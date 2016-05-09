//
//  UserSettings.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 7/05/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings

-(void)initSettings{
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"settings_time"] == nil){
        [[NSUserDefaults standardUserDefaults] setValue:@"60" forKey:@"settings_time"];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"settings_bubbles"] == nil){
        [[NSUserDefaults standardUserDefaults] setValue:@"15" forKey:@"settings_bubbles"];
    }
    
}

/* Return the segment of timer's segement control*/
-(int)getTimesegment: (NSString*)time{
    
    int segment_time = 0;
    
    if([time isEqualToString:@"60"]){
        segment_time = 0;
    }
    if([time isEqualToString:@"45"]){
        segment_time = 1;
    }
    if([time isEqualToString:@"30"]){
        segment_time = 2;
    }
    if([time isEqualToString:@"15"]){
        segment_time = 3;
    }
    
    return segment_time;
}

-(NSString*) getTimeSettings{
    NSString* time = [[NSUserDefaults standardUserDefaults] valueForKey:@"settings_time"];
    return time;
}

-(NSString*) getBubbluesSettings{
    NSString* num_bubbles = [[NSUserDefaults standardUserDefaults] valueForKey:@"settings_bubbles"];
    return num_bubbles;
}

-(void) setBubbluesSettings: (NSString*) new_settings{
    [[NSUserDefaults standardUserDefaults] setValue:new_settings forKey:@"settings_bubbles"];
}

-(void) setTimeSettings: (NSString*) new_settings{
    [[NSUserDefaults standardUserDefaults] setValue:new_settings forKey:@"settings_time"];
}






@end
