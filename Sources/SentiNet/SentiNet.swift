//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 19.08.2020.
//

import Foundation

public class SentiNet : NSObject, XMLParserDelegate{
    var __sentiSynSetList: [String: SentiSynSet] = [:]
    var value: String = ""
    var id: String = ""
    var pScore: Double = 0.0
    var nScore: Double = 0.0
    var parser: XMLParser = XMLParser()

    override init(){
    }
    
    /**
    Constructor of Turkish SentiNet. Reads the turkish_sentinet.xml file from the resources directory. For each
    sentiSynSet read, it adds it to the sentiSynSetList.
    */
    init(fileName: String){
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let url = thisDirectory.appendingPathComponent(fileName)
        parser = XMLParser(contentsOf: url)!
        super.init()
        parser.delegate = self
        parser.parse()
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if (elementName == "ID") {
            value = ""
        } else if (elementName == "PSCORE") {
            value = ""
        } else if (elementName == "NSCORE") {
            value = ""
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String){
        value = value + string
    }
    
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
    func getSentiSynSet(_id: String) -> SentiSynSet{
        return self.__sentiSynSetList[_id]!
    }

    /**
    Adds specified SentiSynSet to the SentiSynSet list.

    - Parameter sentiSynSet : SentiSynSet to be added
    */
    func addSentiSynSet(sentiSynSet: SentiSynSet){
        self.__sentiSynSetList[sentiSynSet.getId()] = sentiSynSet
    }

    /**
    Removes specified SentiSynSet from the SentiSynSet list.

    - Parameter sentiSynSet : SentiSynSet to be removed
    */
    func removeSentiSynSet(sentiSynSet: SentiSynSet){
        self.__sentiSynSetList[sentiSynSet.getId()] = nil
    }

    /**
    Constructs and returns a list of ids, which are the ids of the SentiSynSets having polarity
    polarityType.

    - Parameter polarityType : PolarityTypes of the searched SentiSynSets

    - Returns: A list of id having polarityType polarityType.
    */
    func getPolarity(polarityType: PolarityType) -> [String]{
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
    func getPositives() -> [String]{
        return self.getPolarity(polarityType: PolarityType.POSITIVE)
    }

    /**
    Returns the ids of all negative SentiSynSets.

    - Returns: A list of ids of all negative SentiSynSets.
    */
    func getNegatives() -> [String]{
        return self.getPolarity(polarityType: PolarityType.NEGATIVE)
    }

    /**
    Returns the ids of all neutral SentiSynSets.

    - Returns: A list of ids of all neutral SentiSynSets.
    */
    func getNeutrals() -> [String]{
        return self.getPolarity(polarityType: PolarityType.NEUTRAL)
    }

}
