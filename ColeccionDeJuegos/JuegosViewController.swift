//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by Mariam Apaza on 5/18/21.
//  Copyright © 2021 Mariam Apaza. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{

    //Outlets
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var eliminarboton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var juego:Juego? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        button.layer.cornerRadius = 5
        
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as  Data)
            tituloTextField.text = juego!.titulo
            button.setTitle("Actualizar",for: .normal)
        }else{
            eliminarboton.isHidden = true
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)


    }
    
    
    
    //Botones Acciones
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true,
                completion: nil)
        
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil{
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context:context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
        }

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
}
