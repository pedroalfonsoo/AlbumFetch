//
//  FetchAlbumsViewController.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/11/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Cocoa

class FetchAlbumsViewController: NSViewController, NSWindowDelegate {
    
    private static let numberOfAlbumsDefaultString = "Number of Albums: "
    private let verticalStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
       }()
    
    // StackView object, will contain the label and fetch button
    private let horizontalStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.alignment = .top
        stackView.distribution = .gravityAreas
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainHorizontalStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.alignment = .top
        stackView.distribution = .gravityAreas
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
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    private let numberOfAlbumsLabel: NSTextField = {
        let label = NSTextField()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = NSFont(name: "Helvetica", size: 16)
        label.stringValue = numberOfAlbumsDefaultString
        label.isBezeled = false
        label.isEditable = false
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    private let searchBar: NSSearchField = {
        let search = NSSearchField()
        search.sendsWholeSearchString = true
        search.translatesAutoresizingMaskIntoConstraints = false
    
        return search
    }()
    
    private let fetchButton: NSButton = {
        let button = NSButton(title: "Fetch", target: self, action: #selector(FetchAlbumsViewController.fetchButtonPressed))
        button.layer?.backgroundColor = NSColor.green.cgColor
        button.contentTintColor = .white
        button.font = NSFont(name: "Helvetica", size: 16)
        button.title = "Fetch"
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button
    }()
    
    private let scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalScroller = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       
        return scrollView
    }()
    
    private let albumsTableView: NSTableView = {
        let table = NSTableView()
        
        table.columnAutoresizingStyle = .lastColumnOnlyAutoresizingStyle
        table.usesAlternatingRowBackgroundColors = true
        table.rowHeight = 100
           
        let coverColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[0].getIdentifier()))
        coverColumn.headerCell.title = coverColumn.identifier.rawValue
        coverColumn.headerCell.title = "Cover"
        coverColumn.headerCell.alignment = .center
        table.addTableColumn(coverColumn)
        table.register(NSNib(nibNamed: "CoverPictureTableCellView", bundle: nil), forIdentifier: coverColumn.identifier)
           
        let nameColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[1].getIdentifier()))
        nameColumn.title = nameColumn.identifier.rawValue
        nameColumn.width = 500
        nameColumn.headerCell.title = "Name"
        nameColumn.headerCell.alignment = .center
        table.addTableColumn(nameColumn)
        table.register(NSNib(nibNamed: "AlbunTableCellView", bundle: nil), forIdentifier: nameColumn.identifier)
         
        let priceColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[2].getIdentifier()))
        priceColumn.title = priceColumn.identifier.rawValue
        priceColumn.headerCell.title = "Price"
        priceColumn.headerCell.alignment = .center
        table.addTableColumn(priceColumn)
        table.register(NSNib(nibNamed: "AlbunTableCellView", bundle: nil), forIdentifier: priceColumn.identifier)
           
        let countryColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[3].getIdentifier()))
        countryColumn.title = countryColumn.identifier.rawValue
        countryColumn.headerCell.title = "Country"
        countryColumn.headerCell.alignment = .center
        table.addTableColumn(countryColumn)
        table.register(NSNib(nibNamed: "AlbunTableCellView", bundle: nil), forIdentifier: countryColumn.identifier)
           
        let releaseDateColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[4].getIdentifier()))
        releaseDateColumn.title = releaseDateColumn.identifier.rawValue
        releaseDateColumn.width = 200
        releaseDateColumn.headerCell.title = "Release Date"
        releaseDateColumn.headerCell.alignment = .center
        table.addTableColumn(releaseDateColumn)
        table.register(NSNib(nibNamed: "AlbunTableCellView", bundle: nil), forIdentifier: releaseDateColumn.identifier)
           
        let genreColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[5].getIdentifier()))
        genreColumn.title = genreColumn.identifier.rawValue
        genreColumn.headerCell.title = "Genre"
        genreColumn.headerCell.alignment = .center
        table.addTableColumn(genreColumn)
        table.register(NSNib(nibNamed: "AlbunTableCellView", bundle: nil), forIdentifier: genreColumn.identifier)
           
        let tracksColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[6].getIdentifier()))
        tracksColumn.title = tracksColumn.identifier.rawValue
        tracksColumn.width = 50
        tracksColumn.headerCell.title = "Tracks #"
        tracksColumn.headerCell.alignment = .center
        table.addTableColumn(tracksColumn)
        table.register(NSNib(nibNamed: "AlbunTableCellView", bundle: nil), forIdentifier: tracksColumn.identifier)
           
        let explicitnessColumn = NSTableColumn(identifier: .init(AlbumColumnNames.allCases[7].getIdentifier()))
        explicitnessColumn.title = explicitnessColumn.identifier.rawValue
        explicitnessColumn.width = 50
        explicitnessColumn.headerCell.title = "Explicitness"
        explicitnessColumn.headerCell.alignment = .center
        table.addTableColumn(explicitnessColumn)
        explicitnessColumn.isEditable = false
        table.register(NSNib(nibNamed: "CheckBoxTableCellView", bundle: nil),
                       forIdentifier: explicitnessColumn.identifier)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
       
    // Properties
    private(set) var viewModel: FetchAlbumsViewModel
    
    // Constants
    private let topBottomMargin: CGFloat = 20
    private let leadingAndTrailingMargin: CGFloat = 25
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        viewModel = FetchAlbumsViewModel(albums: [])
           
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
        super.viewWillAppear()
        // This will let the current view controller to handle NSWindow callbacks
        view.window?.delegate = self
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        searchBar.isEnabled = false
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupHorizontalStackView() {
        horizontalStackView.addArrangedSubview(fetchInformationLabel)
        horizontalStackView.addArrangedSubview(fetchButton)
    }
    
    private func setupVerticalStack() {
        setupHorizontalStackView()
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(numberOfAlbumsLabel)
    }
    
    private func setupMainHorizontalStackView() {
        mainHorizontalStackView.addArrangedSubview(verticalStackView)
        mainHorizontalStackView.addArrangedSubview(searchBar)
        
        view.addSubview(mainHorizontalStackView)
    }
       
    private func setupAlbumsTableView() {
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
        
        scrollView.addSubview(albumsTableView)
        albumsTableView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        albumsTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        albumsTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        mainHorizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingAndTrailingMargin).isActive = true
        mainHorizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingAndTrailingMargin).isActive = true
        mainHorizontalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBottomMargin).isActive = true
        scrollView.topAnchor.constraint(equalTo: mainHorizontalStackView.bottomAnchor, constant: topBottomMargin).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: mainHorizontalStackView.bottomAnchor, constant: topBottomMargin).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupView() {
        title = "Jack Johnson Album fetch utility"
        
        setupVerticalStack()
        setupMainHorizontalStackView()
        setupAlbumsTableView()
        setupConstraints()
        scrollView.documentView = albumsTableView
        searchBar.delegate = self
    }
    
    @objc private func fetchButtonPressed() {
        let dispatchGroup = DispatchGroup()
        
        fetchButton.isEnabled = false
        showSpinner()
        
        // Fetch all the information about each album
        dispatchGroup.enter()
        viewModel.fetchAlbums { [weak self] in
            DispatchQueue.main.async {
                dispatchGroup.leave()
                self?.fetchButton.isEnabled = true
                self?.numberOfAlbumsLabel.stringValue = "\(FetchAlbumsViewController.numberOfAlbumsDefaultString)\(self?.viewModel .albums.count ?? 0)"
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            // Fetch all album's cover
            self.viewModel.fetchAlbumsCoverPicture { [weak self] in
                self?.albumsTableView.reloadData()
                self?.hideSpinner()
                self?.searchBar.isEnabled = true
                self?.searchBar.becomeFirstResponder()
            }
        }
    }
}


