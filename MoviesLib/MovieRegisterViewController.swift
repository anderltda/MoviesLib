//
//  MovieRegisterViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 18/02/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import UIKit
import CoreData

class MovieRegisterViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tfCategories: UITextField!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var ivPoster: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            
            tfTitle.text = movie.title
            tfRating.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tfCategories.text = movie.categories
            tvSummary.text = movie.summary
            btAddEdit.setTitle("Alterar", for: .normal)
            
        }
        
    }
    
    @IBAction func addEditMovie(_ sender: UIButton) {
        
        if movie == nil {
            movie = Movie(context: context)
        }

        movie?.title = tfTitle.text
        movie?.rating = Double(tfRating.text!) ?? 0
        movie?.duration = tfDuration.text
        movie?.summary = tvSummary.text
        movie?.categories = tfCategories.text
        
        do {
            
            try context.save()
            navigationController?.popViewController(animated: true)
            
        } catch {
            print(error)
        }
    }
    
    @IBAction func selectPoster(_ sender: Any) {
        
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde voce quer escolher o poster?", preferredStyle: .alert)
        
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
