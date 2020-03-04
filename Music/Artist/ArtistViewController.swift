//
//  ArtistViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

class ArtistAlbumTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
        self.textLabel?.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ArtistViewController: UITableViewController {

    var albums = [AlbumViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        title = "Albums"
        tableView.register(ArtistAlbumTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func show(_ albums: ArtistAlbumsViewModel) {
        title = albums.title
    
        self.albums = albums.albums
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
}
