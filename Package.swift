import PackageDescription

let package = Package(
    name: "InterchangeVoc",
    dependencies: [
    	.Package(url: "https://github.com/QuStudio/Vocabulaire.git", majorVersion: 0, minor: 1),
    	.Package(url: "https://github.com/Zewo/InterchangeData.git", majorVersion: 0, minor: 2)
    ]
)
