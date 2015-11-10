//
//  ViewController.swift
//  convertidorDolares
//
//  Created by Elias Schroh Cruces on 31-10-15.
//  Copyright © 2015 Elias Schroh Cruces. All rights reserved.
//

import UIKit

class convertidorDolares: UIViewController {

    var valorDeDolar = 1.0
    var precio = 1.0
  
    
    
    @IBOutlet weak var resultadoPesos: UILabel!


    
    @IBOutlet weak var valorDolarText: UITextField!
    
    
    @IBOutlet weak var valorPrecioDolares: UITextField!
    
    @IBAction func llamarValor(sender: UIButton) {
        let apiUrl = ("http://indicadoresdeldia.cl/webservice/indicadores.json")
        
        let url = NSURL(string: apiUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if(error != nil) {
                // Imprimir descripcion del error si es que error NO esta vacio
                print(error!.localizedDescription)
            }else{
                
                let nsdata:NSData = NSData(data: data!)
                
                //print(nsdata)
                
                do{
                    
                    let jsonCompleto = try NSJSONSerialization.JSONObjectWithData( nsdata, options: NSJSONReadingOptions.MutableContainers)
                    
                    
                    // print("Json Completo\(jsonCompleto)")
                    
                    let arregloJsonList = jsonCompleto["moneda"] as! NSDictionary
                    
                    print("Arreglo moneda \(arregloJsonList)")
                    
                    // hasta aqui voy bien
                   
                    //Itinerar por todo nuestro arregloJsonList
                    
                    let valorDolar = arregloJsonList["dolar"] as! String
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.valorDolarText.text? = valorDolar.stringByReplacingOccurrencesOfString("$", withString: "") } )
            print(self.valorDolarText.text!)
                }catch{
                    
                    print("Error al serializar Json")
                }
               
            }
        })
        task.resume()
    }
   
    func asignarDatos(nsdata:NSData){
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func convertirDolares(sender: AnyObject) {
        
     
        
        let transformaValor = self.valorDolarText.text!.stringByReplacingOccurrencesOfString("$", withString: "")
        
        precio = Double(valorPrecioDolares.text!)!
        valorDeDolar = (transformaValor as NSString).doubleValue
        
        
        let resultado = valorDeDolar * precio
        print(resultado)
        
        resultadoPesos.text = ("\(resultado) pesos")

    }
    
    
}

