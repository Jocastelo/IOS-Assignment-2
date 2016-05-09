//
//  User.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 8/05/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype) initUser{
    self = [super init];
    
    if(self){
        self.username = @"";
        self.userscore = 0;
        return self;
    }
    return self;
}

@end
