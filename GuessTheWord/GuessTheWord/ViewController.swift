//
//  ViewController.swift
//  GuessTheWord
//
//  Created by Adarsh Singh on 29/08/23.
//

import UIKit

class ViewController: UIViewController {

    var quesLbl: UILabel!
    var ansTxt: UITextField!
    var letterBtns = [UIButton]()
    var scoreLabel: UILabel!
    var activatedBtn = [UIButton]()
    let word = ["geeks","form","geeky", "ancestor","portal",
                "towards","learn", "cannibal","bellopia","computer",
                "science", "zoom","yup","fire","in",
                "belive","data","goalkeeper"]
    var str:String!
    var usedLetters = [""]
    var promptAns = ""
    
    var Gametry = 0

    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var newPrompt: String!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        quesLbl = UILabel()
        quesLbl.translatesAutoresizingMaskIntoConstraints = false
        quesLbl.font = UIFont.systemFont(ofSize: 32)
        quesLbl.text = "Question"
        quesLbl.numberOfLines = 0
        quesLbl.textAlignment = .center
        quesLbl.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        view.addSubview(quesLbl)
        
        
        ansTxt = UITextField()
        ansTxt.translatesAutoresizingMaskIntoConstraints = false
        ansTxt.font = UIFont.systemFont(ofSize: 28)
        ansTxt.textAlignment = .center
        ansTxt.placeholder = "Letter"
        ansTxt.isUserInteractionEnabled = false
        ansTxt.setContentHuggingPriority(UILayoutPriority(2), for: .vertical)
        
        view.addSubview(ansTxt)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("Clear", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
       
        view.addSubview(submit)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            quesLbl.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 50),
            quesLbl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 90),
            quesLbl.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5, constant: -10),
            quesLbl.heightAnchor.constraint(equalToConstant: 100),
            
            ansTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ansTxt.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            ansTxt.topAnchor.constraint(equalTo: quesLbl.bottomAnchor, constant: 80),
            
            
            submit.topAnchor.constraint(equalTo: ansTxt.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 380),
            buttonsView.heightAnchor.constraint(equalToConstant: 300),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            
           
            
        ])
       
        
        
        let width = 80
        let height = 50
        
        for row in 0..<6{
            for col in 0..<5{
                let letbtn = UIButton(type: .system)
                letbtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                letbtn.setTitle("A", for: .normal)
                letbtn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: col*width, y: row*height, width: width, height: height)
                
                letbtn.frame = frame
                
                buttonsView.addSubview(letbtn)
                
                letterBtns.append(letbtn)
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performSelector(inBackground: #selector(loadLevel), with: nil)
//        quesLbl.text = promptAns
    }
    
    @objc
    func clearTapped(){
        ansTxt.text = ""
        for i in activatedBtn{
            i.isHidden = false
        }
        activatedBtn.removeAll()
    }
    @objc
    func submitTapped(){
        usedLetters.append(ansTxt.text!)
        newPrompt = promptAns
        clearTapped()
        promptAns.removeAll()
        if Gametry<7{
            for letter in str{
                let strLetter = String(letter)
                
                if usedLetters.contains(strLetter){
                    
                    promptAns += strLetter
                    
                }
                else{
                    promptAns += "?"
                }
                

                
            }
            if promptAns.elementsEqual(newPrompt){
                score -= 1
                clearTapped()
                showError()
            }else{
                score += 1
            }
            
            
            Gametry += 1
            
            if promptAns.elementsEqual(str) {
                winAlert()
                
            }
            quesLbl.text = promptAns
            

        }else{
            let ac = UIAlertController(title: "You Loose", message: "Haar Gaya Veere", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            ac.addAction(UIAlertAction(title: "Dubara Khel", style: .default){action in
                self.Gametry = 0
//                self.loadView()
                self.score = 0
                self.usedLetters.removeAll()
                self.loadLevel()
            })
            present(ac,animated: true)
        }
         
        
        
        
        
        
        
    }
    
    func winAlert(){
        let ac = UIAlertController(title: "You Win!", message: "Ye le 🏆", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Dubara Khel", style: .default){action in
            self.Gametry = 0
//            self.loadView()
            self.score = 0
            self.usedLetters.removeAll()
            self.promptAns.removeAll()
            self.loadLevel()
        })
        present(ac, animated: true)
    }
    
    func showError(){
        let ac = UIAlertController(title: "Wrong Input!", message: "😝", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
    @objc
    func letterTapped(_ sender: UIButton){
        guard let btnTitle = sender.titleLabel?.text else {return}
        ansTxt.text = ansTxt.text?.appending(btnTitle).lowercased()
        
        activatedBtn.append(sender)
        sender.isHidden = true
        
    }
    @objc
    func loadLevel(){
                str = word.randomElement()
        for _ in str{
              promptAns += "?"
            }
        
        
        
        
        let letterBits = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","","", "",""]
        DispatchQueue.main.async {
            [weak self] in
            if letterBits.count == self?.letterBtns.count{
                for i in 0..<letterBits.count{
                    self?.letterBtns[i].setTitle(letterBits[i], for: .normal)
                }
            }
            self?.quesLbl.text = self?.promptAns
        }

    }


}

