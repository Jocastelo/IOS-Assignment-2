//
//  UserSettings.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 7/05/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings

-(int) getBubbluesSettings{
    NSString* num_bubbles = [[NSUserDefaults standardUserDefaults] valueForKey:@"settings_bubbles"];
    int bubbles_settings = (int)[num_bubbles integerValue];
    return bubbles_settings;
}

-(int) getTimeSettings{
    NSString* time = [[NSUserDefaults standardUserDefaults] valueForKey:@"settings_time"];
    int time_settings = (int)[time integerValue];
    return time_settings;
}

-(void) setBubbluesSettings: (int) new_settings{
    NSString* num_bubbles;
    num_bubbles = [NSString stringWithFormat:@"%i", new_settings];
    [[NSUserDefaults standardUserDefaults] setValue:num_bubbles forKey:@"settings_bubbles"];
}

-(void) setTimeSettings: (int) new_settings{
    NSString* time;
    time = [NSString stringWithFormat:@"%i", new_settings];
    [[NSUserDefaults standardUserDefaults] setValue:time forKey:@"settings_time"];
}

-(void)initSettings{
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"settings_time"] == nil){
        [[NSUserDefaults standardUserDefaults] setValue:@"60" forKey:@"settings_time"];
        
    }
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"settings_bubbles"] == nil){
        [[NSUserDefaults standardUserDefaults] setValue:@"15" forKey:@"settings_bubbles"];
    }
    
}

+(int)getTimesegment: (NSString*)time{
    
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


@end
