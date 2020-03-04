//
//  AlbumsTableViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        self.textLabel?.textColor = .white
        selectionStyle = .gray
    }
    
    override func layoutSubviews() {
        imageView?.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AlbumsTableViewController: UITableViewController {

    var albums = [AlbumViewModel]()
    
    lazy var didSelectItem: (AlbumViewModel, IndexPath) -> () = { _, _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func show(_ albums: ArtistAlbumsViewModel) {
        self.albums = albums.albums
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = albums[indexPath.row].title
        
        cell.imageView?.loadImage(from: albums[indexPath.row].imageURL,
                                  placeHolder: UIImage(named: "album-placeholder"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem(albums[indexPath.row], indexPath)
    }
}
