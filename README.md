# For Developers

You can also see [Java](https://github.com/starlangsoftware/TurkishSentiNet), [Python](https://github.com/starlangsoftware/TurkishSentiNet-Py), [Cython](https://github.com/starlangsoftware/TurkishSentiNet-Cy), [C++](https://github.com/starlangsoftware/TurkishSentiNet-CPP), or [C#](https://github.com/starlangsoftware/TurkishSentiNet-CS) repository.

## Requirements

* Xcode Editor
* [Git](#git)

### Git

Install the [latest version of Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

## Download Code

In order to work on code, create a fork from GitHub page. 
Use Git for cloning the code to your local or below line for Ubuntu:

	git clone <your-fork-git-link>

A directory called TurkishSentiNet-Swift will be created. Or you can use below link for exploring the code:

	git clone https://github.com/starlangsoftware/TurkishSentiNet-Swift.git

## Open project with XCode

To import projects from Git with version control:

* XCode IDE, select Clone an Existing Project.

* In the Import window, paste github URL.

* Click Clone.

Result: The imported project is listed in the Project Explorer view and files are loaded.


## Compile

**From IDE**

After being done with the downloading and opening project, select **Build** option from **Product** menu. After compilation process, user can run TurkishSentiNet-Swift.

Detailed Description
============

+ [SentiNet](#sentinet)
+ [SentiSynSet](#sentisynset)

## SentiNet

Duygu sözlüğünü yüklemek için

	a = SentiNet(fileName: "turkish_sentinet.xml")

Belirli bir synsete ait duygu synsetini elde etmek için

	func getSentiSynSet(_id: String) -> SentiSynSet

## SentiSynSet

Bir SentiSynset elimizdeyken onun pozitif skorunu

	func getPositiveScore() -> Double

negatif skorunu

	func getNegativeScore() -> Double

polaritysini

	func getPolarity() -> PolarityType
