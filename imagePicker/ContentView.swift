
//
//  Created by Marcos Manzo.
//

import SwiftUI
import PhotosUI
struct ContentView: View {
    @StateObject var photo = PhotoViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView(.horizontal){
                    HStack {
                        ForEach(photo.image){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        }
                    }
                }
                
                PhotosPicker(selection: $photo.photoSelection, matching: .images, photoLibrary: .shared()){
                    Label("Seleccionar foto", systemImage: "photo")
                }
                
            }.navigationTitle("Photos UI")
        }
    }
}

extension Image: Identifiable {
    public var id : String {
        UUID().uuidString
    }
}

class PhotoViewModel : ObservableObject {
    
    @Published var image = [Image(systemName: "photo")]
    @Published var photoSelection: PhotosPickerItem? {
        didSet {
            if let photoSelection {
                loadTransfer(photoSelection: photoSelection)
            }
        }
    }
    
    func loadTransfer(photoSelection: PhotosPickerItem){
        photoSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard photoSelection == self.photoSelection else { return }
                switch result {
                case .success(let data):
                    let image = UIImage(data: data!)
                    self.image.append(Image(uiImage: image!))
                case .failure(let error):
                    print("fallo la transferencia", error.localizedDescription)
                    self.image.append(Image(systemName: "xmark.octagon.fill"))
                }
            }
        }
    }
    
}


