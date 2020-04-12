//
//  FetchAlbumsViewController.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/11/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Cocoa

class FetchAlbumsViewController: NSViewController, NSWindowDelegate {
    
    // StackView object, will contain the label and fetch button
    private let horizontalStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.alignment = .left
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fetchInformationLabel: NSTextField = {
        let label = NSTextField()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = NSFont(name: "Helvetica", size: 16)
        label.stringValue = "Fetch albums for Jack Johnson"
        label.isBezeled = false
        label.isEditable = false
        label.sizeToFit()
    
        return label
    }()
    
    private let fetchButton: NSButton = {
        let button = NSButton()
        button.layer?.backgroundColor = NSColor.green.cgColor
        button.contentTintColor = .white
        button.font = NSFont(name: "Helvetica", size: 16)
        button.stringValue = "Fetch"
        button.action = #selector(FetchAlbumViewController.fetchButtonPressed)
    
        return button
    }()
       
    // Properties
    private let albumsTableView: NSTableView!
    private(set) var viewModel: FetchAlbumViewModel
    
    // Constants
    private let topBottomMargin: CGFloat = 20
    private let leadingAndTrailingMargin: CGFloat = 80
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        albumsTableView = NSTableView()
        viewModel = FetchAlbumViewModel
           
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView()
    }
    
    // Stops the window from being dismissed. The window will be shown again if the user clicks on the app icon
    //
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.hide(nil)
        return false
    }
    
    override func viewWillAppear() {
        // This will let the current view controller to handle NSWindow callbacks
        view.window?.delegate = self
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupHorizontalStackView() {
        horizontalStackView.addArrangedSubview(fetchInformationLabel)
        horizontalStackView.addArrangedSubview(fetchButton)
        
        view.addSubview(horizontalStackView)
    }
       
    private func setupAlbumsTableView() {
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
        
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(albumsTableView)
    }
    
    private func setupConstraints() {
        horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingAndTrailingMargin).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingAndTrailingMargin).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBottomMargin).isActive = true
        albumsTableView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: topBottomMargin).isActive = true
        
        albumsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingAndTrailingMargin).isActive = true
        albumsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingAndTrailingMargin).isActive = true
        albumsTableView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: topBottomMargin).isActive = true
        albumsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -topBottomMargin).isActive = true
    }
    
    private func setupView() {
        title = "Jack Johnson Album fetch utility"
        
        setupHorizontalStackView()
        setupAlbumsTableView()
        setupConstraints()
    }
    
    @objc private func fetchButtonPressed() {
        AlbumService().fetchAlbums() { response in
            do {
                guard let albums = try response() as? Albums else {
                    return
                }
                
                self.viewModel = FetchAlbumViewModel(resultCount: albums.resultCount, albums: albums.results)
            } catch let e{
                print(e.localizedDescription)
            }
        }
    }
    
}


// MARK: TableView Data Source

extension FetchAlbumViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        return NSCell(textCell: "fdfdfdfdf")
    }
}


// MARK: TableView Delegate

extension FetchAlbumViewController: NSTableViewDelegate {
    
}
