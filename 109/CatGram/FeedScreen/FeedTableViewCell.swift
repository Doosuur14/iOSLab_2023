//
//  FeedTableViewCell.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 04.11.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()
    private lazy var avatarImageView: UIImageView = {
        let subView = UIImageView()
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var userName: UILabel = {
        let subView = UILabel()
        subView.font = UIFont.systemFont(ofSize: 14)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var postImageView: UIImageView = {
        let subView = UIImageView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var caption: UILabel = {
        let subView = UILabel()
        subView.font = UIFont.systemFont(ofSize: 10)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    lazy var likeButton: UIButton = {
        let subView = UIButton()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.setImage(UIImage(named: "like"), for: .normal)
        subView.addTarget(self, action: #selector(likedButtonTapped), for: .touchUpInside)
        return subView
    }()
    private lazy var sharePostButton: UIButton = {
        let subView = UIButton()
        subView.setImage(UIImage(named: "share"), for: .normal)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var commentButton: UIButton = {
        let subView = UIButton()
        subView.setImage(UIImage(named: "comment"), for: .normal)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var favButton: UIButton = {
        let subView = UIButton()
        subView.setImage(UIImage(named: "save"), for: .normal)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var commentLabel: UILabel = {
        let subView = UILabel()
        subView.text = "View all comments"
        subView.textColor = .gray
        subView.font = UIFont.systemFont(ofSize: 10)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var dateLabel: UILabel = {
        let subView = UILabel()
        subView.font = UIFont.systemFont(ofSize: 10)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    private lazy var likeCount: UILabel = {
        let subView = UILabel()
        subView.font = UIFont.systemFont(ofSize: 10)
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()

    var post: Feed?
    let userDefaults =  UserDefaults.standard
    var feedDatamanager = FeedDataManager.shared
    var likedPosts: [Feed]  =  []
    var doubleTapGesture: UITapGestureRecognizer?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        addDoubleTapGesture()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with feedPost: Feed) {
        print("Configuring cell for post: \(feedPost.id)")
        post = feedPost
        avatarImageView.image = feedPost.avatar
        userName.text = feedPost.userName
        postImageView.image = feedPost.photo
        caption.text = feedPost.caption
        dateLabel.text = feedPost.date
      //  likeCount.text = "\(post?.likeCount ?? 0 ) like(s)" // if null default value will be equal to 0
        updateUI()

    }

    private func setUpAvatarImage() {
        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }

    private func setUpUserName() {
        addSubview(userName)
        NSLayoutConstraint.activate([
            userName.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            userName.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }

    private func setUpPostImageView() {
        addSubview(postImageView)
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    private func setUpMainStackView() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(likeButton)
        mainStackView.addArrangedSubview(commentButton)
        mainStackView.addArrangedSubview(sharePostButton)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.heightAnchor.constraint(equalToConstant: 15),
            mainStackView.widthAnchor.constraint(equalToConstant: 75)
        ])
    }

    private func setUpFavButton() {
        addSubview(favButton)

        NSLayoutConstraint.activate([
            favButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            favButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
            favButton.heightAnchor.constraint(equalToConstant: 20),
            favButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setUpLikeCountLabel() {
        addSubview(likeCount)
        likeCount.isHidden = true
        NSLayoutConstraint.activate([
            likeCount.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            likeCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    private func setUpCaption() {
        addSubview(caption)
        NSLayoutConstraint.activate([
            caption.topAnchor.constraint(equalTo: likeCount.bottomAnchor, constant: 5),
            caption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }

    private func setUpCommentLabel() {
        addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: caption.bottomAnchor, constant: 5),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }

    private func setUpDateLabel() {
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }

    private func setUp() {
        setUpAvatarImage()
        setUpUserName()
        setUpPostImageView()
        setUpMainStackView()
        setUpFavButton()
        setUpLikeCountLabel()
        setUpCaption()
        setUpCommentLabel()
        setUpDateLabel()

    }
    private func addDoubleTapGesture() {
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture!.numberOfTapsRequired = 2
        likeButton.addGestureRecognizer(doubleTapGesture!)
    }

    @objc private func handleDoubleTap() {
        guard var post = post else { return }
        feedDatamanager.handleDoubleTap(for: post)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        post.likeCount -= 1
        likeCount.isHidden = true
    }

    @objc private func likedButtonTapped() {
        likeButton.isEnabled = true
        post?.isLiked = true
            guard var post = post else {
                print("Post nil")
                return
            }
            if post.isLiked == true {
                print("post liked")
                feedDatamanager.likedPosts.append(post)
                likeCount.isHidden = false
                post.likeCount += 1
                print("Liked posts: \(feedDatamanager.likedPosts)")
            } else {
                feedDatamanager.likedPosts.removeAll { $0.id == post.id }
                likeCount.isHidden = true

            }
        animateLikeButton()
        updateUI()
    }
    private func animateLikeButton() {
        UIView.animate(withDuration: 1.0) {
            self.likeButton.tintColor = .red
            self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { isFinished in
            guard isFinished else {return}
            self.likeButton.transform = .identity
        }
    }

    private func updateUI() {
            if let postId = post?.caption, feedDatamanager.likedPosts.contains(where: { $0.caption == postId }) {
                print("UI updated - Liked")
                likeCount.isHidden = false
                post?.likeCount += 1
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                likeButton.tintColor = .systemRed
                print("like count incremented ")
            } else {
                print("UI updated - Not Liked")
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                likeButton.tintColor = .black
                likeCount.isHidden = true

            }
        // I have to update the like count immediately after 
      //  incrementing it so it can be called in the configure cell function.
            likeCount.text = "\(post?.likeCount ?? 0) like(s)"
    }
}

extension UITableViewCell {
    static var reuseIdentifiers: String {
        return String(describing: self)
    }
}
