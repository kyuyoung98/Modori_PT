import UIKit
import Firebase
import FirebaseAuth

/// Displays a table view of the actions with the time duration for each.
class SummaryViewController: UIViewController {
    var ExerciseList:[String : Int64] = [:]
    var memberDataList: [WorkoutList] = []

    /// The summary view controller's primary view.
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var resetSync: UIButton!
    /// The list of actions, sorted by descending time.
    private var sortedActions = [String]()
    
    let ref = Database.database().reference()
    
    /// The times of each action, keyed by the action's name.
    var actionFrameCounts: [String: Int]? {
        didSet {
            guard let frameCounts = actionFrameCounts else { return }

            // Clear out the previous list of actions.
            sortedActions.removeAll()

            // Create a list of the actions sorted by descending time.
            let sortedElements = frameCounts.sorted { $0.value > $1.value }
            sortedElements.forEach { entry in sortedActions.append(entry.key) }
        }
    }

    /// A closure the summary view controller calls after it disappears.
    var dismissalClosure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view?.overrideUserInterfaceStyle = .dark
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        sortedActions.removeAll()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Call the dismissal closure, if there is one.
        dismissalClosure?()
        super.viewDidDisappear(animated)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        
        //self.deleteButtonDelegate?.deletePressed(in: self)
        sortedActions.removeAll()
        //tableView.dataSource = nil
        tableView.reloadData()
    }
}

// MARK: - Table View Data Source
extension SummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sortedActions.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let customCellName = "SummaryCellPrototype"
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellName,
                                                 for: indexPath)

        guard let summaryCell = cell as? SummaryTableViewCell else {
            fatalError("Not an instance of `SummaryTableViewCell`.")
        }

        if let frameCounts = actionFrameCounts {
            let frameRate = ExerciseClassifier.frameRate

            let action = sortedActions[indexPath.row]
            let totalFrames = frameCounts[action] ?? 0
            let totalDuration = Int64(Double(totalFrames) / frameRate)
            let uid = Auth.auth().currentUser?.uid ?? "UID"

            summaryCell.totalDuration = totalDuration
            summaryCell.actionLabel.text = action
            self.ref.child("Workout/Users/\(uid)").updateChildValues(["\(action)":(totalDuration+(self.ExerciseList["\(action)"] ?? 0 ))])
                       
        }
        return summaryCell
    }
    
    //slide delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            sortedActions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - Table Cell
///Displays the name of an action and the total time duration of that action.
///
///

class SummaryTableViewCell: UITableViewCell {
   
    /// Displays name of the action.
    @IBOutlet weak var actionLabel: UILabel!

    /// Displays the amount of time of the action.
    @IBOutlet weak var timeLabel: UILabel!

    /// Converts the floating point value into a string for the action label.
    ///
    /// For example, the time label shows "1.7s" for a value of `1.66666666666`.
    var totalDuration: Int64 = 0 {
        didSet { timeLabel.text = String(format: "%d", totalDuration) }
    }
}
