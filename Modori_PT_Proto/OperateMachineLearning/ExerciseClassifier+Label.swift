/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Defines the app's knowledge of the model's class labels.
*/

extension ExerciseClassifier {
    /// Represents the app's knowledge of the Exercise Classifier model's labels.
    /// 모도리 머신러닝에 학습된 운동 종목을 받아서 앱에 띄워주는 코드
    enum Label: String, CaseIterable {
       
        case crunch = "Crunch"
        case lunge = "Lunge"
        case squat = "Squat"
        case jumping_jacks = "Jumping_Jacks"
        case others = "Others"
        
        /// A negative class that represents irrelevant actions.
        /// 현재 otherAction에 대한 학습 되어 있지 않아 주석 처리함.
//        case otherAction = "Other Action"

        /// Creates a label from a string.
        /// - Parameter label: The name of an action class.
        init(_ string: String) {
            guard let label = Label(rawValue: string) else {
                let typeName = String(reflecting: Label.self)
                fatalError("Add the `\(string)` label to the `\(typeName)` type.")
            }

            self = label
        }
    }
}
