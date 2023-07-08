/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Provides a convenience method that makes a prediction from a multiarray window.
*/

import CoreML

extension ExerciseClassifier {
    /// Predicts an action from a series of landmarks' positions over time.
    /// 시간의 흐름에 따른 신체 포지션의 랜드마크를 통해 운동종류를 추측 함.
    /// - Parameter window: An `MLMultiarray` that contains the locations of a
    /// person's body landmarks for multiple points in time.
    /// - Returns: An `ActionPrediction`.
    /// - Tag: predictActionFromWindow
    func predictActionFromWindow(_ window: MLMultiArray) -> ActionPrediction {
        do {
            let output = try prediction(poses: window)
            let action = Label(output.label)
            let confidence = output.labelProbabilities[output.label]!

            return ActionPrediction(label: action.rawValue, confidence: confidence)

        } catch {
            fatalError("Exercise Classifier prediction error: \(error)")
        }
    }
}
