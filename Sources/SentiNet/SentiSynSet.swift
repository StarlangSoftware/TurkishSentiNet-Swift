//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 19.08.2020.
//

import Foundation

public class SentiSynSet{
    
    private var id: String
    private var positiveScore: Double
    private var negativeScore: Double

    /**
    Constructor of SentiSynSet. Gets input id, positiveScore, negativeScore and sets all corresponding attributes.

    - Parameters:
        - _id : Id of the SentiSynSet.
        - positiveScore : Positive score of the SentiSynSet.
        - negativeScore : Negative score of the SentiSynSet.
    */
    public init(_id: String, positiveScore: Double, negativeScore: Double){
        self.id = _id
        self.positiveScore = positiveScore
        self.negativeScore = negativeScore
    }

    /**
    Accessor for the positiveScore attribute.

    - Returns: PositiveScore of the SentiSynSet.
    */
    public func getPositiveScore() -> Double{
        return self.positiveScore
    }

    /**
    Accessor for the negativeScore attribute.

    - Returns: NegativeScore of the SentiSynSet.
    */
    public func getNegativeScore() -> Double{
        return self.negativeScore
    }

    /**
    Accessor for the id attribute.

    - Returns: Id of the SentiSynSet.
    */
    public func getId() -> String{
        return self.id
    }

    /**
    Returns the polarityType of the sentiSynSet. If the positive score is larger than the negative score, the
    polarity is positive; if the negative score is larger than the positive score, the polarity is negative; if
    both positive score and negative score are equal, the polarity is neutral.

    - Returns: PolarityType of the sentiSynSet.
    */
    public func getPolarity() -> PolarityType{
        if self.positiveScore > self.negativeScore{
            return PolarityType.POSITIVE
        } else if self.positiveScore < self.negativeScore{
            return PolarityType.NEGATIVE
        } else {
            return PolarityType.NEUTRAL
        }
    }

}
