#import "appuninst.h"

int main(int argc, char *argv[], char *envp[]) {
	if (argc == 2) {
        if (strcmp(argv[1], "--help")==0 || strcmp(argv[1], "-h")==0) {
            printf(
                "Usage: appuninst [OPTION]... APPNAME/BUNDLEID\n"
                "appuninst is MIT licensed at github.com/quiprr/appuninst.\n"
                "Uninstall iOS applications from the command line.\n\n"

                "  -h, --help        Show this help message and exit.\n"
                "  -v, --version     Show version information and exit.\n"
                );
            return 0;
        } else if (strcmp(argv[1], "--version")==0 || strcmp(argv[1], "-v")==0) {
            printf("appuninst version 1.0.0 (licensed under MIT)\n");
            printf("Built with Apple clang %s\n", __clang_version__);
            return 0;
        }
    } else if (argc > 2) {
        printf("Too many arguments given. Consult 'appuninst --help'.\n");
        return 1;
    } else if (argc == 1) {
        printf("No app name/bundle identifier or flag was provided. Consult 'appuninst --help'.\n");
        return 1;
    }

	LSApplicationWorkspace *workspace = [LSApplicationWorkspace defaultWorkspace];

	NSString *bundleID;
	NSString *given = [NSString stringWithUTF8String: argv[1]];
	BOOL found = NO;

	for (LSApplicationProxy *application in workspace.allInstalledApplications) {
		if (application.isDeletable) {
			NSString *localizedAppName = [application localizedNameForContext:nil];
			if ([given isEqual:localizedAppName] || [given isEqual:application.applicationIdentifier]) {
				bundleID = application.applicationIdentifier;
				found = YES;
				break;
			}
		}
	}

	if (!found) {
		printf("The application %s is not installed or could not be found. Check your spelling and capitalization.\n", argv[1]);
		return 1;
	}

	BOOL success = [workspace uninstallApplication:bundleID withOptions:nil];
	if (success) {
		printf("The application %s was successfully uninstalled.\n", bundleID.UTF8String);
        return 0;
	} else {
		printf("The application %s was found but couldn't be uninstalled.\n", bundleID.UTF8String);
		return 1;
	}
}