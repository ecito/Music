//
//  TracksTableViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        self.textLabel?.textColor = .white
        selectionStyle = .gray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TracksTableViewController: UITableViewController {

    var tracks = [[TrackViewModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func show(_ tracks: [[TrackViewModel]]) {
        self.tracks = tracks
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        tracks.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = tracks[indexPath.section][indexPath.row]
        cell.textLabel?.text = track.title

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
