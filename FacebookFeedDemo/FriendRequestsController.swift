//
//  FriendRequestsController.swift
//  FacebookFeedDemo
//
//  Created by Demo on 23.09.2018.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

class FriendRequestsController: UITableViewController {

    static let cellId = "cellId"
    static let headerCellId = "headerId"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Arkadaşlık istekleri"
        tableView.separatorColor = UIColor.rgb(red: 229, green: 231, blue: 235, alpha: 1)
        tableView.sectionHeaderHeight = 26


        tableView.register(FriendRequestCell.self, forCellReuseIdentifier: FriendRequestsController.cellId)

        tableView.register(RequestHeader.self, forHeaderFooterViewReuseIdentifier: FriendRequestsController.headerCellId)


    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

      
       
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendRequestsController.headerCellId) as! RequestHeader
        if section == 0 {
            header.nameLabel.text = "Arkadaş istekleri"
           
        } else {
            header.nameLabel.text = "Tanıyabileceğiz şahıslar"
        }

        
        return header
      


    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: FriendRequestsController.cellId, for: indexPath) as! FriendRequestCell


        if indexPath.row % 3 == 0 {
            cell.namaLabel.text = "Mark Zuckerberg"
            cell.profileImageView.image = UIImage(named: "zuckprofile")
        } else if indexPath.row % 3 == 1 {
            cell.namaLabel.text = "Steve Jobs"
            cell.profileImageView.image = UIImage(named: "steve_profile")
        } else {
            cell.namaLabel.text = "Mahatma Gandhi"
            cell.profileImageView.image = UIImage(named: "gandhi_profile")
        }

        cell.imageView?.backgroundColor = UIColor.black

        return cell
    }


}

    class RequestHeader: UITableViewHeaderFooterView {

        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setupView()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupView() {

            let containerView = UIView()

            addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: topAnchor),
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])

            containerView.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),

                ])

        }


        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Arkadaş Tavsiyeleri"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(white: 0.7, alpha: 1)
            return label
        }()

        let bottomBorderView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235, alpha: 1)
            return view
        }()

    }


    class FriendRequestCell: UITableViewCell {

        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        let namaLabel: UILabel = {
            let label = UILabel()
            label.text = "Örnek İsim"
            label.font = UIFont.boldSystemFont(ofSize: 12)
            return label
        }()

        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = UIColor.blue
            imageView.layer.masksToBounds = true
            return imageView
        }()

        let confirmButton: UIButton = {
            let buttonConfirm = UIButton()
            buttonConfirm.setTitle("Doğrula", for: .normal)
            buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            buttonConfirm.backgroundColor = UIColor.rgb(red: 87, green: 143, blue: 255, alpha: 1)
            buttonConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
            buttonConfirm.layer.cornerRadius = 2
            return buttonConfirm
        }()

        let deleteButton: UIButton = {
            let button = UIButton()
            button.setTitle("Sil", for: .normal)
            button.setTitleColor(UIColor(white: 0.7, alpha: 1), for: .normal)
            button.layer.cornerRadius = 2
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
            return button
        }()

        func setupViews() {

            let containerView = UIView()
            addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: topAnchor),
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])

            containerView.addSubview(profileImageView)
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([

                profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),

                profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                profileImageView.heightAnchor.constraint(equalToConstant: 52),
                profileImageView.widthAnchor.constraint(equalToConstant: 52)

                ])

            containerView.addSubview(namaLabel)
            namaLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([

                namaLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),

                namaLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),

                ])



            containerView.addSubview(confirmButton)
            confirmButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([

                confirmButton.topAnchor.constraint(equalTo: namaLabel.bottomAnchor, constant: 4),
                confirmButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),

                confirmButton.heightAnchor.constraint(equalToConstant: 20),
                confirmButton.widthAnchor.constraint(equalToConstant: 80)

                ])
            containerView.addSubview(deleteButton)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                deleteButton.topAnchor.constraint(equalTo: namaLabel.bottomAnchor, constant: 4),
                deleteButton.leadingAnchor.constraint(equalTo: confirmButton.trailingAnchor, constant: 5),
                deleteButton.heightAnchor.constraint(equalToConstant: 20),
                deleteButton.widthAnchor.constraint(equalToConstant: 80)
                ])

        }

    }

    






