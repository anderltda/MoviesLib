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
            ivPoster.image = movie.image as? UIImage
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
        movie?.image = ivPoster.image
        
        do {
            
            try context.save()
            navigationController?.popViewController(animated: true)
            
        } catch {
            print(error)
        }
    }
    
    func selectPicture(sourde: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourde
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func selectPoster(_ sender: Any) {
        let alert = UIAlertController(title: "Selecionar poster",
                                      message: "De onde voce quer escolher o poster?",
                                      preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.selectPicture(sourde: .camera)
        }
        
        alert.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (_) in
            self.selectPicture(sourde: .photoLibrary)
        }
        
        alert.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in
           
            
        }
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        

        ivPoster.resignFirstResponder()
        tvSummary.resignFirstResponder()
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

extension MovieRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
           
            ivPoster.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
