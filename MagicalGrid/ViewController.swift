
import UIKit

class ViewController: UIViewController {
    
    var cell = [String:UIView]()
    var pic_arr = ["British_Shorthair.jpg","Sphynx.jpg",
                   "Maine_Coon.jpg","Persian_cat.jpg",
                   "Siamese.jpg","Ragdoll.jpg",
                   "Savannah_cat.jpg","Munchkin.jpg",
                   "Felis_silvestris_catus.jpg","Bengal_cat.jpg",
                   "Norway_Cat.jpg","Russian_Blue.jpg",
                   "Siberian_cat.jpg","Turkey_angora.jpg"]
    var viewNumForx:CGFloat?
    var viewNumFory:CGFloat?
    let width = CGFloat(40)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewNumForx = view.bounds.width / width
        viewNumFory = view.bounds.height / width
        for j in 0 ... Int(viewNumFory!){
            for i in 0 ... Int(viewNumForx!){
                
                let cellView = UIView()
                cellView.backgroundColor = UIColor.white
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                view.addSubview(cellView)
                let key = "\(i)|\(j)"
                cell[key] = cellView
            }
        }
        //写真をランダムでいれる
        var arrPicPostion = [String]()
        for pic in pic_arr{
            var i = Int.random(in: 0 ... Int(viewNumForx!))
            var j = Int.random(in: 0 ... Int(viewNumFory!))
            while arrPicPostion.contains("\(i)|\(j)"){
                i = Int.random(in: 0 ... Int(viewNumForx!))
                j = Int.random(in: 0 ... Int(viewNumFory!))
            }
            arrPicPostion.append("\(i)|\(j)")
            guard let cellForImg = cell["\(i)|\(j)"] else {return}
            let imgView = UIImageView()
            imgView.image = UIImage(named: pic)
            imgView.frame.size.height = width
            imgView.frame.size.width = width
            cellForImg.addSubview(imgView)
            imgView.frame.origin.x = 0
            imgView.frame.origin.y = 0
            
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    var selectedView:UIView?
    var strArr = ["","","0"]  //x座標、y座標、開いてるかどうか
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        let key = "\(i)|\(j)"
        guard let cellView = cell[key] else {return}
        
        view.bringSubviewToFront(cellView)
        
        if selectedView != cellView{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedView?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedView = cellView
        strArr[0] = "\(i)"; strArr[1] = "\(j)"; strArr[2] = "1";
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(5, 5, 5)
        }, completion: nil)
        print(strArr)
    }
    
    @objc func handleTap(gesture: UIGestureRecognizer){
        let location = gesture.location(in: view)
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        let key = "\(i)|\(j)"
        guard let cellView = cell[key] else {return}
        view.bringSubviewToFront(cellView)
        if selectedView == cellView{
            if strArr[2] == "0"{
                strArr[2] = "1"
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    cellView.layer.transform = CATransform3DMakeScale(5, 5, 5)
                }, completion: nil)
            }else{
                strArr[2] = "0"
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    cellView.layer.transform = CATransform3DIdentity
                }, completion: nil)
            }
        }else{
            strArr[0] = "\(i)"; strArr[1] = "\(j)"; strArr[2] = "1";
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedView?.layer.transform = CATransform3DIdentity
            }, completion: nil)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DMakeScale(5, 5, 5)
            }, completion: nil)
        }
        selectedView = cellView
        print(strArr)
    }
    

    
    
    fileprivate func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }


}

