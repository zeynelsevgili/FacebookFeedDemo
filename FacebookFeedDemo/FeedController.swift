//  FeedController.swift
//  FacebookFeedDemo
//  Created by Demo on 15.09.2018.
//  Copyright © 2018 Demo. All rights reserved.


import UIKit
import Foundation

class Post {
    
      @objc var name: String?
      @objc var statusText: String?
      @objc var profileImageName: String?
      @objc var statusImageName: String?
      var numLikes: NSNumber?
      var numComments: NSNumber?
      @objc var statusImageUrl: String?
    

}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var postNameArray = [Post]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        
        let zuckContent = Post()
        zuckContent.name = "Mark Zuckerberg Profili"
        zuckContent.statusText = "Bu kısım Mark Zuckerberg ile ilgilidir.Lorem ipsum dolor sit amet, cu mollis expetenda temporibus nam, sint graece deleniti est an. Sint choro meliore te vix, est ea laoreet suscipiantur. Vis dictas corrumpit id, te feugiat nominavi cum, at vis propriae voluptua volutpat. Erroribus salutatus ius ea, eu vel minim prompta tacimates. Ea duo novum oratio regione, eam adipisci interesset cu."
        zuckContent.profileImageName = "zuckprofile"
        zuckContent.numLikes = 300
        zuckContent.numComments = 53
        zuckContent.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg"


        let steveContent = Post()
        steveContent.name = "Steve Jobs Profili"
        steveContent.statusText = "Bu kısım Steve Jobs ile ilgilidir"
        steveContent.profileImageName = "steve_profile"
        steveContent.numLikes = 1500
        steveContent.numComments = 593
        steveContent.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg"




        let gandhiContent = Post()
        gandhiContent.name = "Gandhi Profili"
        gandhiContent.statusText = "Bu kısım Gandhi ile ilgilidir. Lorem ipsum dolor sit amet, cu mollis expetenda temporibus nam, sint graece deleniti est an. Sint choro meliore te vix, est ea laoreet suscipiantur. Vis dictas corrumpit id, te feugiat nominavi cum, at vis propriae voluptua volutpat. Erroribus salutatus ius ea, eu vel minim prompta tacimates. Ea duo novum oratio regione, eam adipisci interesset cu."
        gandhiContent.profileImageName = "gandhi_profile"
        gandhiContent.numLikes = 250
        gandhiContent.numComments = 17
        gandhiContent.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg"


        let billContent = Post()
        billContent.name = "Bill Gates Profili"
        billContent.statusText = "Bu kısım Bill Gates ile ilgilidir. Lorem ipsum dolor sit amet, cu mollis expetenda temporibus nam, sint graece deleniti est an. Sint choro meliore te vix, est ea laoreet suscipiantur. Vis dictas corrumpit id, te feugiat nominavi cum, at vis propriae voluptua volutpat. Erroribus salutatus ius ea, eu vel minim prompta tacimates. Ea duo novum oratio regione, eam adipisci interesset cu."
        billContent.profileImageName = "bill_profile"
        billContent.statusImageUrl = "https://cdn.geekwire.com/wp-content/uploads/2018/03/Bill-and-Phoebe-Gates_August-2017_Courtesy-Gates-Family-630x518.jpg"

        billContent.numLikes = 250
        billContent.numComments = 17


        postNameArray.append(zuckContent)
        postNameArray.append(steveContent)
        postNameArray.append(gandhiContent)
        postNameArray.append(billContent)
        
        // hem memory hem de disk için yer ayırıyoruz. 500 mb a kadar verilerimizi cache leyebileceğiz.
        let memoryCapacity = 500*1024*1024
        let diskCapacity = 500*1024*1024
        let urlCashe = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = urlCashe
        
        
        
        // ekranın fiziksel zıplamasını istiyorsak buna ihtiyaç var.
        collectionView?.alwaysBounceVertical = true
        
        navigationItem.title = "Facebook Demo"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postNameArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = postNameArray[indexPath.item] // atandığı gibi didSet içini aktif eder.
        feedCell.feedController = self
   
        return feedCell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = postNameArray[indexPath.item].statusText {

            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: .greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil).size
            
     
            let knownHeight: CGFloat = 8 + 50 + 4 + 12  + 4 + 200 + 8 + 31 + 20
            return CGSize(width: view.frame.width, height: rect.height + knownHeight)

        }
        
        
        // Burada ekran genişliğinde ve ... birim yüksekliğinde bir cell dönecek
        return CGSize(width: view.frame.width, height: 550)
        
    }
    
    // ekran döndüğünde layoutu yayar ekrana
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    
    let blackBackgroundView = UIView()
    var statusImageView: UIImageView?
    let zoomImageView = UIImageView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    func animateImageView(statusImageView: UIImageView) {
        
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            
            statusImageView.alpha = 0
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                tabBarCoverView.backgroundColor = UIColor.black
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            zoomImageView.backgroundColor = UIColor.red
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                // view in genişliği kadar anime et.
                let y = self.view.frame.height / 2 - height / 2
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
                
            }, completion: nil)
            
        }
    
    }
    
    @objc func zoomOut(){
        
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
       
            UIView.animate(withDuration: 0.75, animations: {
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }, completion: { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            })
        }
        
    }
}

