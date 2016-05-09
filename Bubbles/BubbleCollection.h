//
//  BubbleCollection.h
//  Bubbles
//
//  Created by Joao Victor Castelo on 25/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bubble.h"


@interface BubbleCollection : NSObject

//-(instancetype) initWithBubbles:
+(NSMutableArray*)CreateBubbles: (int) maxBubble withFrameX: (float) Max_widht withFrameY: (float) Max_height;
+(NSMutableArray*) RemoveBubbles: (Bubble *) bubble in: (NSMutableArray *) my_array;
+(void)PrintArray: (NSArray *) myArray;
+(void)ChangeBubbles:(NSMutableArray *) bubbles withMAXBubbles: (int) maxbubbles withFramewidht: (float) Max_widht withFrameheight: (float) Max_height;
-(instancetype) initWithBubbles: (int) maxBubble withFrameX: (float) Max_widht withFrameY: (float) Max_height;
@end
