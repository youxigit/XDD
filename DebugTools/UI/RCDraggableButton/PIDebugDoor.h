//
//  PIDebugDoor.h
//  WeGroup
//
//  Created by lilin on 15/3/19.
//  Copyright (c) 2015年 stack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonDef.h"

@interface PIDebugDoor : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImageView *maskView;
}

AS_SINGLETON(PIDebugDoor)

- (void)start;

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

@end
