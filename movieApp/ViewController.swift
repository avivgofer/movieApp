//
//  ViewController.swift
//  movieApp
//
//  Created by    aviv gofer on 04/01/2019.
//  Copyright © 2019 aviv gofer. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var moviesTableView: UITableView!
    var moviesList = [Movie]()
    var filteredMovies = [Movie]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        //self.moviesTableView.separatorStyle = .none
        loadMovies()
    }
    
    func loadMovies(){
        Model.instance.getAllMovies(){(movies) in
            self.moviesList = movies
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = moviesList.filter({( movie : Movie) -> Bool in
            return movie.name.lowercased().contains(searchText.lowercased())
        })
        moviesTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }
        return moviesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as!
        movieTableViewCell
        let movie: Movie
        if isFiltering() {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = moviesList[indexPath.row]
        }
        cell.movieName.text = movie.name
        cell.movieCategory.text = movie.category
        cell.movieYear.text = movie.year
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpecificMovieViewController") as? SpecificMovieViewController
        {
            Model.instance.getFullMovieById(id:self.moviesList[indexPath[1]].id){(fullMovie) in
                DispatchQueue.main.async {
                    vc.movie = fullMovie
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