// MARK: TableView Data Source

extension FetchAlbumsViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.getNumberOfRows()
    }
}

// MARK: TableView Delegates

extension FetchAlbumsViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let tableColumnIdentifier = tableColumn?.identifier,
            let cell = albumsTableView.makeView(withIdentifier: tableColumnIdentifier, owner: nil) as? NSTableCellView,
            let cellContent = viewModel.getCellContent(cellIdentifier: tableColumnIdentifier.rawValue,
                                                       rowIndex: row) else {
                return nil
        }
        
        switch AlbumColumnNames(rawValue: tableColumnIdentifier.rawValue) {
        case .cover:
            viewModel.fetchAlbunCoverForIndex(row) { image in
                DispatchQueue.main.async {
                    cell.imageView?.image = image as? NSImage
                }
            }
        
        case .explicitness:
            guard let checkBoxCell = cell as? CheckBoxTableViewCell,
                let cellContentString = cellContent as? String else {
                    return nil
            }
            
            checkBoxCell.checkBox.state = cellContentString.elementsEqual("explicit") ?
                NSControl.StateValue.on : NSControl.StateValue.off
        
        default:
            cell.textField?.stringValue = cellContent as? String ?? "--"
            cell.textField?.alignment =
                tableColumn?.identifier.rawValue == AlbumColumnNames.allCases[1].getIdentifier() ? .left : .center
        }
        
        return cell
    }
}

// MARK: SearchTextField Delegates

extension FetchAlbumsViewController: NSSearchFieldDelegate, NSTextFieldDelegate {

    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        viewModel.createAlbumsBackup()
        viewModel.lookupForString(filerWith: sender.recentSearches.popLast() ?? "")
        albumsTableView.reloadData()
        numberOfAlbumsLabel.stringValue = "\(FetchAlbumsViewController.numberOfAlbumsDefaultString)\(viewModel.albums.count)"
    }
    
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        viewModel.removeAlbumsBackup()
        albumsTableView.reloadData()
        numberOfAlbumsLabel.stringValue = "\(FetchAlbumsViewController.numberOfAlbumsDefaultString)\(viewModel.albums.count)"
    }
}
