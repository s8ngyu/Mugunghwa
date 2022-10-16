//
//  CUIStructures.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

struct renditionkeytoken {
    unsigned short identifier;
    unsigned short value;
};


struct renditionkeyfmt {
    unsigned int tag;
    unsigned int version;
    unsigned int maximumRenditionKeyTokenCount;
    unsigned int renditionKeyTokens[0];
};


struct cuithemerenditionrenditionflags {
    unsigned int isHeaderFlaggedFPO:1;
    unsigned int isExcludedFromContrastFilter:1;
    unsigned int isVectorBased:1;
    unsigned int isOpaque:1;
    unsigned int bitmapEncoding:4;
    unsigned int optOutOfThinning:1;
    unsigned int isFlippable:1;
    unsigned int isTintable:1;
    unsigned int preservedVectorRepresentation:1;
    unsigned int reserved:20;
};


struct rgbquad {
    unsigned int b:8;
    unsigned int g:8;
    unsigned int r:8;
    unsigned int a:8;
};
