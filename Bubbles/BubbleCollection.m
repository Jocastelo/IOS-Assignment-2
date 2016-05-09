//
//  BubbleCollection.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 25/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "BubbleCollection.h"




@interface BubbleCollection()
@property (nonatomic)NSMutableArray* myBubbles;

@end

@implementation BubbleCollection

-(NSMutableArray*) myBubbles{
    if(!_myBubbles)
        _myBubbles = [NSMutableArray init];
    return _myBubbles;
}

-(instancetype) initWithBubbles: (int) maxBubble withFrameX: (float) Max_widht withFrameY: (float) Max_height{
    //NSMutableArray * myBubbles = [[NSMutableArray alloc] init];
    for(int i =0; i < maxBubble; i++){
        Bubble* new_bubble = [Bubble createRandomBubble:Max_widht withFrame_Height:Max_height];
        if([BubbleCollection isOverlapping:new_bubble CompareInArray:self.myBubbles])
            i--;
        else
            [self.myBubbles addObject: new_bubble];
    }
    [BubbleCollection sendNotificantion:@"ADD_BUBBLES" withObj:self.myBubbles];
    return self;
}

/*Function isOverlapping 
 *Input: Bubble and MutableArray
 *Output: True if bubble overlap with other in array. False otherwise
 */

+(BOOL)isOverlapping: (Bubble *) new_bubble CompareInArray: (NSMutableArray *) bubbles_array{
    if([bubbles_array count] == 0){
        return false;
    }
    else{
        Bubble* b;
        for(int i = 0; i < [bubbles_array count]; i++){
            b = [bubbles_array objectAtIndex:i];
            if(( (new_bubble.position_x < (b.position_x+widthBubble))) && (new_bubble.position_x > (b.position_x-widthBubble))){
                if((int) new_bubble.position_y < (int) (b.position_y+heightBubble) && (int) new_bubble.position_y > (int) (b.position_y-heightBubble)){;
                    return true;
                }
            }
        }
    }
    return false;
}


/*Function CreateBubbles
 *Input: Maximo number of bubbles in the screen, Frame size (widht and height)
 *Output: Array of bubbles
 */
+(NSMutableArray*)CreateBubbles: (int) maxBubble withFrameX: (float) Max_widht withFrameY: (float) Max_height{
    NSMutableArray * myBubbles = [[NSMutableArray alloc] init];
    for(int i =0; i < maxBubble; i++){
        Bubble* new_bubble = [Bubble createRandomBubble:Max_widht withFrame_Height: Max_height];
        if([BubbleCollection isOverlapping:new_bubble CompareInArray:myBubbles])// if new_bubble overlap, other bubble will be generate for the position
            i--;
        else
        [myBubbles addObject: new_bubble];
    }
    [BubbleCollection sendNotificantion:@"ADD_BUBBLES" withObj:myBubbles];
    return myBubbles;
}


/*Function sendNotification
 *Input: type of notification and NSObject
 *Description: Warning the Gamecontroller about changes in the GUI.
 */

+(void)sendNotificantion: (NSString*) type_notification withObj: (NSObject*) obj{
    [[NSNotificationCenter defaultCenter] postNotificationName:type_notification object:obj];
}


/*Function ChangeBubbles
 *Input: Array of bubble, max bubbles, frame size
 *Description: Delete and add bubbles aleatory in the array and notify the controller
 */

+(void)ChangeBubbles: (NSMutableArray *) bubbles withMAXBubbles: (int) maxbubbles withFramewidht: (float) Max_widht withFrameheight: (float) Max_height{
    NSMutableArray* new_array = [[NSMutableArray alloc] init];
    if([bubbles count] != 0){
       int bubbles_to_clear = [Bubble randomNumberBetween:1 and:(int)[bubbles count]/2 +1];
       int index_array;
       for(int i =0; i < bubbles_to_clear; i++){
           index_array = [Bubble randomNumberBetween:0 and:(int) [bubbles count]-1];
           bubbles = [BubbleCollection RemoveBubbles:(Bubble *) bubbles[index_array] in:bubbles];
       }
    }
    
    // Add Bubbles
    int number_bubbles = [Bubble randomNumberBetween:1 and:maxbubbles - (int)[bubbles count]];
    for(int i =0; i < number_bubbles; i++){
        Bubble* new_bubble = [Bubble createRandomBubble:Max_widht withFrame_Height: Max_height];
        if([BubbleCollection isOverlapping:new_bubble CompareInArray:bubbles])
            i--;
        else{
            [bubbles addObject: new_bubble]; // Add new bubbles in the bubbles array
            [new_array addObject:new_bubble];
        }
    }
    [BubbleCollection sendNotificantion:@"ADD_BUBBLES" withObj:new_array]; // send the array content only the new bubbles.
    
}

/*Function RemoveBubbles
 *Input: bubble and Array of bubbles
 *Output: delete bubbles aleatory and send a new array of bubbles.
 */
+(NSMutableArray*) RemoveBubbles: (Bubble *) bubble in: (NSMutableArray *) my_array{
    [my_array removeObjectIdenticalTo: bubble];
    [BubbleCollection sendNotificantion:@"REMOVE_BUBBLE" withObj:bubble];
    return my_array;
}


@end