class FeedCell: UICollectionViewCell {
    
    var feedController: FeedController?
 
    @objc func animate(tapGesture: UITapGestureRecognizer) {
     
        feedController?.animateImageView(statusImageView: statusImageView)
        
    }

    var post: Post? {
        
        didSet {
            
            if let statusImageUrl = post?.statusImageUrl {
                
                let url = URL(string: statusImageUrl)
                    
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    
                    if error != nil {
                        
                        print("zeynel\(error)")
                    }
                    let image = UIImage(data: data!)
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        DispatchQueue.main.async {
                            
                            self.statusImageView.image = image
                            self.loader.stopAnimating()
                            
                        }
   
                    }

                }).resume()
   
                }
 
            if let name = post?.name { // hala optionaldır. cellForItems içinde set edildiği anda unwrap edilir
                // birinci satır label ın özelliklerini belirtiyoruz.
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
                
                //yeni satırda küçük fontla ikinci satırın özelliklerini belirtiyoruz.
                attributedText.append(NSAttributedString(string: "\nAralık 18 • Diyarbakır", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor:
                    UIColor.rgb(red: 155, green: 161, blue: 171, alpha: 1)]))
                
                // line lar arasındaki boşluğu arttırmak için aşağıdakileri yapıyoruz.
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
                
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                nameLabel.attributedText = attributedText
                
            }
            

            
            if let statusText = post?.statusText {
                
                statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                
                profileImageView.image = UIImage(named: profileImageName)
                
            }
            
            if let statusImageName = post?.statusImageName {
                
                statusImageView.image = UIImage(named: statusImageName)
                
            }
            
            if let numOfLikes = post?.numLikes{

                likeLabel.text = String(describing: "\(numOfLikes) Likes")

            }
            
            if let numOfComment = post?.numComments {
                
                commentLabel.text = String(describing: "\(numOfComment) Comments")
                
            }
           
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // bunlar global değişken oluyor. IBOutlet ler gibi...
    let nameLabel: UILabel = {
        
       let label = UILabel()
        label.numberOfLines = 2
    
        return label
        
    }()
    
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
        
        
    }()
    
    
    let statusTextView: UITextView = {
        
        let textView = UITextView()
        textView.text = "Deneme"
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.isScrollEnabled = false
        return textView
    }()
    
    lazy var statusImageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true

        return imageView
        
    }()
    
    let likeLabel: UILabel = {
        
       let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171, alpha: 1)
        
        return label
        
    }()
    
    
    let commentLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171, alpha: 1)
        
        return label
        
    }()
    
    let dividerLine: UIView = {
        
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232, alpha: 1)
        return dividerView
    }()
    
    let likeButton = FeedCell.buttonForTitle(buttonTitle: "Like", buttonImageTitle: "like")
    let commentButton = FeedCell.buttonForTitle(buttonTitle: "Comment", buttonImageTitle: "comment")
    let shareButton = FeedCell.buttonForTitle(buttonTitle: "Share", buttonImageTitle: "share")
    
    static func buttonForTitle(buttonTitle: String, buttonImageTitle: String) -> UIButton {
        
        let button = UIButton()
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163, alpha: 1), for: .normal)
        button.setImage(UIImage(named: buttonImageTitle), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) // buttonImage in title a uzaklığı
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
        
    }


        private func setupView() {
            
//        let containerView = UIView()
//            backgroundColor = UIColor.white
//            addSubview(containerView)
//            containerView.translatesAutoresizingMaskIntoConstraints = false
            
        
            setupStatusImageViewLoader()
            statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))

            
            
            
