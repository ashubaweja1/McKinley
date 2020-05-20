//
//  DetailViewController.swift
//  Test
//
//  Created by Ashu Baweja on 29/11/19.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView?
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieActors: UILabel!
    @IBOutlet weak var movieWriters: UILabel!
    @IBOutlet weak var movieDirectors: UILabel!
    @IBOutlet weak var movieAwards: UILabel!
    @IBOutlet weak var movieCountry: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieRated: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movie?.title
        configureData()
    }
    
    func configureData(){
        configurePoster()
        
        movieTitle.text = movie?.title
        movieGenre.text = movie?.genre
        movieActors.text = movie?.actors
        movieWriters.text = movie?.writer
        movieDirectors.text = movie?.director
        movieAwards.text = movie?.awards
        movieCountry.text = movie?.country
        movieLanguage.text = movie?.language
        movieRated.text = movie?.rated
        moviePlot.text = movie?.plot
        movieRuntimeLabel.text = movie?.runtime
        movieReleaseYearLabel.text = movie?.released
    }
    
    func configurePoster(){
        movieImage?.image = UIImage(named: "placeHolder")
        let fileURL = MovieHandler.getFileUrl(imageName: movie?.title ?? "")
        
        // Check if image exists in directory else download and save to directory
        if MovieHandler.checkIfImageExists(fileURL: fileURL) {
            DispatchQueue.main.async {
                let imageUrl = MovieHandler.getFileUrl(imageName: self.movie?.title ?? "")
                let image = MovieHandler.getImageFromDirectory(path: imageUrl.path)
                self.movieImage?.image = image
            }
        }
        else  if let imageUrl = movie?.poster, let url = URL(string: imageUrl.trim()) {
            weak var weakSelf = self
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        weakSelf?.movieImage?.image = UIImage(data: data)
                        MovieHandler.saveImageToDirectory(data: data, imageName: weakSelf?.movie?.title ?? "")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
