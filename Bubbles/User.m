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

+(instancetype) initUserWith:(NSString*) name andScore: (NSString*) score{
    User* user = [[User alloc] init];
    
    if(user){
        user.username = name;
        user.userscore = score;
        return user;
    }
    return user;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.username forKey:@"Name"];
    [aCoder encodeObject:self.userscore forKey:@"Score"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    _username = [decoder decodeObjectForKey:@"Name"];
    _userscore = [decoder decodeObjectForKey:@"Score"];
    return self;
}

- (void)saveData {
    
    NSString *dataPath = @"record.plist";
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.username forKey:@"Name"];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
    
    
}

@end
