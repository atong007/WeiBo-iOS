//
//  WBTweetNewStatus.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/8/2.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "WBTweetNewStatus.h"
#import "WBHttpTool.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "MBProgressHUD.h"
#import "WBTweetTextView.h"
#import "WBTweetImageView.h"
#import "WBTweetToolBar.h"
#import "WBCommonTool.h"
#import "WBTweetStatusParameter.h"
#import "WBTweetStatusResult.h"
#import "WBStatusTool.h"

#define WBPhotoViewMargin 10

@interface WBTweetNewStatus() <UITextViewDelegate, WBTweetToolBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WBTweetImageViewDelegate>

@property (nonatomic, weak) WBTweetTextView *textView;
@property (nonatomic, weak) WBTweetImageView *photoView;
@property (nonatomic, weak) WBTweetToolBar *tweetToolBar;
@property (nonatomic, weak) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, assign) int tagForImage;
@end
@implementation WBTweetNewStatus

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置navigationItem
    [self setupNavi];
    
    // 添加textView
    [self setupTextView];
    
    [self setupToolBar];
    
    // 添加photoView
    [self setupPhotoView];
    
    
}

/**
 *  设置navigationItem
 */
- (void)setupNavi
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    self.rightBarButtonItem.enabled = NO;
    self.title = @"发送微博";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTextView
{
    WBTweetTextView *textView = [[WBTweetTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事";
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardValueChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    WBLog(@"------------------------dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  添加toolBar
 */
- (void)setupToolBar
{
    WBTweetToolBar *toolBar = [[WBTweetToolBar alloc] init];
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarH = 30;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = self.view.frame.size.height - toolBarH;
    toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.tweetToolBar = toolBar;
}

/**
 *  添加准备发送的微博图片的预览
 */
- (void)setupPhotoView
{
    WBTweetImageView *photoView = [[WBTweetImageView alloc] init];
    photoView.delegate = self;
    CGFloat photoX = WBPhotoViewMargin;
    CGFloat photoY = 80;
    CGFloat photoW = self.view.frame.size.width - WBPhotoViewMargin * 2;
    CGFloat photoH = self.view.frame.size.height - photoY;
    photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
    [self.textView addSubview:photoView];
    self.photoView = photoView;
}

/**
 *  textView的编辑内容发生改变时调用
 */
- (void)textValueChange
{
    self.rightBarButtonItem.enabled = self.textView.text.length;
}

/**
 *  键盘弹出或回收时调用
 *
 */
- (void)keyboardValueChange:(NSNotification *)note
{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = keyboardF.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.tweetToolBar.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}

/**
 *  当textView拖动时调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}

- (void)imageTap:(int)tag
{
    self.tagForImage = tag;
    [self openPhotoLirary];
}

/**
 *  toolBar按钮点击事件处理
 *
 *  @param tag 每个按钮的标识
 */
- (void)toolBarButtonClicked:(WBTweetToolbarButtonType)tag
{
    switch (tag) {
        case WBTweetToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case WBTweetToolbarButtonTypePicture:
            [self openPhotoLirary];
            break;
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.mode = MBProgressHUDModeText;
        hub.label.text = @"相机不可用";
        [hub hideAnimated:YES afterDelay:0.8];
    }
    
}

/**
 *  打开相册
 */
- (void)openPhotoLirary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

/**
 *  打开相册的代理触发事件
 *
 *  @param info   包含选中image等信息的数组
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.photoView.subviews.count) {
        UIButton *button = self.photoView.subviews[self.tagForImage];
        if (button.selected) {
            [self.photoView replaceImageInNumber:self.tagForImage withImage:image];
            return;
        }
    }
    
    [self.photoView addImage:image];
}

/**
 *  取消发送微博
 */
- (void)cancel
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送微博
 */
- (void)send
{
    if (self.photoView.totalImage.count) {
        [self sendNewStatusWithImage];
    }else {
        [self sendNewStatusWithoutImage];
    }
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}

/**
 *  发带图片的微博
 */
- (void)sendNewStatusWithImage
{
    // 封装请求参数
    WBTweetStatusParameter *params = [WBTweetStatusParameter parameter];
    params.status = self.textView.text;
    
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *images = [self.photoView totalImage];
    for (UIImage *image in images) {
        WBFormData *formData = [[WBFormData alloc] init];
        formData.data = UIImageJPEGRepresentation(image, 0.00001);
        formData.name = @"pic"; //微博api的image图片接口
        formData.filename = @"";
        formData.mimeType = @"image/jpeg";
        [formDataArray addObject:formData];
    }
    
    [WBStatusTool postStatusWithPicture:params formDataArray:formDataArray success:^(WBTweetStatusResult *responseObject) {
        [self showMessageByProgressHUD:@"发送成功"];
    } failure:^(NSError *error) {
        [self showMessageByProgressHUD:@"发送失败"];
        NSLog(@"error:%@", error);
    }];
}

/**
 *  发不带图片的微博
 */
- (void)sendNewStatusWithoutImage
{
    // 封装请求参数
    WBTweetStatusParameter *params = [WBTweetStatusParameter parameter];
    params.status = self.textView.text;
    
    [WBStatusTool postStatusWithoutPicture:params success:^(WBTweetStatusResult *responseObject) {
        [self showMessageByProgressHUD:@"发送成功"];
    } failure:^(NSError *error) {
        [self showMessageByProgressHUD:@"发送失败"];
        NSLog(@"error:%@", error);
    }];
}

- (void)showMessageByProgressHUD:(NSString *)text
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.label.text = text;
    
    [hub hideAnimated:YES afterDelay:1.0];
}

@end
