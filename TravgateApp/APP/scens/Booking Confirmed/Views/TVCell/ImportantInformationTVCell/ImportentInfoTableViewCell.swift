//
//  ImportentInfoTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 27/11/23.
//

import UIKit

class ImportentInfoTableViewCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTV()
        // Initialization code
    }
    
    func setupTV() {
        holderView.layer.cornerRadius = 8
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = HexColor("#E6E8E7").cgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImportentInfoSubTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension ImportentInfoTableViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ImportentInfoSubTableViewCell {
            commonCell = cell
        }
        return commonCell
    }
}
