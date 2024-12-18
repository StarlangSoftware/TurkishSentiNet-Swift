//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 19.08.2020.
//

import Foundation

public class SentiNet : NSObject, XMLParserDelegate{
    private var __sentiSynSetList: [String: SentiSynSet] = [:]
    private var value: String = ""
    private var id: String = ""
    private var pScore: Double = 0.0
    private var nScore: Double = 0.0
    private var parser: XMLParser = XMLParser()

    /**
     Constructor of Turkish SentiNet. Reads the turkish_sentinet.xml file from the resources directory. For each
     sentiSynSet read, it adds it to the sentiSynSetList.
     */
    override init(){
        let url = Bundle.module.url(forResource: "turkish_sentinet", withExtension: "xml")
        parser = XMLParser(contentsOf: url!)!
        super.init()
        parser.delegate = self
        parser.parse()
    }
    
    /// Another constructor of Turkish SentiNet. Reads the domain sentinet file from the resources directory. For each
    /// sentiSynSet read, it adds it to the sentiSynSetList.
    /// - Parameter fileName: Name of the file that contains the domain SentiNet.
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
        if (elementName == "ID") {
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
        if (elementName == "SYNSET"){
            self.__sentiSynSetList[id] = SentiSynSet(_id: id, positiveScore: pScore, negativeScore: nScore)
        } else if (elementName == "PSCORE"){
            pScore = Double(value)!
        } else if (elementName == "NSCORE"){
            nScore = Double(value)!
        } else if (elementName == "ID"){
            id = value
        }
    }

    /**
    Accessor for a single SentiSynSet.

    - Parameter _id : Id of the searched SentiSynSet.

    - Returns: SentiSynSet with the given id.
    */
    public func getSentiSynSet(_id: String) -> SentiSynSet{
        return self.__sentiSynSetList[_id]!
    }

    /**
    Adds specified SentiSynSet to the SentiSynSet list.

    - Parameter sentiSynSet : SentiSynSet to be added
    */
    public func addSentiSynSet(sentiSynSet: SentiSynSet){
        self.__sentiSynSetList[sentiSynSet.getId()] = sentiSynSet
    }

    /**
    Removes specified SentiSynSet from the SentiSynSet list.

    - Parameter sentiSynSet : SentiSynSet to be removed
    */
    public func removeSentiSynSet(sentiSynSet: SentiSynSet){
        self.__sentiSynSetList[sentiSynSet.getId()] = nil
    }

    /**
    Constructs and returns a list of ids, which are the ids of the SentiSynSets having polarity
    polarityType.

    - Parameter polarityType : PolarityTypes of the searched SentiSynSets

    - Returns: A list of id having polarityType polarityType.
    */
    private func getPolarity(polarityType: PolarityType) -> [String]{
        var result : [String] = []
        for sentiSynSet in self.__sentiSynSetList.values{
            if sentiSynSet.getPolarity() == polarityType{
                result.append(sentiSynSet.getId())
            }
        }
        return result
    }

    /**
    Returns the ids of all positive SentiSynSets.

    - Returns: A list of ids of all positive SentiSynSets.
    */
    public func getPositives() -> [String]{
        return self.getPolarity(polarityType: PolarityType.POSITIVE)
    }

    /**
    Returns the ids of all negative SentiSynSets.

    - Returns: A list of ids of all negative SentiSynSets.
    */
    public func getNegatives() -> [String]{
        return self.getPolarity(polarityType: PolarityType.NEGATIVE)
    }

    /**
    Returns the ids of all neutral SentiSynSets.

    - Returns: A list of ids of all neutral SentiSynSets.
    */
    public func getNeutrals() -> [String]{
        return self.getPolarity(polarityType: PolarityType.NEUTRAL)
    }

}
