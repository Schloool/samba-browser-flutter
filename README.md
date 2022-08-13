# Introduction
This package is capable of performing several read operations on shares using the SMB2 specification.
Currently, the following implementations are supported:
- Android (using the [JCIFS](https://www.jcifs.org/) library)
- iOS (using the [AMSMB2](https://github.com/amosavian/AMSMB2) library)

**DISCLAIMER!**
The package was developed for experimental purposes. That is why the currently given amount of features is limited.
However, I am planning to expand the package in the future. Therefore I would really appreciate any kind of suggestion or error report you can provide on the [GitHub Issue Board](https://github.com/Schloool/samba-browser-flutter/issues)

## Example
````
SambaBrowser.getShareList('smb://192.168.0.1/', 'domain.net', 'admin', 'password')
    .then((shares) => print('Shares found: ${shares.cast<String>()}'));
    
SambaBrowser.saveFile('./local/', 'downloaded.pdf', 'smb://192.168.0.1/example.pdf', 'domain.net', 'admin', 'password')
    .then((path) => print('File downloaded to: $path'));
````

## Contributing
Contributions to the [GitHub Repository](https://github.com/Schloool/samba-browser-flutter) are very welcomed.
I also appreciate feature requests as well as bug reports using the [GitHub Issue Board](https://github.com/Schloool/samba-browser-flutter/issues).