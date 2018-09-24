//
//  ConvertString.m
//  XemPhim
//
//  Created by Tạ Đại on 13/05/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import "ConvertString.h"

@implementation ConvertString

-(NSString*)convertToUnsignedChar:(NSString*)ch{
    if(ch==nil)return nil;
    NSArray *arrch = [NSArray arrayWithObjects:
                      @"aàáảãạăằắẳẵặâầấẩẫậÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬ",
                      @"dđĐ",
                      @"uùúủũụưừứửữựÙÚỦŨỤƯỪÚỬỮỰ",
                      @"iìíỉĩịÌÍỈĨỊ",
                      @"yỳýỷỹỵỲÝỶỸỴ",
                      @"oòóỏõọôồốổỗộơờớởỡợÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢ",
                      @"eèéẻẽẹêềếểễệÈÉẺẼẸÊỀẾỂỄỆ",nil];
    for(NSString *str in arrch){
        NSRange r = [str rangeOfString:ch];
        if(r.location!=NSNotFound){
            return [str substringToIndex:1];
        }
    }
    return nil;
}

-(NSString*)convertToUnsigned:(NSString*)str{
    NSString *s=@"";
    for (int i=0; i<str.length; i++) {
        char ch = [str characterAtIndex:i];
        if((ch>='a' && ch<='z')||(ch>='0' && ch<='9')){
            s= [NSString stringWithFormat:@"%@%c",s,ch];
        }else if(ch>='A' && ch<='Z'){
            s= [NSString stringWithFormat:@"%@%c",s,ch+abs('a'-'A')];
            //        }else if(ch==' '){
            //            s= [NSString stringWithFormat:@"%@%c",s,ch];
        }else{
            NSString *ss = [str substringFromIndex:i];
            ss=[ss substringToIndex:1];
            ss = [self convertToUnsignedChar:ss];
            
            if(ss){
                s= [NSString stringWithFormat:@"%@%@",s,ss];
            }
        }
    }
    return s;
}

@end
