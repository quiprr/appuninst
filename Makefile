.PHONY: clean all

CC     := xcrun --sdk iphoneos clang
CFLAGS := -O2 -arch arm64 -fobjc-arc -miphoneos-version-min=10.0
LIBS   := -framework Foundation -framework CoreServices
SIGN   := ldid -Sappuninst.plist

clean:
	rm -rf bin/

all:
	$(CC) $(CFLAGS) Sources/appuninst.m -o bin/appuninst $(LIBS)
	$(SIGN) bin/appuninst