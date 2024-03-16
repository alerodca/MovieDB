//
//  Extensions.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 16/3/24.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        // Verificar si la URL es válida
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        // Descargar la imagen
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            // Convertir los datos descargados en una imagen
            if let image = UIImage(data: data) {
                // Actualizar la UI en el hilo principal
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

