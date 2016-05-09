//
//  Bubble.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 24/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "Bubble.h"

@implementation Bubble

-(Bubble *) initBubble:(NSString *)type with:(short)point withX: (float) position_X withY: (float) posistion_Y{
    self = [super init];
    if(self){
        _typeBubble = type;
        _pointBubble = point;
        _position_x = position_X;
        _position_y = posistion_Y;

        if([_typeBubble compare: @"Black"] == NSOrderedSame){
            [self setImage:[UIImage imageNamed:@"black_bubble.png"] forState:UIControlStateNormal];
        }
        
        else if([_typeBubble compare: @"Blue"] == NSOrderedSame){
            [self setImage:[UIImage imageNamed:@"blue_bubble.png"] forState:UIControlStateNormal];
        }
        
        else if([_typeBubble compare: @"Green"] == NSOrderedSame){
            [self setImage:[UIImage imageNamed:@"green_bubble.png"] forState:UIControlStateNormal];
        }
        
        else if([_typeBubble compare: @"Pink"] == NSOrderedSame){
            [self setImage:[UIImage imageNamed:@"pink_bubble.png"] forState:UIControlStateNormal];
        }
        
        else{
            [self setImage:[UIImage imageNamed:@"red_bubble.png"] forState:UIControlStateNormal];
        }
        
    }
    return self;
}

/*
 Create a random Bubble with a random position
*/
+(float) randomNumberBetween: (int) min and: (int) max{
    float random_number = (float) (min + arc4random_uniform(max));
    return random_number;
}
+(Bubble *) createRandomBubble: (float) Frame_widht withFrame_Height: (float) Frame_height{
    int random_number = (arc4random() % 100) + 1;
    float random_posX = (float) ((arc4random() % (int)(Frame_widht - 1.5*widthBubble)));
    //float random_posY = (float) (50 + arc4random_uniform(Max_height-110));
    //float random_posX = [Bubble randomNumberBetween:0 and:(int)(Max_height - 1.5*widthBubble)];
    float random_posY = [Bubble randomNumberBetween:50 and:Frame_height-120];
    
    
    Bubble* mybubble;
    
    if(random_number <= 5)
        mybubble = [[Bubble alloc] initBubble:@"Black" with: 10 withX:random_posX withY:random_posY];
    
    else if(random_number <= 15)
        mybubble = [[Bubble alloc] initBubble:@"Blue" with: 8 withX:random_posX withY:random_posY];
    
    else if(random_number <= 30)
        mybubble = [[Bubble alloc] initBubble:@"Green" with: 5 withX:random_posX withY:random_posY];
    
    else if(random_number <= 60)
        mybubble = [[Bubble alloc] initBubble:@"Pink" with: 2 withX:random_posX withY:random_posY];
    
    else if(random_number <= 100)
        mybubble = [[Bubble alloc] initBubble:@"Red" with: 1 withX:random_posX withY:random_posY];
    
    return mybubble;
}



@end
