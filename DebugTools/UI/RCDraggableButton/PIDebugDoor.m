//
//  PIDebugDoor.m
//  WeGroup
//
//  Created by lilin on 15/3/19.
//  Copyright (c) 2015年 stack. All rights reserved.
//

#import "PIDebugDoor.h"
#import "RCDraggableButton.h"
#import "UIImage+Scale.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation PIDebugDoor

DEF_SINGLETON(PIDebugDoor)

- (instancetype)init
{
    if(self = [super init])
    {
        maskView = [[UIImageView alloc] init];
        
        maskView.frame = [UIApplication sharedApplication].keyWindow.frame;
//        maskView.image = [[UIImage imageNamed:@"avatar@2x.png"] zoomAndCutImageToSize:maskView.frame.size];
        [[UIApplication sharedApplication].keyWindow addSubview:maskView];
        maskView.hidden = YES;
        self.view = maskView;
        
        // 右上角关闭按钮,这里点击代码不生效，待查
//        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        float width = 40.f;
//        float left = maskView.frame.size.width - width;
//        float top = 50;
//        float heigh = width;
//        closeBtn.frame = CGRectMake(left, top, width, heigh);
//        closeBtn.backgroundColor = [UIColor blueColor];
//        closeBtn.userInteractionEnabled = YES;
//        [closeBtn addTarget:self action:@selector(closeMask) forControlEvents:UIControlEventTouchUpInside];
//        [maskView addSubview:closeBtn];
    }
    
    return self;
}

- (void)start
{
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, 100, 60, 60)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    
    [avatar setTapBlock:^(RCDraggableButton *avatar) {
        maskView.hidden = !maskView.hidden;
        
        // 从相册选一张图
        if(!maskView.hidden)
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage,nil];
            [self presentViewController:picker animated:YES completion:^{
                
            }];
        }
    }];
}

- (void)closeMask
{
    maskView.hidden = YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (pickedImage)
    {
        maskView.image = pickedImage;
        maskView.alpha = 0.6f;
    }
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    maskView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

@end
