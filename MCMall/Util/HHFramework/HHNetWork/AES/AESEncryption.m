

#import "AESEncryption.h"
#import "Base64Tool.h"

    //#define kEncryptKey @"1862b0deb369e73a" // 加密用的key
#define AES_KEY_LENGTH 16
@implementation AESEncryption


static Byte OIV[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10 };  // 此处向量可自定

+(NSString*) AESEncrypt:(NSString*)plainText strKey:(NSString*)strKey
{
    
    char* keyBuffer = malloc(AES_KEY_LENGTH);
    char* keybytes = (char*)[strKey UTF8String];
    for (int i=0;i<AES_KEY_LENGTH;i++)
    {
        if (i >= strlen(keybytes))
        {
            keyBuffer[i] = 0x12;
        }
        else
        {
            keyBuffer[i] = keybytes[i];
        }
    }
    
    size_t bufferSize = plainText.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    NSData* indata = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyBuffer, AES_KEY_LENGTH,
                                          OIV,
                                          indata.bytes, indata.length ,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        NSData* data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString * str=[data base64EncodedString];
        str=[str stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        return str;
    }
    else
    {
        free(buffer);
        return nil;
    }
}

+(NSString*) AESDecrypt:(NSString*)cipherText strKey:(NSString*)strKey
{
    cipherText=[cipherText stringByReplacingOccurrencesOfString:@"%2b" withString:@"+"];
   NSData* indata =[NSData dataWithBase64EncodedString:cipherText];
    char* keyBuffer = malloc(AES_KEY_LENGTH);
    char* keybytes = (char*)[strKey UTF8String];
    for (int i=0;i<AES_KEY_LENGTH;i++)
    {
        if (i >= strlen(keybytes))
        {
            keyBuffer[i] = 0x12;
        }
        else
        {
            keyBuffer[i] = keybytes[i];
        }
    }
    size_t outsize = indata.length + kCCBlockSizeAES128;
    Byte* outbytes = malloc(outsize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyBuffer, AES_KEY_LENGTH,
                                          OIV,
                                          indata.bytes, indata.length,
                                          outbytes, outsize,
                                          &numBytesDecrypted);
    
    free(keyBuffer);
    //free(keybytes);
    if (cryptStatus == kCCSuccess)
    {
        NSData* data = [NSData dataWithBytes:outbytes length:numBytesDecrypted];
        free(outbytes);
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else
    {
        free(outbytes);
        return nil;
    }
}
@end