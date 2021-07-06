//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 6.07.2021.
//

import Foundation

public class SentiLiteral{
    
    private var name: String
    private var positiveScore: Double
    private var negativeScore: Double

    /**
    Constructor of SentiLiteral. Gets input name, positiveScore, negativeScore and sets all corresponding attributes.

    - Parameters:
        - _name : Name of the SentiLiteral.
        - positiveScore : Positive score of the SentiLiteral.
        - negativeScore : Negative score of the SentiLiteral.
    */
    public init(_name: String, positiveScore: Double, negativeScore: Double){
        self.name = _name
        self.positiveScore = positiveScore
        self.negativeScore = negativeScore
    }

    /**
    Accessor for the positiveScore attribute.

    - Returns: PositiveScore of the SentiLiteral.
    */
    public func getPositiveScore() -> Double{
        return self.positiveScore
    }

    /**
    Accessor for the negativeScore attribute.

    - Returns: NegativeScore of the SentiLiteral.
    */
    public func getNegativeScore() -> Double{
        return self.negativeScore
    }

    /**
    Accessor for the id attribute.

    - Returns: Id of the SentiLiteral.
    */
    public func getName() -> String{
        return self.name
    }

    /**
    Returns the polarityType of the SentiLiteral. If the positive score is larger than the negative score, the
    polarity is positive; if the negative score is larger than the positive score, the polarity is negative; if
    both positive score and negative score are equal, the polarity is neutral.

    - Returns: PolarityType of the SentiLiteral.
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