//            NSLayoutConstraint.activate([
//
//                containerView.topAnchor.constraint(equalTo: topAnchor),
//                containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
//
//                ])
            
            // addsubview ve ilk iki constraininin top ve leadinginde container var.
            addSubview(profileImageView)
            NSLayoutConstraint.activate([
                
                profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                profileImageView.heightAnchor.constraint(equalToConstant: 50),
                profileImageView.widthAnchor.constraint(equalToConstant: 50)
              
                
                ])
           
              profileImageView.translatesAutoresizingMaskIntoConstraints = false
            
            // subview ve topAnchor kısmında container var.
            addSubview(nameLabel)
            NSLayoutConstraint.activate([
                
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 60)
                

                ])
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            // subview ve leading ve trailing kısmında container referans alındı.
            addSubview(statusTextView)
            NSLayoutConstraint.activate([
                statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
                statusTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                statusTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)

                ])
            statusTextView.translatesAutoresizingMaskIntoConstraints = false
            
            // container view e eklendiğinde tapGesture gerçekleşmiyor.
            // trailing ve leading kısmında container referans alınmış
            addSubview(statusImageView)
            NSLayoutConstraint.activate([
                
                statusImageView.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 4),
                statusImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                statusImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                statusImageView.heightAnchor.constraint(equalToConstant: 200)
  
                ])
            statusImageView.translatesAutoresizingMaskIntoConstraints = false
            
            // subview ve leading kısmında container view referans alınmış
            addSubview(likeLabel)
            likeLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                
                likeLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8),
                likeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)

                ])
            
             // subview kısmında container view referans alınmış
            addSubview(commentLabel)
            commentLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                commentLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8),
                commentLabel.leadingAnchor.constraint(equalTo: likeLabel.trailingAnchor, constant: 8)
     
                
                ])
            
            
             // subview ve leading ve trailing kısmında container view referans alınmış
            addSubview(dividerLine)
            dividerLine.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([

                dividerLine.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 4),
                dividerLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                dividerLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                dividerLine.heightAnchor.constraint(equalToConstant: 1)

                ])

            
            
            let buttonControlsStackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
             // subview ve leading ve trailing kısmında container view referans alınmış
            buttonControlsStackView.distribution = .fillEqually
            addSubview(buttonControlsStackView)
            buttonControlsStackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                buttonControlsStackView.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 4),
                buttonControlsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                buttonControlsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                buttonControlsStackView.heightAnchor.constraint(equalToConstant: 30)
                
                
                
                ])
        
    }
    let loader = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    func setupStatusImageViewLoader() {
        loader.hidesWhenStopped = true
        loader.startAnimating()
        loader.color = UIColor.black
        statusImageView.addSubview(loader)
        
        statusImageView.centerXAnchor.constraint(equalTo: loader.centerXAnchor).isActive = true
        statusImageView.centerYAnchor.constraint(equalTo: loader.centerYAnchor).isActive = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
}





