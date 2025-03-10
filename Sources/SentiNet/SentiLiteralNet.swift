//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 6.07.2021.
//

import Foundation

public class SentiLiteralNet : NSObject, XMLParserDelegate{
    private var __sentiLiteralList: [String: SentiLiteral] = [:]
    private var value: String = ""
    private var name: String = ""
    private var pScore: Double = 0.0
    private var nScore: Double = 0.0
    private var parser: XMLParser = XMLParser()

    /**
     Constructor of Turkish SentiNet. Reads the turkish_sentinet.xml file from the resources directory. For each
     sentiLiteral read, it adds it to the sentiLiteralList.
     */
    override init(){
        let url = Bundle.module.url(forResource: "turkish_sentiliteralnet", withExtension: "xml")
        parser = XMLParser(contentsOf: url!)!
        super.init()
        parser.delegate = self
        parser.parse()
    }
    
    /// Another constructor of Turkish SentiLiteralNet. Reads the domain sentiliteralnet file from the resources directory. For each
    /// sentiLiteral read, it adds it to the sentiLiteralList.
    /// - Parameter fileName: Name of the file that contains the domain SentiLiteralNet.
    public init(fileName: String){
        let url = Bundle.module.url(forResource: fileName, withExtension: "xml")
        parser = XMLParser(contentsOf: url!)!
        super.init()
        parser.delegate = self
        parser.parse()
    }
    
    /// Xml parser method called at the start of the element.
    /// - Parameters:
    ///   - parser: Current parser
    ///   - elementName: Name of the element
    ///   - namespaceURI: -
    ///   - qName: -
    ///   - attributeDict: Attribute list of the element
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if (elementName == "NAME") {
            value = ""
        } else if (elementName == "PSCORE") {
            value = ""
        } else if (elementName == "NSCORE") {
            value = ""
        }
    }
    
    /// Xml parser method for text between elements.
    /// - Parameters:
    ///   - parser: Current parser
    ///   - string: Texr to be processed.
    public func parser(_ parser: XMLParser, foundCharacters string: String){
        value = value + string
    }
    
    /// Xml parser method called at the end of the element.
    /// - Parameters:
    ///   - parser: Current parser
    ///   - elementName: Name of the element
    ///   - namespaceURI: -
    ///   - qName: -
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if (elementName == "WORD"){
            self.__sentiLiteralList[name] = SentiLiteral(_name: name, positiveScore: pScore, negativeScore: nScore)
        } else if (elementName == "PSCORE"){
            pScore = Double(value)!
        } else if (elementName == "NSCORE"){
            nScore = Double(value)!
        } else if (elementName == "NAME"){
            name = value
        }
    }

    /**
    Accessor for a single SentiLiteral.

    - Parameter _name: Name of the searched SentiLiteral.

    - Returns: SentiLiteral with the given id.
    */
    public func getSentiLiteral(_name: String) -> SentiLiteral{
        return self.__sentiLiteralList[_name]!
    }

    /**
    Constructs and returns a list of ids, which are the ids of the SentiLiterals having polarity
    polarityType.

    - Parameter polarityType : PolarityTypes of the searched SentiSynSets

    - Returns: A list of names having polarityType polarityType.
    */
    private func getPolarity(polarityType: PolarityType) -> [String]{
        var result : [String] = []
        for sentiLiteral in self.__sentiLiteralList.values{
            if sentiLiteral.getPolarity() == polarityType{
                result.append(sentiLiteral.getName())
            }
        }
        return result
    }

    /**
    Returns the names of all positive SentiLiterals.

    - Returns: A list of names of all positive SentiLiterals.
    */
    public func getPositives() -> [String]{
        return self.getPolarity(polarityType: PolarityType.POSITIVE)
    }

    /**
    Returns the ids of all negative SentiLiterals.

    - Returns: A list of names of all negative SentiLiterals.
    */
    public func getNegatives() -> [String]{
        return self.getPolarity(polarityType: PolarityType.NEGATIVE)
    }

    /**
    Returns the ids of all neutral SentiLiterals.

    - Returns: A list of names of all neutral SentiLiterals.
    */
    public func getNeutrals() -> [String]{
        return self.getPolarity(polarityType: PolarityType.NEUTRAL)
    }

}
